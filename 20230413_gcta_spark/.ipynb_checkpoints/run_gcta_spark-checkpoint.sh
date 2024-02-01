#!/bin/bash     
#$ -N SPARK_gcta   
#$ -e misc      
#$ -o misc      
#$ -cwd     
#$ -r y     
#$ -j y     
#$ -l h_data=16G    
#$ -l time=23:00:00     
#$ -l highp
#$ -t 1-1000:1 

. /u/local/Modules/default/init/modules.sh
module load anaconda3/2023.03

conda activate gcta


gcta64 --bfile /u/project/pasaniuc/afcarrol/Projects/20230117_spark_pca_update/SPARK_20210118/SPARKiwes_TopMed_chr1.22_rsID.MikeDB_SPARKdb155_rm.sexmismatch.49.maf0.01.geno0.05.hwe1e6 --make-grm-part 1000 ${SGE_TASK_ID} --thread-num 1 --out test_grm_spark_1000


