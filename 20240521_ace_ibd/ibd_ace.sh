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

#https://ucdavis-bioinformatics-training.github.io/2021-July-Genome-Wide-Association-Studies/data_analysis/Plink_Stepbystep

. /u/local/Modules/default/init/modules.sh
module load plink

sample_bed=/u/project/geschwind/shared/GenomicDatasets-processed/Imputed/total_vcfs_r2_0.8/filtered_1kg/merged/total_1kg_ace
filter_out=/u/project/geschwind/shared/GenomicDatasets-processed/Imputed/total_vcfs_r2_0.8/filtered_1kg/merged/maf_0.4/total_1kg_ace_0.4
ibd_out=/u/home/a/afcarrol/project-pasaniuc/Projects/20240521_ace_ibd/ace_ibd
#mkdir /u/project/geschwind/shared/GenomicDatasets-processed/Imputed/total_vcfs_r2_0.8/filtered_1kg/merged/maf_0.4

plink --bfile ${sample_bed} --maf 0.4 --make-bed --out ${filter_out}

plink --bfile ${filter_out} --genome --out ${ibd_out}