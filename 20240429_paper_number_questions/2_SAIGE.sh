#qrsh -l h_rt=6:00:00,h_data=100G,exclusive -pe node  3 -now n 
#closed the plinkFile!
#Warning message:
#system call failed: Cannot allocate memory 

qrsh -l h_rt=6:00:00,h_data=150G,exclusive -pe node  3 -now n 

cd /u/project/geschwind/shared/GWAS/20240319_spark_saige_data/  

plink --bfile /u/project/geschwind/shared/GWAS/20240319_spark_saige_data/spark_afr --recode vcf-iid --out /u/project/geschwind/vishakha/Projects/GWAS_AFR/data/ACE_SPARK/SPARK_AFR_data/spark_afr 

bcftools view spark_afr.vcf -Oz -o spark_afr.vcf.gz

bcftools index spark_afr.vcf.gz

dir for Saige tool : cd /u/project/geschwind/vishakha/Projects/GWAS_AFR/data/ACE_SPARK/SAIGE_tool/SAIGE/extdata   
R (default 4.3.2) # check the library(SAIGE) and exit
# Do rest steps on command line
module load gcc
module load cmake

# Covariate file = /u/project/geschwind/vishakha/Projects/GWAS_AFR/data/ACE_SPARK/SPARK_AFR_data/covar_file_saige.txt
# plink file = /u/project/geschwind/shared/GWAS/20240319_spark_saige_data/spark_afr
# vcf file = /u/project/geschwind/vishakha/Projects/GWAS_AFR/data/ACE_SPARK/SPARK_AFR_data/spark_afr

Rscript step1_fitNULLGLMM.R --useSparseGRMtoFitNULL=FALSE --plinkFile=/u/project/geschwind/shared/GWAS/20240319_spark_saige_data/spark_afr --phenoFile=/u/project/geschwind/vishakha/Projects/GWAS_AFR/data/ACE_SPARK/SPARK_AFR_data/covar_file_saige.txt --skipVarianceRatioEstimation=FALSE --phenoCol=ASD --covarColList=Age,Sex,PC1,PC2,PC3,PC4,PC5,PC6,PC7,PC8,PC9,PC10 --qCovarColList=Sex --sampleIDColinphenoFile=IID --traitType=binary --outputPrefix=/u/project/geschwind/vishakha/Projects/GWAS_AFR/data/ACE_SPARK/SPARK_AFR_data/SAIGE_RESULT/SPARK_AFR_SAIGE_step1_GLMM_binary_sparseGRM_vr --IsOverwriteVarianceRatioFile=FALSE

# Step 2:
# for Binary traits perform single-varinat association test:
#chr=${SGE_TASK_ID} 
#chr=22
for chr in {1..22}
do
Rscript step2_SPAtests.R        \
        --vcfFile=/u/project/geschwind/vishakha/Projects/GWAS_AFR/data/ACE_SPARK/SPARK_AFR_data/spark_afr.vcf.gz  \
        --vcfFileIndex=/u/project/geschwind/vishakha/Projects/GWAS_AFR/data/ACE_SPARK/SPARK_AFR_data/spark_afr.vcf.gz.csi  \
        --vcfField=GT   \
        --SAIGEOutputFile=/u/project/geschwind/vishakha/Projects/GWAS_AFR/data/ACE_SPARK/SPARK_AFR_data/SAIGE_RESULT/SPARK_AFR_marker_chr${chr}_vcf.txt \
        --chrom=${chr} \
        --minMAF=0 \
        --minMAC=20 \
        --LOCO=FALSE \
        --GMMATmodelFile=/u/project/geschwind/vishakha/Projects/GWAS_AFR/data/ACE_SPARK/SPARK_AFR_data/SAIGE_RESULT/SPARK_AFR_SAIGE_step1_GLMM_binary_sparseGRM_vr.rda \
        --varianceRatioFile=/u/project/geschwind/vishakha/Projects/GWAS_AFR/data/ACE_SPARK/SPARK_AFR_data/SAIGE_RESULT/SPARK_AFR_SAIGE_step1_GLMM_binary_sparseGRM_vr.varianceRatio.txt \
        --is_output_moreDetails=TRUE
done 

awk 'FNR==1 && NR!=1{next;}{print}' SPARK_AFR_marker_chr1_vcf.txt SPARK_AFR_marker_chr2_vcf.txt SPARK_AFR_marker_chr3_vcf.txt SPARK_AFR_marker_chr4_vcf.txt SPARK_AFR_marker_chr5_vcf.txt SPARK_AFR_marker_chr6_vcf.txt SPARK_AFR_marker_chr7_vcf.txt SPARK_AFR_marker_chr8_vcf.txt SPARK_AFR_marker_chr9_vcf.txt SPARK_AFR_marker_chr10_vcf.txt SPARK_AFR_marker_chr11_vcf.txt SPARK_AFR_marker_chr12_vcf.txt SPARK_AFR_marker_chr13_vcf.txt SPARK_AFR_marker_chr14_vcf.txt SPARK_AFR_marker_chr15_vcf.txt SPARK_AFR_marker_chr16_vcf.txt SPARK_AFR_marker_chr17_vcf.txt SPARK_AFR_marker_chr18_vcf.txt SPARK_AFR_marker_chr19_vcf.txt SPARK_AFR_marker_chr20_vcf.txt SPARK_AFR_marker_chr21_vcf.txt SPARK_AFR_marker_chr22_vcf.txt > SPARK_AFR_marker_chr1-22_vcf.txt

R
library(qqman)
saige_output <- read.table(“/u/project/geschwind/vishakha/Projects/GWAS_AFR/data/ACE_SPARK/SPARK_AFR_data/SAIGE_RESULT/SPARK_AFR_marker_chr1-22_vcf.txt", sep="\t", header=T)
str(saige_output)
#'data.frame':   15692297 obs. of  23 variables:
# $ CHR        : int  1 1 1 1 1 1 1 1 1 1 ...
# $ POS        : int  802843 858952 859842 862430 863421 864119 866156 866281 866300 866478 ...
# $ MarkerID   : chr  "rs138388092" "rs12127425" "rs12131377" "rs181395343" ...
# $ Allele1    : chr  "T" "G" "C" "G" ...
# $ Allele2    : chr  "C" "A" "G" "A" ...
# $ AC_Allele2 : int  23 862 357 31 353 354 26 319 319 318 ...
# $ AF_Allele2 : num  0.00306 0.11457 0.04745 0.00412 0.04692 ...
# $ MissingRate: int  0 0 0 0 0 0 0 0 0 0 ...
# $ BETA       : num  0.4901 -0.0104 0.1204 -1.2589 0.1355 ...
# $ SE         : num  0.844 0.139 0.206 0.715 0.208 ...
# $ Tstat      : num  0.688 -0.539 2.841 -2.462 3.131 ...
# $ var        : num  1.4 52.09 23.6 1.96 23.11 ...
# $ p.value    : num  0.5614 0.9404 0.5587 0.0784 0.5148 ...
# $ p.value.NA : num  0.5614 0.9404 0.5587 0.0784 0.5148 ...
# $ Is.SPA     : chr  "false" "false" "false" "false" ...
# $ AF_case    : num  0.00337 0.1114 0.0456 0.00259 0.04482 ...
# $ AF_ctrl    : num  0.00273 0.1179 0.0494 0.00573 0.04913 ...
# $ N_case     : int  1930 1930 1930 1930 1930 1930 1930 1930 1930 1930 ...
# $ N_ctrl     : int  1832 1832 1832 1832 1832 1832 1832 1832 1832 1832 ...
# $ N_case_hom : int  0 20 4 0 4 4 0 3 3 3 ...
# $ N_case_het : int  13 390 168 10 165 166 16 154 154 154 ...
# $ N_ctrl_hom : int  0 29 5 0 5 5 0 4 4 4 ...
# $ N_ctrl_het : int  10 374 171 21 170 170 10 151 151 150 ...

pdf("/u/project/geschwind/vishakha/Projects/GWAS_AFR/data/ACE_SPARK/SPARK_AFR_data/SAIGE_RESULT/SPARK_AFR_SAIGE.manhat.pdf")
saige_output_ManPlot <- manhattan(saige_output, chr="CHR", bp="POS", snp="MarkerID", p="p.value", ylim = c(1, 10), col=c("#0d0d67", "#7492c8"), annotateTop = TRUE)
dev.off()

Alternative code:
# data <- read.table(“SPARK_AFR_marker_chr1-22_vcf.txt",sep="\t", header = TRUE)
library(qqman) 
jpeg(filename = "/u/project/geschwind/vishakha/Projects/GWAS_AFR/data/ACE_SPARK/SPARK_AFR_data/SAIGE_RESULT/QQ_plot_spark_asd.jpeg", width = 31, height = 31, units="cm", res=500, type="cairo")
alpha<-median(qchisq(1-saige_output$p.value,1))/qchisq(0.5,1)
str(alpha)
# num 0.94
qq(saige_output$p.value)
text(0.5,4, paste("lambda","=",  signif(alpha, digits = 3)) )
dev.off()
