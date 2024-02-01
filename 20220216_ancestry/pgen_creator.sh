#!/bin/bash
#$ -l h_data=10G,h_rt=14:00:00 -pe shared 4
#$ -e /u/home/a/afcarrol/project-pasaniuc/Projects/16022022_ancestry/pgen_logs
#$ -o /u/home/a/afcarrol/project-pasaniuc/Projects/16022022_ancestry/pgen_logs/joblog.$JOB_ID.$TASK_ID
#$ -m bea
#$ -t 1-22

# load modules

. /u/local/Modules/default/init/modules.sh
module load anaconda3/2020.11
conda activate plink2_env
#module load plink2


# set variables
chrom=${SGE_TASK_ID}
vcf_file=/u/project/pasaniuc/pasaniucdata/pajukanta_mexican_data/mexican2020-9051_imputed/topmed.r2.phased.rsq0.3/chr${chrom}.dose.vcf.gz
snp_list=/u/home/a/afcarrol/project-pasaniuc/Projects/16022022_ancestry/format_snp_list/updated_lists/chr${chrom}.snp_list.txt

out_dir=/u/home/a/afcarrol/project-pasaniuc/Projects/16022022_ancestry/pgen_files

plink2 --vcf ${vcf_file} \
    --extract ${snp_list} \
    --chr ${chrom} \
    --max-alleles 2 \
    --rm-dup exclude-all \
    --snps-only \
    --make-pgen \
    --out ${out_dir}/chr${chrom}
