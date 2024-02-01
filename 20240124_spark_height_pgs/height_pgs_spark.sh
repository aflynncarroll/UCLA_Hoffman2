#!/bin/bash     
#$ -N pgs_height_spark
#$ -e misc      
#$ -o misc      
#$ -cwd     
#$ -r y     
#$ -j y      
#$ -l h_data=60G    
#$ -l time=24:00:00     
#$ -l highp
#$ -t 1 

. /u/local/Modules/default/init/modules.sh
module load anaconda3
conda activate plink2_env
module load java/jdk-11.0.14

cd /u/home/a/afcarrol/project-pasaniuc/Projects/20240124_spark_height_pgs



# pgs for height
/u/project/pasaniuc/afcarrol/Projects/20221017_pgsc_calc_test/nextflow run pgscatalog/pgsc_calc -r v1.2.0 \
    -profile conda \
    --input /u/project/pasaniuc/afcarrol/Projects/20221020_pgsc_calc_autism/SPARK_full.csv --target_build GRCh38 \
    --pgs_id  PGS002453 \
    --min_overlap 0.001


    # --pgs_id PGP000263 \ -error
    #used publication code and not pgs id
    
# Completed at: 24-Jan-2024 14:40:08
# Duration    : 17m 46s
# CPU hours   : 0.6
# Succeeded   : 51

gzip -d /u/home/a/afcarrol/project-pasaniuc/Projects/20240124_spark_height_pgs/results/score/aggregated_scores.txt.gz