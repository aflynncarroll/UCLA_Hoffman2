#!/bin/bash     
#$ -N merge_chroms 
#$ -e misc      
#$ -o misc      
#$ -cwd     
#$ -r y     
#$ -j y     
#$ -l h_data=80G    
#$ -l time=40:00:00     
#$ -l highp
#$ -t 1


#/u/project/pasaniuc/afcarrol/Projects/20231003_SPARK_PCA_GIA
. /u/local/Modules/default/init/modules.sh
module load plink

cd /u/project/geschwind/shared/GenomicDatasets-processed/Imputed/SPARK/merged


output_prefix="/u/project/geschwind/shared/GenomicDatasets-processed/Imputed/SPARK/merged/total_1kg_spark"

chromosome_dir="/u/project/geschwind/shared/GenomicDatasets-processed/Imputed/SPARK"

merge_list_file="/u/project/geschwind/shared/GenomicDatasets-processed/Imputed/SPARK/merged/merge_list.txt"

# Set the path to the output log file
output_log="/u/project/geschwind/shared/GenomicDatasets-processed/Imputed/SPARK/merged/merge_log.txt"

# Redirect all script output (including plink2 commands) to the output log file
exec > "$output_log" 2>&1


for chr in {1..22}; do
echo "${chromosome_dir}/spark_1kg_chr${chr}" >> "$merge_list_file"
done



# Merge all chromosome data into the output files using the merge list
plink --merge-list "$merge_list_file" --make-bed --out "$output_prefix"

# didnt run - plink wasnt found?