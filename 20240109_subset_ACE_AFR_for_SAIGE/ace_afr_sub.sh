#!/bin/bash     
#$ -N ace_indv_list
#$ -e misc      
#$ -o misc      
#$ -cwd     
#$ -r y     
#$ -j y     
#$ -l h_data=120G    
#$ -l time=10:00:00     
#$ -l highp

. /u/local/Modules/default/init/modules.sh

module load anaconda3/2023.03
module load bcftools

cd /u/home/a/afcarrol/project-pasaniuc/Projects/20240109_subset_ACE_AFR_for_SAIGE

#mkdir /u/project/geschwind/shared/GenomicDatasets-processed/Imputed/total_vcfs_r2_0.8/combined/ace_afr_gia_sub/

# took a long time and was bigger than the original - did it not zip the file?
# Set the file names
input_file="/u/project/geschwind/shared/GenomicDatasets-processed/Imputed/total_vcfs_r2_0.8/combined/merged_output_2.vcf.gz"
sample_list="/u/home/a/afcarrol/project-pasaniuc/Projects/20240109_subset_ACE_AFR_for_SAIGE/ace_afr_list.txt"
output_file="/u/project/geschwind/shared/GenomicDatasets-processed/Imputed/total_vcfs_r2_0.8/combined/ace_afr_gia_sub/merged_ace_afr.vcf.gz"

ace_afr_check="/u/home/a/afcarrol/project-pasaniuc/Projects/20240109_subset_ACE_AFR_for_SAIGE/merged_ace_afr_list.txt"

# Run bcftools view
bcftools view -Oz -o "$output_file" -S "$sample_list" "$input_file"



