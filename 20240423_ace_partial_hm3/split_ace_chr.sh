#!/bin/bash -l
#$ -N rfmix_spark
#$ -cwd
#$ -l h_data=140G,h_rt=16:00:00,highp
#$ -j y
#$ -o ./job_out
#$ -t 1-22


. /u/local/Modules/default/init/modules.sh
module load anaconda3/2020.11
conda activate plink2_env

mkdir /u/project/geschwind/shared/GenomicDatasets-processed/Imputed/total_vcfs_r2_0.8/combined/hm3_filtered_pfiles

chrom=${SGE_TASK_ID}

#chrom=22
pfile=/u/project/geschwind/shared/GenomicDatasets-processed/Imputed/total_vcfs_r2_0.8/combined/merged_output_2
out_prefix=/u/project/geschwind/shared/GenomicDatasets-processed/Imputed/total_vcfs_r2_0.8/combined/hm3_filtered_pfiles/ace_hm3_chr${chrom}
snp_list=/u/home/a/afcarrol/project-pasaniuc/Projects/20240423_ace_partial_hm3/filtered_snps_hm3.txt
# Define the input P-file and SNP list file

# Subset by chromosome
plink2 --pfile ${pfile} --extract ${snp_list} --chr ${chrom} --make-pgen --out ${out_prefix}

