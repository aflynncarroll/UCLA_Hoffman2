#!/bin/bash
#$ -N convert bfiles to pfiles
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

mkdir /u/project/geschwind/shared/GenomicDatasets-processed/Imputed/total_vcfs_r2_0.8/filtered_1kg/chrom_pfiles/pfiles

# Set the input and output directories
input_dir="/u/project/geschwind/shared/GenomicDatasets-processed/Imputed/total_vcfs_r2_0.8/filtered_1kg/chrom_pfiles"
output_dir="/u/project/geschwind/shared/GenomicDatasets-processed/Imputed/total_vcfs_r2_0.8/filtered_1kg/chrom_pfiles/pfiles"

# Loop over chromosomes 1 to 22
for chrom in {1..22}
do
    # Set the paths for input and output files
    input_file="${input_dir}/merged_1kg_chr${chrom}"
    output_file="${output_dir}/merged_1kg_chr${chrom}"

    # Run PLINK 2 to convert bfile to pfile
    plink2 \
        --bfile "${input_file}" \
        --make-pfile \
        --out "${output_file}"

    # Optionally, you can delete the original bfile to save space
    # rm "${input_file}.bed" "${input_file}.bim" "${input_file}.fam"
done
