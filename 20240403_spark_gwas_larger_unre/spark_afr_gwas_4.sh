#!/bin/bash
#$ -N spark_afr_asd_gwas
#$ -e misc      
#$ -o misc      
#$ -cwd     
#$ -r y     
#$ -j y     
#$ -l h_data=60G    
#$ -l time=10:00:00     
#$ -l highp
#$ -t 1 

. /u/local/Modules/default/init/modules.sh
module load anaconda3/2023.03

conda activate plink2_env

#mkdir output_files
# cd /u/home/a/afcarrol/project-pasaniuc/Projects/20240403_spark_gwas_larger_unre

# Specify the path to your PGEN files (assuming the files are named like chr1.pgen, chr2.pgen, etc.)
pgen_path="/u/project/geschwind/shared/GenomicDatasets-processed/ACE-ANALYSIS/freeze0/SPARK/imputed"

# the path to the phenotype file
phenotype_file="/u/home/a/afcarrol/project-pasaniuc/Projects/20240403_spark_gwas_larger_unre/spark_asd_unre_4.txt"

# Specify the name of the covariate file
covariate_file="/u/home/a/afcarrol/project-pasaniuc/Projects/20240403_spark_gwas_larger_unre/spark_covar_unre_4.txt"

# Specify the path to the subset file
subset_file="/u/home/a/afcarrol/project-pasaniuc/Projects/20240403_spark_gwas_larger_unre/spark_unre_afr_gia_4.txt"

# Specify the output directory
output_dir="/u/home/a/afcarrol/project-pasaniuc/Projects/20240403_spark_gwas_larger_unre/output_files"

# Loop through chromosomes 1 to 22
for chr in {1..22}
do
    # Run PLINK for each chromosome
    plink2 \
        --pfile "${pgen_path}/chr${chr}" \
        --logistic \
        --keep "${subset_file}" \
        --pheno "${phenotype_file}" \
        --covar "${covariate_file}" \
        --hwe 1e-12 \
        --maf 0.01 \
        --covar-variance-standardize \
        --out "${output_dir}/asd_afr_gwas_chr${chr}"
done

# Wait for all background processes to finish
wait

echo "GWAS on all chromosomes completed."


# login 3 gwas