#!/bin/bash
#$ -N move the covar file
#$ -e misc      
#$ -o misc      
#$ -cwd     
#$ -r y     
#$ -j y     
#$ -l h_data=20G    
#$ -l time=1:00:00     
#$ -l highp
#$ -t 1 

# the covar file was created locally in r for ACE+SPARK joint PRS and ancestry deconvolution analyses
# 20240305_spark_ace_combined

mkdir /u/project/geschwind/shared/PRS/20240404_ace_spark_total_cover

cp /u/home/a/afcarrol/project-pasaniuc/Projects/20240404_ace_spark_total_cover/ace_spark_total_covar.csv /u/project/geschwind/shared/PRS/20240404_ace_spark_total_cover

/u/project/geschwind/shared/PRS/20240404_ace_spark_total_cover/ace_spark_total_covar.csv