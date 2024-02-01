#!/bin/bash     
#$ -N SPARK_gcta   
#$ -e misc      
#$ -o misc      
#$ -cwd     
#$ -r y     
#$ -j y     
#$ -l h_data=64G    
#$ -l time=23:00:00     
#$ -l highp
#$ -t 1-22:1 

. /u/local/Modules/default/init/modules.sh
module load anaconda3/2023.03

conda activate gcta


gcta64 --bfile /u/home/a/afcarrol/project-pasaniuc/Projects/20230117_spark_pca_update/SPARK_bed_by_chrom/SPARK_genos_chr${SGE_TASK_ID} \
--autosome-num ${SGE_TASK_ID} \
--make-grm \
--thread-num 4 \
--out SPARK_GCTA_chrom/chrom_spark_grm_chr${SGE_TASK_ID}