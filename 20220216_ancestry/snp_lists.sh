#!/bin/bash
#$ -l h_data=10G,h_rt=14:00:00 -pe shared 4
#$ -e /u/home/a/afcarrol/project-pasaniuc/Projects/16022022_ancestry/logs
#$ -o /u/home/a/afcarrol/project-pasaniuc/Projects/16022022_ancestry/logs/joblog.$JOB_ID.$TASK_ID
#$ -m bea
#$ -t 1-22

# load modules

. /u/local/Modules/default/init/modules.sh
module load anaconda3/2020.11
conda activate myconda 
module load bcftools


# set variables
chrom=${SGE_TASK_ID}
vcf_file=/u/project/pasaniuc/pasaniucdata/pajukanta_mexican_data/mexican2020-9051_imputed/topmed.r2.phased.rsq0.3/chr${chrom}.dose.vcf.gz
snp_list=/u/home/a/afcarrol/project-pasaniuc/Projects/16022022_ancestry/snp_lists/chr${chrom}.snp_list.txt

# summerize data and save
bcftools index ${vcf_file}
bcftools query -f '%CHROM %POS %ID %REF %ALT %AF %MAF %R2\n' ${vcf_file} > ${snp_list}
