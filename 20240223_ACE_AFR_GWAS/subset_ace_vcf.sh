

#!/bin/bash
#$ -l h_data=60G,h_rt=14:00:00 -pe shared 4
#$ -e /u/home/a/afcarrol/project-pasaniuc/Projects/20240223_ACE_AFR_GWAS/subset_out
#$ -o /u/home/a/afcarrol/project-pasaniuc/Projects/20240223_ACE_AFR_GWAS/subset_out/joblog.$JOB_ID.$TASK_ID
#$ -m bea
#$ -t 1-22

# load modules

. /u/local/Modules/default/init/modules.sh
module load anaconda3/2020.11
conda activate plink2_env
#module load plink2

#mkdir /u/project/geschwind/shared/GenomicDatasets-processed/Imputed/total_vcfs_r2_0.8/combined/ACE_pgen_chrom

chrom=${SGE_TASK_ID}
vcf_file=/u/project/geschwind/shared/GenomicDatasets-processed/Imputed/total_vcfs_r2_0.8/combined/merged_output_2.vcf.gz
output_prefix=/u/project/geschwind/shared/GenomicDatasets-processed/Imputed/total_vcfs_r2_0.8/combined/ACE_pgen_chrom/ACE_combined_chr${chrom}


plink2 \
    --vcf ${vcf_file} \
    --chr ${chrom} \
    --max-alleles 2 \
    --rm-dup exclude-all \
    --snps-only \
    --make-pgen \
    --out ${output_prefix} \




