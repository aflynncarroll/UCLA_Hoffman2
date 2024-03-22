#!/bin/bash
#$ -N modify_ace_vcf
#$ -e misc      
#$ -o misc      
#$ -cwd     
#$ -r y     
#$ -j y     
#$ -l h_data=60G    
#$ -l time=10:00:00     
#$ -l highp
#$ -t 1 

cd /u/home/a/afcarrol/project-pasaniuc/Projects/20240318_ACE_SPARK_SAIGE_prep/take_2

mkdir /u/project/geschwind/shared/GenomicDatasets-processed/Imputed/total_vcfs_r2_0.8/combined/modified_vcf_iids

. /u/local/Modules/default/init/modules.sh
module load anaconda3/2023.03
module load bcftools

conda activate plink2_env


original_vcf="/u/project/geschwind/shared/GenomicDatasets-processed/Imputed/total_vcfs_r2_0.8/combined/merged_output_2.vcf.gz"
iid_output="/u/project/geschwind/shared/GenomicDatasets-processed/Imputed/total_vcfs_r2_0.8/combined/merged_output_2_iids.txt"

bcftools query -l ${original_vcf} > ${iid_output}

#bcftools index /u/project/geschwind/shared/GenomicDatasets-processed/Imputed/total_vcfs_r2_0.8/combined/merged_output_2.vcf.gz

renaming_file="/u/project/geschwind/shared/GenomicDatasets-processed/Imputed/total_vcfs_r2_0.8/combined/modified_vcf_iids/ace_vcf_rename.txt"
new_vcf="/u/project/geschwind/shared/GenomicDatasets-processed/Imputed/total_vcfs_r2_0.8/combined/modified_vcf_iids/ace_mod_out2.vcf.gz"

bcftools annotate --rename ${renaming_file} ${original_vcf} -Oz -o ${new_vcf}