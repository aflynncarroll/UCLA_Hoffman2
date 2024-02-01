

# qrsh -l h_data=100G,h_rt=48:00:00

R


library(bigsnpr)
library(ggplot2)
library(readr)
library(dplyr)
#replaced tidy
#install.packages("optparse")
# ‘/work/tmp/Rtmp6U7gCk/downloaded_packages’
library(optparse)

#source('plot-grid2.r')

parser <- OptionParser()
parser <- add_option(parser,
  "--plink",
  action = "store", type = "character", default = '/u/local/apps/plink/1.90b624/plink'
)
parser <- add_option(parser,
  "--plink2",
  action = "store", type = "character", default = '~/.conda/envs/plink2_env/bin/plink2'
)
parser <- add_option(parser,
  "--onekg_bed",
  action = "store", type = "character", default =  '/u/home/a/afcarrol/project-pasaniuc/Projects/20230928_pca/from_yi/onekg.chrall.phase2.qced.bed'
)
#bfile changed to bed

parser <- add_option(parser,
  "--ace_bed",
  action = "store", type = "character", default = '/u/project/geschwind/shared/GenomicDatasets-processed/Imputed/total_vcfs_r2_0.8/combined_hm3_filtered/chr_run/combined/total_hm3_ace.bed'
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

# load bed file 
(onekg_bed <- bed(parser$onekg_bed))
(ace_bed <- bed(parser$ace_bed))

# pca 
obj.svd  <- bed_projectPCA(
    obj.bed.ref = onekg_bed,
    obj.bed.new = ace_bed,
    k = parser$K,
    strand_flip = TRUE,
    join_by_pos = TRUE,
    match.min.prop = 0.5,
    build.new = "hg38",
    build.ref = "hg38",
    verbose = TRUE,
    ncores = parser$ncores
)

saveRDS(obj.svd, file.path(parser$out_dir, '/u/project/geschwind/shared/GenomicDatasets-processed/Imputed/total_vcfs_r2_0.8/combined_hm3_filtered/chr_run/pca-model.rds'))

