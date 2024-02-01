#!/bin/bash     
#$ -N chr_ace_hm3 
#$ -e misc      
#$ -o misc      
#$ -cwd     
#$ -r y     
#$ -j y     
#$ -l h_data=100G    
#$ -l time=40:00:00     
#$ -l highp
#$ -t 1 

. /u/local/Modules/default/init/modules.sh
module load plink
# Specify the output file
output_dir='/u/project/pasaniuc/afcarrol/Projects/20231003_SPARK_PCA_GIA/spark_var'

# Initialize the output file (remove it if it exists)
> "${output_dir}.snplist"
> "${output_dir}.log"
> "${output_dir}.nosex"

# Loop over the 22 chromosomes
for i in {1..22}; do
    chrom_file="/u/home/a/afcarrol/project-pasaniuc/Projects/20230117_spark_pca_update/SPARK_bed_by_chrom/SPARK_genos_chr${i}"

        # Run plink for each chromosome file and append the SNP list to the output file
        plink --bfile "${chrom_file}" --write-snplist --out "${output_dir}_temp"
    
        # Concatenate the SNP list to the output file
        cat "${output_dir}_temp.snplist" >> "${output_dir}.snplist"
        cat "${output_dir}_temp.log" >> "${output_dir}.log"
        cat "${output_dir}_temp.nosex" >> "${output_dir}.nosex"
    
        # Remove the temporary SNP list file
        rm "${output_dir}_temp.snplist" "${output_dir}_temp.log" "${output_dir}_temp.nosex"

done
