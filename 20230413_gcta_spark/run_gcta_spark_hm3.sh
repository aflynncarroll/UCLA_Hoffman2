#!/bin/bash     
#$ -N SPARK_hm3_grm  
#$ -e misc      
#$ -o misc      
#$ -cwd     
#$ -r y     
#$ -j y     
#$ -l h_data=16G    
#$ -l time=23:00:00     
#$ -l highp
#$ -t 1-250:1 

. /u/local/Modules/default/init/modules.sh
module load anaconda3/2023.03

conda activate gcta


gcta64 --bfile /u/project/pasaniuc/afcarrol/Projects/20230117_spark_pca_update/SPARK_full_hampap3/SPARK_hm3_subset \
    --make-grm-part 250 ${SGE_TASK_ID} \
    --thread-num 1 \
    --out /u/project/pasaniuc/afcarrol/Projects/20230413_gcta_spark/grm_SPARK_hm3/spark_hm3_grm


