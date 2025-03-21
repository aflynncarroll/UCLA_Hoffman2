#!/bin/bash -l
#$ -N rfmix_spark
#$ -cwd
#$ -l h_data=120,h_rt=5:00:00
#$ -j y
#$ -o ./job_out

. /u/local/Modules/default/init/modules.sh
module load anaconda3



#conda activate plink2_run

conda activate /u/home/a/aflynnca/old-home-afcarrol/afcarrol/.conda/envs/plink2_env

module load singularity





module load java/jdk-11.0.14 

#conda update openjdk

cd project-pasaniuc/projects/20241015_asd_pgs/20241024_asd_pgs/

#conda install openjdk=11

#java -version

#curl -fsSL get.nextflow.io | bash

#mv nextflow ~/bin/


/u/home/a/aflynnca/nextflow run pgscatalog/pgsc_calc -r v1.2.0  -profile test,singularity

#/u/project/pasaniuc/afcarrol/Projects/20221017_pgsc_calc_test/nextflow run pgscatalog/pgsc_calc -r v1.2.0 \
/u/home/a/aflynnca/nextflow run pgscatalog/pgsc_calc -r v1.2.0 \
    -profile conda \
    --input /u/project/pasaniuc/afcarrol/Projects/20221020_pgsc_calc_autism/SPARK_full.csv --target_build GRCh38 \
    --scorefile /u/project/pasaniuc/aflynnca/projects/20241015_asd_pgs/20241024_asd_pgs/PGS000327_hmPOS_GRCh38.txt \
    --min_overlap 0.001

#-profile conda \

/u/home/a/aflynnca/nextflow run pgscatalog/pgsc_calc -r v1.2.0 \
    -profile singularity \
    --input /u/project/pasaniuc/afcarrol/Projects/20221020_pgsc_calc_autism/SPARK_full.csv \
    --target_build GRCh38 \
    --pgs_id  PGS002453 \
    --min_overlap 0.001

    asd_hg38_grove.txt




/u/home/a/aflynnca/nextflow run pgscatalog/pgsc_calc -r v1.2.0 \
    -profile singularity \
    --input /u/project/pasaniuc/aflynnca/projects/20221020_pgsc_calc_autism/SPARK_full.csv \
    --target_build GRCh38 \
    --scorefile /u/home/a/aflynnca/project-pasaniuc/projects/20241015_asd_pgs/20241024_asd_pgs/asd_hg38_grove.txt \
    --min_overlap 0.001