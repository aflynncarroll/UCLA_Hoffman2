#!/bin/bash     
#$ -N Ace_hm3_subset 
#$ -e misc      
#$ -o misc      
#$ -cwd     
#$ -r y     
#$ -j y     
#$ -l h_data=120G    
#$ -l time=45:00:00     
#$ -l highp

. /u/local/Modules/default/init/modules.sh
module load anaconda3/2023.03

conda activate plink2_env

cd /u/project/geschwind/shared/GenomicDatasets-processed/Imputed/total_vcfs_r2_0.8/combined_hm3_filtered/qsub_run

plink2 --vcf /u/project/geschwind/shared/GenomicDatasets-processed/Imputed/total_vcfs_r2_0.8/combined/merged_output_2.vcf.gz \
       --extract /u/project/pasaniuc/afcarrol/Projects/20230906_imputed_data_qc/hm3_filtered_snps_ace.txt \
       --max-alleles 2 \
       --make-bed \
       --out /u/project/geschwind/shared/GenomicDatasets-processed/Imputed/total_vcfs_r2_0.8/combined_hm3_filtered/qsub_run/merged_hm3