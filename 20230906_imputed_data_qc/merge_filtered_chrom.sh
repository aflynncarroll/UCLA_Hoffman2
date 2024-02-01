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

. /u/local/Modules/default/init/modules.sh

module load anaconda3/2023.03

conda activate plink2_env

cd /u/project/geschwind/shared/GenomicDatasets-processed/Imputed/total_vcfs_r2_0.8/combined_hm3_filtered/chr_run/combined

# Set the path to the directory containing the chromosome files
chromosome_dir="/u/project/geschwind/shared/GenomicDatasets-processed/Imputed/total_vcfs_r2_0.8/combined_hm3_filtered/chr_run"

# Set the output file names for the merged data
output_prefix="/u/project/geschwind/shared/GenomicDatasets-processed/Imputed/total_vcfs_r2_0.8/combined_hm3_filtered/chr_run/combined/total_hm3_ace"

# Set the path to the backup directory
backup_dir="/u/project/geschwind/shared/GenomicDatasets-processed/Imputed/total_vcfs_r2_0.8/combined_hm3_filtered/chr_run/by_chrom"

# Set the path to the output log file
output_log="/u/project/geschwind/shared/GenomicDatasets-processed/Imputed/total_vcfs_r2_0.8/combined_hm3_filtered/chr_run/combined/merge_log.txt"

# Redirect all script output (including plink2 commands) to the output log file
exec > "$output_log" 2>&1

# Loop through the chromosomes
for chr in {1..22}; do
    # Merge each chromosome's data into the output files
    plink2 --bfile "$chromosome_dir/merged_hm3_chr${chr}" --make-bed --out "$output_prefix"
    
    mv "$chromosome_dir/merged_hm3_chr${chr}.bed" "$chromosome_dir/merged_hm3_chr${chr}.bim" "$chromosome_dir/merged_hm3_chr${chr}.fam" "$chromosome_dir/merged_hm3_chr${chr}.log" "$backup_dir/"
    
done


output_prefix="/u/project/geschwind/shared/GenomicDatasets-processed/Imputed/total_vcfs_r2_0.8/combined_hm3_filtered/chr_run/combined/total_hm3_ace"

chromosome_dir="/u/project/geschwind/shared/GenomicDatasets-processed/Imputed/total_vcfs_r2_0.8/combined_hm3_filtered/chr_run/by_chrom"

merge_list_file="/u/project/geschwind/shared/GenomicDatasets-processed/Imputed/total_vcfs_r2_0.8/combined_hm3_filtered/chr_run/merge_list.txt"


for chr in {1..22}; do
echo "${chromosome_dir}/merged_hm3_chr${chr}" >> "$merge_list_file"
done



# Merge all chromosome data into the output files using the merge list
plink --merge-list "$merge_list_file" --make-bed --out "$output_prefix"

