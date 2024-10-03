#!/bin/bash
#$ -N sub_ace_ibd
#$ -e misc      
#$ -o misc      
#$ -cwd     
#$ -r y     
#$ -j y     
#$ -l h_data=120G    
#$ -l time=10:00:00     
#$ -l highp
#$ -t 1 


. /u/local/Modules/default/init/modules.sh
module load plink

sample_bed=/u/project/geschwind/shared/GenomicDatasets-processed/Imputed/total_vcfs_r2_0.8/filtered_1kg/merged/total_1kg_ace
gender_check=//u/home/a/afcarrol/project-pasaniuc/Projects/20240521_ace_ibd/ace_gender

plink --bfile ${sample_bed} --impute-sex --out ${gender_check}

plink --bfile ${sample_bed} --impute-sex --write-covar --out ${gender_check}

plink --bfile ${sample_bed} --check-sex --out ${gender_check}

## need to have a copy with the sex chromosomes to run the check