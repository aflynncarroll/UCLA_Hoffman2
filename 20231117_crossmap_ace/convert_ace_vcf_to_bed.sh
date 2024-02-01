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

# convert vcf to bed/bim/fam - only keeping afr individuals

. /u/local/Modules/default/init/modules.sh
module load anaconda3/2023.03

conda activate plink2_env

plink2 --vcf /u/project/geschwind/shared/GenomicDatasets-processed/Imputed/total_vcfs_r2_0.8/combined/ace_merged_hg19/ace_merged_hg19.vcf.gz \
       --make-pgen \
       --sort-vars \
       --keep "/u/home/a/afcarrol/project-pasaniuc/Projects/20240109_subset_ACE_AFR_for_SAIGE/ace_afr_list.txt" \
       --out /u/project/geschwind/shared/GenomicDatasets-processed/Imputed/total_vcfs_r2_0.8/combined/ace_merged_hg19/ace_merged_hg19_afr

ls -lh /u/project/geschwind/shared/GenomicDatasets-processed/Imputed/total_vcfs_r2_0.8/combined/ace_merged_hg19/

# had to remove multiallelic sites because bed files cannot handle them
# also had to remove chrX and chry because prscs cannot handle them
plink2 --pfile /u/project/geschwind/shared/GenomicDatasets-processed/Imputed/total_vcfs_r2_0.8/combined/ace_merged_hg19/ace_merged_hg19_afr \
       --make-bed \
       --max-alleles 2 \
       --autosome \
       --out /u/project/geschwind/shared/GenomicDatasets-processed/Imputed/total_vcfs_r2_0.8/combined/ace_merged_hg19/ace_merged_hg19_afr