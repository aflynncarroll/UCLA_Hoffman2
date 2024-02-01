#!/bin/bash     
#$ -N chr_ace_hm3 
#$ -e misc      
#$ -o misc      
#$ -cwd     
#$ -r y     
#$ -j y     
#$ -l h_data=60G    
#$ -l time=30:00:00     
#$ -l highp
#$ -t 22-1:1 

. /u/local/Modules/default/init/modules.sh
module load anaconda3/2023.03

conda activate plink2_env

cd /u/project/geschwind/shared/GenomicDatasets-processed/Imputed/SPARK/

plink2 --pfile "/u/project/geschwind/shared/GenomicDatasets-processed/ACE-ANALYSIS/freeze0/SPARK/imputed/chr${SGE_TASK_ID}" \
       --chr "chr${SGE_TASK_ID}" \
       --extract "/u/project/pasaniuc/afcarrol/Projects/20231003_SPARK_PCA_GIA/filtered_snps_1kg_spark.txt" \
       --max-alleles 2 \
       --make-bed \
       --out "/u/project/geschwind/shared/GenomicDatasets-processed/Imputed/SPARK/spark_1kg_chr${SGE_TASK_ID}"
       