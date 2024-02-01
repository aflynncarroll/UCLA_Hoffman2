#!/bin/bash     
#$ -N chr_ace_hm3 
#$ -e misc      
#$ -o misc      
#$ -cwd     
#$ -r y     
#$ -j y     
#$ -l h_data=100G    
#$ -l time=40:00:00     
#$ -l highp
#$ -t 1 

. /u/local/Modules/default/init/modules.sh
module load anaconda3/2023.03

conda activate plink2_env



for chr in {1..22}; do
    pvar_file="/u/project/geschwind/shared/GenomicDatasets-processed/ACE-ANALYSIS/freeze0/SPARK/imputed/chr${chr}.pvar"
    if [ -f "$pvar_file" ]; then
        awk '{print $1, $2, $3, $4, $5}' "$pvar_file" | sort -u >> "/u/project/pasaniuc/afcarrol/Projects/20231003_SPARK_PCA_GIA/combined_variants.txt"
    else
        echo "Warning: Missing file for chromosome $chr"
    fi
done
