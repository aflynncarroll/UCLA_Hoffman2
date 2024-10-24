#!/bin/bash     
#$ -N ace saige
#$ -e misc      
#$ -o misc      
#$ -cwd     
#$ -r y     
#$ -j y     
#$ -l h_data=120G    
#$ -l time=1:00:00     
#$ -l highp
#$ -t 1 

. /u/local/Modules/default/init/modules.sh
module load anaconda3/2020.11
conda activate old-home-afcarrol/afcarrol/.conda/envs/plink2_env/
#/u/home/a/aflynnca/.conda/envs/plink2_run


# Set the filename as a variable
filename="/u/project/geschwind/shared/GenomicDatasets-processed/ACE_X_chroms/2010-002.clean101007/2010-002.clean101007_X"
out="/u/project/geschwind/shared/GenomicDatasets-processed/ACE_X_chroms/2010-002.clean101007/2010-002.clean101007_snps"

# Use the variable in a Plink command
plink2 --bfile "${filename}" --write-snplist --out "${out}"