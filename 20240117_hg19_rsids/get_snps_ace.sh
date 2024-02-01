#!/bin/bash     
#$ -N ace_vcf_bed
#$ -e misc      
#$ -o misc      
#$ -cwd     
#$ -r y     
#$ -j y     
#$ -l h_data=60G    
#$ -l time=40:00:00     
#$ -l highp

. /u/local/Modules/default/init/modules.sh
module load anaconda3/2023.03

conda activate plink2_env


ace_bim="/u/project/geschwind/shared/GenomicDatasets-processed/Imputed/total_vcfs_r2_0.8/combined/ace_merged_hg19/ace_merged_hg19_afr"
out_loc="/u/home/a/afcarrol/project-pasaniuc/Projects/20240117_hg19_rsids/var_ace_merged_hg19_afr"

plink2 \
    --bfile ${ace_bim} \
    --write-snplist \
    --out ${out_loc}