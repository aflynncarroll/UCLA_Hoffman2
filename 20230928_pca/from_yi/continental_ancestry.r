suppressPackageStartupMessages({
    library(bigsnpr)
    library(ggplot2)
    library(readr)
    library(tidyverse)
    library(optparse)
    source('plot-grid2.r')
})
parser <- OptionParser()
parser <- add_option(parser,
  "--plink",
  action = "store", type = "character", default = '/opt/genomics/tools/plink-1.90-x86_64/plink190'
)
parser <- add_option(parser,
  "--plink2",
  action = "store", type = "character", default = '/opt/genomics/IPHinvestigators/bogdanlab/shared_software/plink2'
)
parser <- add_option(parser,
  "--onekg_bfile",
  action = "store", type = "character", default =  '/opt/genomics/IPHinvestigators/bogdanlab/onekg_data/hg38_phase2_qced/geno/onekg.chrall.phase2.qced.bed'
)
parser <- add_option(parser,
  "--onekg_info_file",
  action = "store", type = "character", default = '/opt/genomics/IPHatlasreleases/ucla_atlas/qc_genotypes_archive/plink/06_18_2021/06_18_2021.qc5.bed'
)
parser <- add_option(parser,
  "--atlas_bfile",
  action = "store", type = "character", default = '/opt/genomics/IPHatlasreleases/ucla_atlas/qc_genotypes_archive/plink/06_18_2021/06_18_2021.qc5.bed'
)
parser <- add_option(parser,
  "--out_dir",
  action = "store", type = "character", default = NULL
)

parser <- add_option(parser,
  "--K",
  action = "store", type = "integer", default = 20
)
parser <- add_option(parser,
  "--ncores",
  action = "store", type = "integer", default = 10
)
parser <- parse_args(parser)


# parser <- list(
#     ncores = 40,
#     K = 20,
#     plink = '/opt/genomics/tools/plink-1.90-x86_64/plink190',
#     plink2 = '/opt/genomics/IPHinvestigators/bogdanlab/shared_software/plink2',
#     onekg_bfile = '/opt/genomics/IPHinvestigators/bogdanlab/onekg_data/hg38_phase2_qced/geno/onekg.chrall.phase2.qced.bed',
#     atlas_bfile = '/opt/genomics/IPHatlasreleases/ucla_atlas/qc_genotypes_archive/plink/06_18_2021/06_18_2021.qc5.bed',
#     onekg_info_file = '/opt/genomics/IPHinvestigators/bogdanlab/onekg_data/20130606_g1k_3202_samples_ped_population.txt',
#     out_dir='test'
# )


# load bed file 
(onekg_bed <- bed(parser$onekg_bfile))
(atlas_bed <- bed(parser$atlas_bfile))

# pca 
obj.svd  <- bed_projectPCA(
    obj.bed.ref = onekg_bed,
    obj.bed.new = atlas_bed,
    k = parser$K,
    strand_flip = TRUE,
    join_by_pos = TRUE,
    match.min.prop = 0.5,
    build.new = "hg38",
    build.ref = "hg38",
    verbose = TRUE,
    ncores = parser$ncores
)

saveRDS(obj.svd, file.path(parser$out_dir, 'pca-model.rds'))

# check loadings
plot_check_loadings <- plot(obj.svd$obj.svd.ref, type = "loadings", loadings = 1:parser$K, coeff = 0.6)
ggsave(file.path(parser$out_dir, 'plot-check-loadings.pdf'), width = 20, height = 10)

# get pcs
atlas_pcs<- obj.svd$OADP_proj
colnames(atlas_pcs) <- paste0('PC', 1:parser$K)
atlas_pcs_df <- as.data.frame(atlas_pcs)
atlas_pcs_df$FID <- as.character(atlas_bed$fam$family.ID)
atlas_pcs_df$IID <- as.character(atlas_bed$fam$sample.ID)
atlas_pcs_df$data <- 'ATLAS'

onekg_pcs <- predict(obj.svd$obj.svd.ref)
colnames(onekg_pcs) <- paste0('PC', 1:parser$K)
onekg_pcs_df <- as.data.frame(onekg_pcs)
onekg_pcs_df$FID <- as.character(onekg_bed$fam$family.ID)
onekg_pcs_df$IID <- as.character(onekg_bed$fam$sample.ID)
onekg_pcs_df$data <- '1000Genome'

# compute pairwise fst and dist 
onekg_info <- read_delim(parser$onekg_info_file, delim = ' ', col_types = cols())
pop <- onekg_bed$fam %>% left_join(onekg_info, by = c('sample.ID' = 'SampleID')) %>% pull(Superpopulation)
onekg_pcs_df$ancestry= pop
ind_pop <- split(seq_along(pop), pop)


## get center 
list_pop_center <- lapply(ind_pop, function(ind) colMeans(onekg_pcs[ind,]))
dist <- c()
for (i in seq(4)){
    for (j in seq(i+1, 5, 1)){
        dist <- c(dist, sum((list_pop_center[[i]] - list_pop_center[[j]])**2))
    }
}
                          
## get allele frequency
list_pop_af <- lapply(ind_pop, function(ind) bed_MAF(onekg_bed, ind, ind.col = attr(obj.svd$ obj.svd.ref, 'subset')))
fst <- c()
pair <- c()
for (i in seq(4)){
    for (j in seq(i+1, 5, 1)){
        fst <- c(fst, snp_fst(list_pop_af[c(i, j)], overall = TRUE))
        pair <- c(pair, paste0(names(list_pop_af)[i], '_', names(list_pop_af)[j]))
    }
}
print(paste0('minimal fst: ', pair[which.min(fst)], ' ', min(fst)))
print(paste0('maximal fst: ', pair[which.max(fst)], ' ', max(fst)))
print(paste0('sq distance threshold: ', max(dist) * min(fst) / max(fst)/2))
## save fst and dist plot 
plot_fst_dist <- qplot(dist, fst, label = pair) + 
    theme_bigstatsr(size = 1)   + annotate("text",x = dist, y = fst, label = pair)
ggsave(file.path(parser$out_dir, 'plot-fst-dist.pdf'), plot_fst_dist, width = 6, height = 4)        

                                                    
# call GIA in ATLAS
atlas_sq_dist <- as.data.frame(lapply(list_pop_center,  function(one_center) rowSums(sweep(atlas_pcs, 2, one_center, '-')^2)))
group <- colnames(atlas_sq_dist)

ancestry <- apply(atlas_sq_dist, 1, function(sq_dist) {
    ind <- which.min(sq_dist)
    if ((group[ind] == 'AMR' | group[ind] == 'AFR')) {
        group[ind] # if anyone is closest to AMR or AFR, it's classified into AMR/AFR, there's no distance threshold
    }else if(sq_dist[ind] < max(dist) * min(fst)/max(fst) * 0.5 ) {
        group[ind] # for EUR, SAS and EAS, we apply a more stringent distance threshold
    }else{
        NA
    }
})
ancestry[is.na(ancestry)] <- 'Unclassified'
atlas_pcs_df$ancestry <- ancestry
table(ancestry)


                                      
# save results
pcs_df <- bind_rows(atlas_pcs_df, onekg_pcs_df) %>% relocate(starts_with('PC'), .after = last_col())
pcs_df %>% write_tsv(file.path(parser$out_dir, 'atlas-onekg-pcs-ancestry.tsv'))
for(anc in c('EUR', 'AMR', 'SAS', 'EAS', 'AFR')){
    pcs_df %>% filter(data == 'ATLAS', ancestry == anc) %>% select(FID, IID) %>% 
        write_tsv(file.path(parser$out_dir, paste0( 'atlas.', anc, '.list')))
}

                  
# draw some pretty figures 
## check onekgatlas alignment
plot_onekg_atlas <-plot_grid2(plotlist = lapply(1:min(10, parser$K), function(k) {
    k1 <- k
    k2 <- k+1
    qplot(pcs_df[,paste0('PC', k1)], pcs_df[,paste0('PC', k2)], color = pcs_df$data, size = I(2)) +
        theme_bigstatsr(0.6) +
        labs(x = paste0("PC", k1), y = paste0("PC", k2), color = "dataset") +
        coord_equal()
}), nrow = 2, legend_ratio = 0.2, title_ratio = 0)
ggsave(file.path(parser$out_dir, 'plot-check-onekg-atlas-alignment.pdf'), plot_onekg_atlas, width = 20, height = 5)

# color onekg ancestry
pcs_df <- pcs_df %>% mutate(onekg_ancestry = replace(ancestry, data == 'ATLAS', 'ATLAS'))
color <- alpha(c("EUR" = "#B5E48C",  "AMR" = "#F79661", "SAS" = "#815ac0", "EAS" = "#6183C2","AFR" = "#C46363", "ATLAS" = "#6d6875"), 0.5)
plot_onekg_ancestry <-plot_grid2(plotlist = lapply(1:min(5, parser$K), function(k) {
    k1 <- k
    k2 <- k+1
    qplot(pcs_df[,paste0('PC', k1)], pcs_df[,paste0('PC', k2)], color = pcs_df$onekg_ancestry, size = I(2)) +
        theme_bigstatsr(0.6) + scale_colour_manual(values = color) + 
        labs(x = paste0("PC", k1), y = paste0("PC", k2), color = "GIA") +
        coord_equal()
}), nrow = 1, legend_ratio = 0.2, title_ratio = 0)
ggsave(file.path(parser$out_dir, 'plot-check-onekg-ancestry-over-atlas.pdf'), plot_onekg_ancestry, width = 20, height = 5)

# atlas pcs plot 
color <- alpha(c("EUR" = "#B5E48C",  "AMR" = "#F79661", "SAS" = "#815ac0", "EAS" = "#6183C2","AFR" = "#C46363", "Unclassified" = "#6d6875"), 0.5)
plot_atlas_ancestry <-plot_grid2(plotlist = lapply(1:min(5, parser$K), function(k) {
    k1 <- k
    k2 <- k+1
    qplot(atlas_pcs_df[,paste0('PC', k1)], atlas_pcs_df[,paste0('PC', k2)], color = atlas_pcs_df$ancestry, size = I(2)) +
        theme_bigstatsr(0.6) + scale_colour_manual(values = color) + 
        labs(x = paste0("PC", k1), y = paste0("PC", k2), color = "GIA") +
        coord_equal()
}), nrow = 1, legend_ratio = 0.2, title_ratio = 0)
ggsave(file.path(parser$out_dir, 'plot-atlas-pcplot.pdf'), plot_atlas_ancestry, width = 20, height = 5)
