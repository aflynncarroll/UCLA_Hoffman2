#!/bin/bash     
#$ -N ace_indv_list
#$ -e misc      
#$ -o misc      
#$ -cwd     
#$ -r y     
#$ -j y     
#$ -l h_data=32G    
#$ -l time=1:00:00     
#$ -l highp

. /u/local/Modules/default/init/modules.sh

module load anaconda3/2023.03
module load bcftools

bcftools query -l /u/project/geschwind/shared/GenomicDatasets-processed/Imputed/total_vcfs_r2_0.8/combined/merged_output_2.vcf.gz > \
    /u/home/a/afcarrol/project-pasaniuc/Projects/20240109_subset_ACE_AFR_for_SAIGE/ace_list.txt