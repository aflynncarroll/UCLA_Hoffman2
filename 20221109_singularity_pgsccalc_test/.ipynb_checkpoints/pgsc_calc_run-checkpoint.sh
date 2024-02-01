#!/bin/bash

##### pgsc_calc installation (from Yi Ding)
#qrsh -l h_rt=2:00:00,h_data=20G

## load java
#module load java/jdk-11.0.14

## install nextflow 
#curl -fsSL get.nextflow.io | bash
#export PATH="DIRECTORY_OF_YOUR_NEXTFLOW:$PATH"

## clone pgsc_calc
#git clone https://github.com/PGScatalog/pgsc_calc.git

## load singularity
#module load singularity

## run test
#nextflow run pgscatalog/pgsc_calc -r v1.2.0 -profile test,singularity




##### Run pgsc_calc
## https://www.pgscatalog.org/score/PGS000327/

module load java/jdk-11.0.14

module load singularity

/u/project/pasaniuc/afcarrol/Projects/20221017_pgsc_calc_test/nextflow  run pgscatalog/pgsc_calc -r v1.2.0 \
    -profile singularity \
    --input /u/project/pasaniuc/afcarrol/Projects/20221020_pgsc_calc_autism/SPARK_full.csv --target_build GRCh38 \
    --pgs_id PGS000327 \
    --min_overlap 0.5