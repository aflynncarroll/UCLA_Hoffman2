#!/bin/bash
#$ -N convert spark bfiles to pfiles
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

cd /u/home/a/afcarrol/project-pasaniuc/Projects/20240308_partial_pgs_SPARK

mkdir /u/home/a/afcarrol/project-pasaniuc/Projects/20230117_spark_pca_update/SPARK_pgen_by_chrom/

# Set the input and output directories
input_dir="/u/home/a/afcarrol/project-pasaniuc/Projects/20230117_spark_pca_update/SPARK_bed_by_chrom"
output_dir="/u/home/a/afcarrol/project-pasaniuc/Projects/20230117_spark_pca_update/SPARK_pgen_by_chrom"

# Loop over chromosomes 1 to 22
for chrom in {1..22}
do
    # Set the paths for input and output files
    input_file="${input_dir}/SPARK_genos_chr${chrom}"
    output_file="${output_dir}/SPARK_genos_chr${chrom}"

    # Run PLINK 2 to convert bfile to pfile
    plink2 \
        --bfile "${input_file}" \
        --make-pfile \
        --out "${output_file}"

    # Optionally, you can delete the original bfile to save space
    # rm "${input_file}.bed" "${input_file}.bim" "${input_file}.fam"
done
