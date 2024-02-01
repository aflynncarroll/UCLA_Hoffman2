#!/bin/bash     
#$ -N merge_chroms 
#$ -e misc      
#$ -o misc      
#$ -cwd     
#$ -r y     
#$ -j y     
#$ -l h_data=100G    
#$ -l time=40:00:00     
#$ -l highp
#$ -t 1


#/u/project/pasaniuc/afcarrol/Projects/20230930_1kg_variants/merge_filtered_a1.sh
. /u/local/Modules/default/init/modules.sh
module load plink

cd /u/project/geschwind/shared/GenomicDatasets-processed/Imputed/total_vcfs_r2_0.8/filtered_1kg


output_prefix="/u/project/geschwind/shared/GenomicDatasets-processed/Imputed/total_vcfs_r2_0.8/filtered_1kg/merged/total_1kg_ace"

chromosome_dir="/u/project/geschwind/shared/GenomicDatasets-processed/Imputed/total_vcfs_r2_0.8/filtered_1kg/chrom_pfiles"

merge_list_file="/u/project/geschwind/shared/GenomicDatasets-processed/Imputed/total_vcfs_r2_0.8/filtered_1kg/merged/merge_list.txt"

# Set the path to the output log file
output_log="/u/project/geschwind/shared/GenomicDatasets-processed/Imputed/total_vcfs_r2_0.8/filtered_1kg/merged/merge_log.txt"

# Redirect all script output (including plink2 commands) to the output log file
exec > "$output_log" 2>&1


for chr in {1..22}; do
echo "${chromosome_dir}/merged_1kg_chr${chr}" >> "$merge_list_file"
done



# Merge all chromosome data into the output files using the merge list
plink --merge-list "$merge_list_file" --make-bed --out "$output_prefix"

# didnt run - plink wasnt found?