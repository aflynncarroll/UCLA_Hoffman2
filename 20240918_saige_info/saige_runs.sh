# SAIGE Script


#/u/project/geschwind/vishakha/Projects/GWAS_AFR/data/ACE_SPARK/SPARK_AFR_data/code/2_SAIGE.sh 

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






# /u/project/geschwind/vishakha/Projects/GWAS_AFR/data/ACE_SPARK/ACE_AFR_data/code/3_SAIGE.sh


table(covar_file$ASD)
# 1 = unaffected, 2=ASD
#  1   2 
#618 474 
table(covar_file$Sex)
#  1   2 
#724 420 

#dir for Saige tool : cd /u/project/geschwind/vishakha/Projects/GWAS_AFR/data/ACE_SPARK/SAIGE_tool/SAIGE/extdata   
#R (default 4.3.2) # check the library(SAIGE) and exit
# Do rest steps on command line
module load gcc
module load cmake

Rscript step1_fitNULLGLMM.R --useSparseGRMtoFitNULL=FALSE --plinkFile=/u/project/geschwind/vishakha/Projects/GWAS_AFR/data/ACE_SPARK/ACE_AFR_data/ACE_AFR --phenoFile=/u/project/geschwind/vishakha/Projects/GWAS_AFR/data/ACE_SPARK/ACE_AFR_data/ACE_covariate_file_re.txt --skipVarianceRatioEstimation=FALSE --phenoCol=ASD --covarColList=Age,Sex,PC1,PC2,PC3,PC4,PC5,PC6,PC7,PC8,PC9,PC10 --qCovarColList=Sex --sampleIDColinphenoFile=IID --traitType=binary --outputPrefix=/u/project/geschwind/vishakha/Projects/GWAS_AFR/data/ACE_SPARK/ACE_AFR_data/SAIGE_RESULT/ACE_AFR_SAIGE_step1_GLMM_binary_sparseGRM_vr --IsOverwriteVarianceRatioFile=FALSE

# Step 2:
# for Binary traits perform single-varinat association test:
#chr=${SGE_TASK_ID} 
#chr=22
for chr in {1..22}
do
Rscript step2_SPAtests.R        \
        --vcfFile=/u/project/geschwind/vishakha/Projects/GWAS_AFR/data/ACE_SPARK/ACE_AFR_data/merged_ace_afr.vcf.gz  \
        --vcfFileIndex=/u/project/geschwind/vishakha/Projects/GWAS_AFR/data/ACE_SPARK/ACE_AFR_data/merged_ace_afr.vcf.gz.csi  \
        --vcfField=GT   \
        --SAIGEOutputFile=/u/project/geschwind/vishakha/Projects/GWAS_AFR/data/ACE_SPARK/ACE_AFR_data/SAIGE_RESULT/ACE_AFR_marker_chr${chr}_vcf.txt \
        --chrom=${chr} \
        --minMAF=0 \
        --minMAC=20 \
        --LOCO=FALSE \
        --GMMATmodelFile=/u/project/geschwind/vishakha/Projects/GWAS_AFR/data/ACE_SPARK/ACE_AFR_data/SAIGE_RESULT/ACE_AFR_SAIGE_step1_GLMM_binary_sparseGRM_vr.rda \
        --varianceRatioFile=/u/project/geschwind/vishakha/Projects/GWAS_AFR/data/ACE_SPARK/ACE_AFR_data/SAIGE_RESULT/ACE_AFR_SAIGE_step1_GLMM_binary_sparseGRM_vr.varianceRatio.txt \
        --is_output_moreDetails=TRUE
done

#concatenate seperate chromosome files

awk 'FNR==1 && NR!=1{next;}{print}' ACE_AFR_marker_chr1_vcf.txt ACE_AFR_marker_chr2_vcf.txt ACE_AFR_marker_chr3_vcf.txt ACE_AFR_marker_chr4_vcf.txt ACE_AFR_marker_chr5_vcf.txt ACE_AFR_marker_chr6_vcf.txt ACE_AFR_marker_chr7_vcf.txt ACE_AFR_marker_chr8_vcf.txt ACE_AFR_marker_chr9_vcf.txt ACE_AFR_marker_chr10_vcf.txt ACE_AFR_marker_chr11_vcf.txt ACE_AFR_marker_chr12_vcf.txt ACE_AFR_marker_chr13_vcf.txt ACE_AFR_marker_chr14_vcf.txt ACE_AFR_marker_chr15_vcf.txt ACE_AFR_marker_chr16_vcf.txt ACE_AFR_marker_chr17_vcf.txt ACE_AFR_marker_chr18_vcf.txt ACE_AFR_marker_chr19_vcf.txt ACE_AFR_marker_chr20_vcf.txt ACE_AFR_marker_chr21_vcf.txt ACE_AFR_marker_chr22_vcf.txt > ACE_AFR_marker_chr1-22_vcf.txt

##############################################################################################################################################

# Manhattan plot:
R
library(qqman)
saige_output <- read.table("/u/project/geschwind/vishakha/Projects/GWAS_AFR/data/ACE_SPARK/ACE_AFR_data/SAIGE_RESULT/ACE_AFR_marker_chr1-22_vcf.txt", sep="\t", header=T)
#str(saige_output)
#'data.frame':   15218976 obs. of  23 variables:
# $ CHR        : int  1 1 1 1 1 1 1 1 1 1 ...
# $ POS        : int  722858 758351 758443 763668 763891 764648 764898 766367 768562 770072 ...
# $ MarkerID   : chr  "chr1:722858:C:T" "chr1:758351:A:G" "chr1:758443:G:C" "chr1:763668:T:C" ...
# $ Allele1    : chr  "C" "A" "G" "T" ...
# $ Allele2    : chr  "T" "G" "C" "C" ...
# $ AC_Allele2 : int  77 359 396 87 26 76 91 92 394 396 ...
# $ AF_Allele2 : num  0.0388 0.1809 0.1996 0.0439 0.0131 ...
# $ MissingRate: num  0.0927 0.12 0.12 0.12 0.1089 ...
# $ BETA       : num  0.1861 0.1424 0.0848 0.1058 0.6139 ...
# $ SE         : num  0.367 0.167 0.16 0.307 0.52 ...
# $ Tstat      : num  1.38 5.1 3.3 1.12 2.27 ...
# $ var        : num  7.43 35.81 38.88 10.62 3.7 ...
# $ p.value    : num  0.612 0.394 0.597 0.73 0.237 ...
# $ p.value.NA : num  0.612 0.394 0.597 0.73 0.237 ...
# $ Is.SPA     : chr  "false" "false" "false" "false" ...
# $ AF_case    : num  0.0353 0.1777 0.1906 0.0493 0.0171 ...
# $ AF_ctrl    : num  0.0419 0.18381 0.20762 0.03905 0.00952 ...
# $ N_case     : int  467 467 467 467 467 467 467 467 467 467 ...
# $ N_ctrl     : int  525 525 525 525 525 525 525 525 525 525 ...
# $ N_case_hom : int  0 18 21 1 0 0 0 0 26 26 ...
# $ N_case_het : int  33 130 136 44 16 38 39 39 136 138 ...
# $ N_ctrl_hom : int  2 18 28 1 0 0 2 2 18 18 ...
# $ N_ctrl_het : int  40 157 162 39 10 38 48 49 170 170 ...

pdf("/u/project/geschwind/vishakha/Projects/GWAS_AFR/data/ACE_SPARK/ACE_AFR_data/SAIGE_RESULT/ACE_AFR_SAIGE.manhat.pdf")
saige_output_ManPlot <- manhattan(saige_output, chr="CHR", bp="POS", snp="MarkerID", p="p.value", ylim = c(1, 10), col=c("#0d0d67", "#7492c8"), annotateTop = TRUE)
dev.off()


# QQ PLOT:
data <- read.table("ACE_AFR_marker_chr1-22_vcf.txt",sep="\t", header = TRUE)
# Extract p-values
observed_pvalues <- data$p.value
# Calculate expected p-values
n <- length(observed_pvalues)
expected_pvalues <- (1:n) / (n + 1)
str(expected_pvalues)
# num [1:15218976] 6.57e-08 1.31e-07 1.97e-07 2.63e-07 3.29e-07 ...
# Sort p-values
observed_pvalues <- sort(observed_pvalues)
expected_pvalues <- sort(expected_pvalues)
pdf("QQ_Plot_ACE_AFR.pdf")
# Plot QQ plot
plot(-log10(expected_pvalues), -log10(observed_pvalues),
     main = "QQ Plot",
     xlab = "Expected -log10(p-value)",
     ylab = "Observed -log10(p-value)",
     col = "blue",
     pch = 19)

# Add diagonal line
abline(0, 1, col = "red")
dev.off()

# This is the better qq plot with lambda value
# Alternative code: 
jpeg(filename = "QQ_plot_ace_asd.jpeg", width = 31, height = 31, units="cm", res=500, type="cairo")
alpha<-median(qchisq(1-data$p.value,1))/qchisq(0.5,1)
str(alpha)
# num 0.994
alpha
#[1] 0.9941437
library(qqman)
qq(data$p.value)
text(0.5,4, paste("lambda","=",  signif(alpha, digits = 3)) )
dev.off()