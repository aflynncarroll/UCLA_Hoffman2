#!/bin/bash     
#$ -N ace_filter_rsids
#$ -e misc      
#$ -o misc      
#$ -cwd     
#$ -r y     
#$ -j y     
#$ -l h_data=96G    
#$ -l time=40:00:00     
#$ -l highp

. /u/local/Modules/default/init/modules.sh
module load anaconda3/2023.03
module load plink

cd /u/project/pasaniuc/afcarrol/Projects/20240117_hg19_rsids/

mkdir /u/project/geschwind/shared/GenomicDatasets-processed/Imputed/total_vcfs_r2_0.8/combined/ace_merged_hg19/prscs_filtered

#### Filter the ACE data to only include the SNPs that are in the 1KG and AFR reference panel from PRS-CS
plink \
    --bfile /u/project/geschwind/shared/GenomicDatasets-processed/Imputed/total_vcfs_r2_0.8/combined/ace_merged_hg19/ace_merged_hg19_afr \
    --extract /u/project/pasaniuc/afcarrol/Projects/20240117_hg19_rsids/ace_1kg_snps.txt \
    --make-bed \
    --out /u/project/geschwind/shared/GenomicDatasets-processed/Imputed/total_vcfs_r2_0.8/combined/ace_merged_hg19/prscs_filtered/ace_hg19_afr_prscs_filtered

#### Update the SNP names to be RSIDs from the 1KG and AFR reference panel from PRS-CS
plink \
    --bfile /u/project/geschwind/shared/GenomicDatasets-processed/Imputed/total_vcfs_r2_0.8/combined/ace_merged_hg19/prscs_filtered/ace_hg19_afr_prscs_filtered \
    --update-name /u/project/pasaniuc/afcarrol/Projects/20240117_hg19_rsids/new_snp_names.txt \
    --make-bed \
    --out /u/project/geschwind/shared/GenomicDatasets-processed/Imputed/total_vcfs_r2_0.8/combined/ace_merged_hg19/prscs_filtered/ace_merged_hg19_afr_prscs_rsids

