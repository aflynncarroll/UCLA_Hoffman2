#!/bin/bash     
#$ -N SPARK_hm3_grm_unrelated  
#$ -e misc      
#$ -o misc      
#$ -cwd     
#$ -r y     
#$ -j y     
#$ -l h_data=120G    
#$ -l time=23:00:00     
#$ -l highp
#$ -t 1:1

. /u/local/Modules/default/init/modules.sh
module load anaconda3/2023.03

conda activate gcta


gcta64 \
    --thread-num 4 \
    --grm /u/project/pasaniuc/afcarrol/Projects/20230413_gcta_spark/joined_SPARK_hm3/spark_hm3_joined \
    --grm-cutoff 0.05 \
    --make-grm-gz \
    --out /u/project/pasaniuc/afcarrol/Projects/20230413_gcta_spark/unrelated_grm_text/spark_hm3_unrelated