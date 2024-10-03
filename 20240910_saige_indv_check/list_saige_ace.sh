#!/bin/bash     
#$ -N ace saige
#$ -e misc      
#$ -o misc      
#$ -cwd     
#$ -r y     
#$ -j y     
#$ -l h_data=120G    
#$ -l time=3:00:00     
#$ -l highp
#$ -t 1 

cd /u/home/a/afcarrol/project-pasaniuc/Projects/20240910_saige_indv_check

. /u/local/Modules/default/init/modules.sh
module load anaconda3/2023.03


module load bcftools


bcftools query -l /u/project/geschwind/vishakha/Projects/GWAS_AFR/data/ACE_SPARK/ACE_AFR_data/merged_ace_afr.vcf.gz > /u/home/a/afcarrol/project-pasaniuc/Projects/20240910_saige_indv_check/ace_saige_indv.txt

