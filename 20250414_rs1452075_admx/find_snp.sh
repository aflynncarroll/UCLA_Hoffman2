#!/bin/bash
#$ -N spark_afr_asd_gwas
#$ -e misc      
#$ -o misc      
#$ -cwd     
#$ -r y     
#$ -j y     
#$ -l h_data=60G    
#$ -l time=10:00:00     
#$ -l highp
#$ -t 1 

. /u/local/Modules/default/init/modules.sh
module load anaconda3/2023.03

conda activate /u/home/a/aflynnca/.conda/envs/plink2_run


plink2 --pfile "/u/project/geschwind/shared/GenomicDatasets-processed/Imputed/total_vcfs_r2_0.8/combined/ACE_pgen_chrom/ACE_combined_chr3" \
       --snp chr3:62495388:C:T \
       --recode A \
       --out "/u/project/pasaniuc/aflynnca/projects/20250414_rs1452075_admx/ace_rs1452075_genotypes"

head -n 35 /u/project/geschwind/shared/GenomicDatasets-processed/Imputed/total_vcfs_r2_0.8/combined/ACE_pgen_chrom/ACE_combined_chr3.pvar

chr3:62495388:C:T

#https://www.ncbi.nlm.nih.gov/snp/rs1452075

cut -f1,2 /u/project/geschwind/shared/GenomicDatasets-processed/Imputed/total_vcfs_r2_0.8/combined/hm3_filtered_pfiles/ace_hm3_chr3.psam > ace_admx_indv.txt


plink2 --pfile "/u/project/geschwind/shared/GenomicDatasets-processed/Imputed/total_vcfs_r2_0.8/combined/hm3_filtered_pfiles/ace_hm3_chr3" \
       --snp chr3:62495388:C:T \
       --recode A \
       --out "/u/project/pasaniuc/aflynnca/projects/20250414_rs1452075_admx/ace_rs1452075_genotypes_admx"

