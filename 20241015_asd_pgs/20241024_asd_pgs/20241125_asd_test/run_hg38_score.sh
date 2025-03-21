#!/bin/bash -l
#$ -N rfmix_spark
#$ -cwd
#$ -l h_data=120,h_rt=5:00:00
#$ -j y
#$ -o ./job_out

. /u/local/Modules/default/init/modules.sh
module load anaconda3

#conda activate plink2_run

#conda activate /u/home/a/aflynnca/old-home-afcarrol/afcarrol/.conda/envs/plink2_env

conda activate /u/home/a/aflynnca/old_home/.conda/envs/plink2_env

module load singularity

module load java/jdk-11.0.14 

#conda update openjdk

cd project-pasaniuc/projects/20241015_asd_pgs/20241024_asd_pgs/20241125_asd_test


wget https://ftp.ebi.ac.uk/pub/databases/spot/pgs/scores/PGS002453/ScoringFiles/Harmonized/PGS002453_hmPOS_GRCh38.txt.gz

/u/home/a/aflynnca/nextflow run pgscatalog/pgsc_calc -r v1.2.0 \
    -profile singularity \
    --input /u/project/pasaniuc/aflynnca/projects/20221020_pgsc_calc_autism/SPARK_full.csv \
    --target_build GRCh38 \
    --scorefile /u/home/a/aflynnca/project-pasaniuc/projects/20241015_asd_pgs/20241024_asd_pgs/20241125_asd_test/PGS002453_hmPOS_GRCh38.txt \
    --min_overlap 0.001