#!/bin/bash
#$ -N get 1kg data
#$ -e misc      
#$ -o misc      
#$ -cwd     
#$ -r y     
#$ -j y     
#$ -l h_data=200G    
#$ -l time=1:00:00     
#$ -l highp
#$ -t 1 

cd /u/home/a/afcarrol/project-pasaniuc/Projects/20240514_ACE_AD_2

. /u/local/Modules/default/init/modules.sh
module load anaconda3/2020.11
conda activate plink2_env

admix get-1kg-ref --dir=/u/home/a/afcarrol/project-pasaniuc/Projects/20240514_ACE_AD_2/1kg_ref --build hg38

ls /u/project/geschwind/shared/GenomicDatasets-processed/Imputed/total_vcfs_r2_0.8/combined/hm3_filtered_pfiles/*.pgen > /u/home/a/afcarrol/project-pasaniuc/Projects/20240514_ACE_AD_2/file_list.txt



# make merged pgen for ace
mkdir /u/project/geschwind/shared/GenomicDatasets-processed/Imputed/total_vcfs_r2_0.8/combined/hm3_filtered_pfiles/merged_pgen

pfile=/u/project/geschwind/shared/GenomicDatasets-processed/Imputed/total_vcfs_r2_0.8/combined/merged_output_2
out_prefix=/u/project/geschwind/shared/GenomicDatasets-processed/Imputed/total_vcfs_r2_0.8/combined/hm3_filtered_pfiles/merged_pgen/ace_hm3_merged
snp_list=/u/home/a/afcarrol/project-pasaniuc/Projects/20240423_ace_partial_hm3/filtered_snps_hm3.txt
# Define the input P-file and SNP list file

# Subset by chromosome
plink2 --pfile ${pfile} --extract ${snp_list} --make-pgen --out ${out_prefix}
