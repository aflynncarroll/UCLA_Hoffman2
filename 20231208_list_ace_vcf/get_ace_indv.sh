#!/bin/bash     
#$ -N switch genome builds
#$ -e misc      
#$ -o misc      
#$ -cwd     
#$ -r y     
#$ -j y     
#$ -l h_data=130G    
#$ -l time=40:00:00     
#$ -l highp
#$ -t 1 

cd /u/home/a/afcarrol/project-pasaniuc/Projects/20231208_list_ace_vcf

. /u/local/Modules/default/init/modules.sh
module load anaconda3/2023.03


module load bcftools
module load bgzip


bcftools query -l /u/project/geschwind/shared/GenomicDatasets-processed/Imputed/total_vcfs_r2_0.8/combined/merged_output_2.vcf.gz > /u/home/a/afcarrol/project-pasaniuc/Projects/20231208_list_ace_vcf/ACE_indv_vcfs_r2_0.8.txt

