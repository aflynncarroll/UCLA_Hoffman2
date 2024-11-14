#!/bin/bash     
#$ -N move_files
#$ -e misc      
#$ -o misc      
#$ -cwd     
#$ -r y     
#$ -j y     
#$ -l h_data=120G    
#$ -l time=1:00:00     
#$ -l highp
#$ -t 1

mkdir /u/project/geschwind/shared/GWAS/20240321_ACE_SPARK_unrelated_ASD_AFR_GWAS_info

cp /u/home/a/afcarrol/project-pasaniuc/Projects/20240314_ACE_ASD_gwas_larger_pop/ace_asd_unre_3.txt /u/project/geschwind/shared/GWAS/20240321_ACE_SPARK_unrelated_ASD_AFR_GWAS_info

cp /u/home/a/afcarrol/project-pasaniuc/Projects/20240305_asd_afr_gwas_no_sex_age/spark_asd_unre_3.txt /u/project/geschwind/shared/GWAS/20240321_ACE_SPARK_unrelated_ASD_AFR_GWAS_info