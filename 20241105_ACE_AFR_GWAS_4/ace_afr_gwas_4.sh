#!/bin/bash
#$ -N spark_afr_asd_gwas
#$ -e misc      
#$ -o misc      
#$ -cwd     
#$ -r y     
#$ -j y     
#$ -l h_data=100G    
#$ -l time=10:00:00     
#$ -l highp
#$ -t 1 

. /u/local/Modules/default/init/modules.sh
module load anaconda3/2023.03

conda activate plink2_run
#mkdir output_files_ace
#chr=1
#/u/home/a/aflynnca/old-home-afcarrol/afcarrol/project-pasaniuc/Projects/20241105_ACE_AFR_GWAS_4

# Specify the path to your PGEN files (assuming the files are named like chr1.pgen, chr2.pgen, etc.)
pgen_path="/u/project/geschwind/shared/GenomicDatasets-processed/Imputed/total_vcfs_r2_0.8/combined/ACE_pgen_chrom/ACE_combined_chr"

# the path to the phenotype file
phenotype_file="/u/home/a/aflynnca/old-home-afcarrol/afcarrol/project-pasaniuc/Projects/20241105_ACE_AFR_GWAS_4/ace_asd_unre_4.txt"

# Specify the name of the covariate file
covariate_file="/u/home/a/aflynnca/old-home-afcarrol/afcarrol/project-pasaniuc/Projects/20241105_ACE_AFR_GWAS_4/ace_covar_unre_4.txt"

# Specify the path to the subset file
subset_file="/u/home/a/aflynnca/old-home-afcarrol/afcarrol/project-pasaniuc/Projects/20241105_ACE_AFR_GWAS_4/ace_afr_unrelated_4.txt"

# Specify the output directory
output_dir="/u/home/a/aflynnca/old-home-afcarrol/afcarrol/project-pasaniuc/Projects/20241105_ACE_AFR_GWAS_4/output_files_ace"

# Loop through chromosomes 1 to 22
for chr in {1..22}
do
    # Run PLINK for each chromosome
    plink2 \
        --pfile "${pgen_path}${chr}" \
        --logistic \
        --keep "${subset_file}" \
        --pheno "${phenotype_file}" \
        --covar "${covariate_file}" \
        --hwe 1e-12 \
        --maf 0.01 \
        --covar-variance-standardize \
        --out "${output_dir}/ace_asd_afr_gwas_chr${chr}"
done

# Wait for all background processes to finish
wait

echo "GWAS on all chromosomes completed."
