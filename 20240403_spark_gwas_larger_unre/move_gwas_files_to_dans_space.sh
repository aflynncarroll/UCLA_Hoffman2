#!/bin/bash     
#$ -N move_files
#$ -e misc      
#$ -o misc      
#$ -cwd     
#$ -r y     
#$ -j y     
#$ -l h_data=w0G    
#$ -l time=2:00:00     
#$ -l highp
#$ -t 1

mkdir /u/project/geschwind/shared/GWAS/20240404_spark_gwas_larger_unre

mkdir /u/project/geschwind/shared/GWAS/20240404_spark_gwas_larger_unre/ace_output

mkdir /u/project/geschwind/shared/GWAS/20240404_spark_gwas_larger_unre/spark_output




cp /u/home/a/afcarrol/project-pasaniuc/Projects/20240403_spark_gwas_larger_unre/spark_afr_asd_unre_gwas_4.txt /u/project/geschwind/shared/GWAS/20240404_spark_gwas_larger_unre

cp /u/home/a/afcarrol/project-pasaniuc/Projects/20240314_ACE_ASD_gwas_larger_pop/ace_asd_unre_3.txt /u/project/geschwind/shared/GWAS/20240404_spark_gwas_larger_unre

cp -r /u/home/a/afcarrol/project-pasaniuc/Projects/20240314_ACE_ASD_gwas_larger_pop/output_files_ace /u/project/geschwind/shared/GWAS/20240404_spark_gwas_larger_unre/ace_output

cp -r /u/home/a/afcarrol/project-pasaniuc/Projects/20240403_spark_gwas_larger_unre/output_files /u/project/geschwind/shared/GWAS/20240404_spark_gwas_larger_unre/spark_output