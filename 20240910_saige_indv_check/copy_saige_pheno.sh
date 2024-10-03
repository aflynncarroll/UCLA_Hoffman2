#!/bin/bash     
#$ -N ace saige
#$ -e misc      
#$ -o misc      
#$ -cwd     
#$ -r y     
#$ -j y     
#$ -l h_data=60G    
#$ -l time=1:00:00     
#$ -l highp
#$ -t 1 

cp /u/project/geschwind/vishakha/Projects/GWAS_AFR/data/ACE_SPARK/ACE_AFR_data/ACE_covariate_file_re.txt /u/home/a/afcarrol/project-pasaniuc/Projects/20240910_saige_indv_check

cp /u/project/geschwind/vishakha/Projects/GWAS_AFR/data/ACE_SPARK/SPARK_AFR_data/covar_file_saige.txt /u/home/a/afcarrol/project-pasaniuc/Projects/20240910_saige_indv_check