#!/bin/bash     
#$ -N move spark rfmix
#$ -e misc      
#$ -o misc      
#$ -cwd     
#$ -r y     
#$ -j y     
#$ -l h_data=60G    
#$ -l time=2:00:00     
#$ -l highp
#$ -t 1 


mkdir /u/project/geschwind/shared/PRS/20241017_SPARK_HM3_RFMix