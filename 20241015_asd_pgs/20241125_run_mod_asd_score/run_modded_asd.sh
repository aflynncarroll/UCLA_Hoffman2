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

cd /u/home/a/aflynnca/project-pasaniuc/projects/20241015_asd_pgs/20241125_run_mod_asd_score/


#wget https://ftp.ebi.ac.uk/pub/databases/spot/pgs/scores/PGS002453/ScoringFiles/Harmonized/PGS002453_hmPOS_GRCh38.txt.gz

# asd genes - nothing

/u/home/a/aflynnca/nextflow run pgscatalog/pgsc_calc -r v1.2.0 \
    -profile singularity \
    --input /u/project/pasaniuc/aflynnca/projects/20221020_pgsc_calc_autism/SPARK_full.csv \
    --target_build GRCh38 \
    --scorefile /u/home/a/aflynnca/project-pasaniuc/projects/20241015_asd_pgs/20241126_eqtl_based_scores/asd_genes.txt \
    --min_overlap 0.001 \
    --outdir /u/home/a/aflynnca/project-pasaniuc/projects/20241015_asd_pgs/20241125_run_mod_asd_score/asd_genes

# quarter mb

/u/home/a/aflynnca/nextflow run pgscatalog/pgsc_calc -r v1.2.0 \
    -profile singularity \
    --input /u/project/pasaniuc/aflynnca/projects/20221020_pgsc_calc_autism/SPARK_full.csv \
    --target_build GRCh38 \
    --scorefile /u/home/a/aflynnca/project-pasaniuc/projects/20241015_asd_pgs/20241125_mod_scorefile/asd_grove_qmb.txt \
    --min_overlap 0.001 \
    --outdir /u/home/a/aflynnca/project-pasaniuc/projects/20241015_asd_pgs/20241125_run_mod_asd_score/qmb

# half mb

/u/home/a/aflynnca/nextflow run pgscatalog/pgsc_calc -r v1.2.0 \
    -profile singularity \
    --input /u/project/pasaniuc/aflynnca/projects/20221020_pgsc_calc_autism/SPARK_full.csv \
    --target_build GRCh38 \
    --scorefile /u/home/a/aflynnca/project-pasaniuc/projects/20241015_asd_pgs/20241125_mod_scorefile/asd_grove_hmb.txt \
    --min_overlap 0.001 \
    --outdir /u/home/a/aflynnca/project-pasaniuc/projects/20241015_asd_pgs/20241125_run_mod_asd_score/hmb

# 1 mb

/u/home/a/aflynnca/nextflow run pgscatalog/pgsc_calc -r v1.2.0 \
    -profile singularity \
    --input /u/project/pasaniuc/aflynnca/projects/20221020_pgsc_calc_autism/SPARK_full.csv \
    --target_build GRCh38 \
    --scorefile /u/home/a/aflynnca/project-pasaniuc/projects/20241015_asd_pgs/20241125_mod_scorefile/asd_grove_1mb.txt \
    --min_overlap 0.001 \
    --outdir /u/home/a/aflynnca/project-pasaniuc/projects/20241015_asd_pgs/20241125_run_mod_asd_score/1mb

# 2 mb

/u/home/a/aflynnca/nextflow run pgscatalog/pgsc_calc -r v1.2.0 \
    -profile singularity \
    --input /u/project/pasaniuc/aflynnca/projects/20221020_pgsc_calc_autism/SPARK_full.csv \
    --target_build GRCh38 \
    --scorefile /u/home/a/aflynnca/project-pasaniuc/projects/20241015_asd_pgs/20241125_mod_scorefile/asd_grove_2mb.txt \
    --min_overlap 0.001 \
    --outdir /u/home/a/aflynnca/project-pasaniuc/projects/20241015_asd_pgs/20241125_run_mod_asd_score/2mb

# 5 mb

/u/home/a/aflynnca/nextflow run pgscatalog/pgsc_calc -r v1.2.0 \
    -profile singularity \
    --input /u/project/pasaniuc/aflynnca/projects/20221020_pgsc_calc_autism/SPARK_full.csv \
    --target_build GRCh38 \
    --scorefile /u/home/a/aflynnca/project-pasaniuc/projects/20241015_asd_pgs/20241125_mod_scorefile/asd_grove_5mb.txt \
    --min_overlap 0.001 \
    --outdir /u/home/a/aflynnca/project-pasaniuc/projects/20241015_asd_pgs/20241125_run_mod_asd_score/5mb




/u/home/a/aflynnca/nextflow run pgscatalog/pgsc_calc -r v1.2.0 \
    -profile singularity \
    --input /u/project/pasaniuc/aflynnca/projects/20221020_pgsc_calc_autism/SPARK_full.csv \
    --target_build GRCh38 \
    --pgs_id  PGS000327 \
    --min_overlap 0.001 \
    --outdir /u/home/a/aflynnca/project-pasaniuc/projects/20241015_asd_pgs/20241125_run_mod_asd_score/full