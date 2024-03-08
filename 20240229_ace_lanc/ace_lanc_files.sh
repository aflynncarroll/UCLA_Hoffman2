#!/bin/bash
#$ -N ace lanc files from admix-kit
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

for chrom in {1..22}
do

pfile=/u/project/geschwind/shared/GenomicDatasets-processed/Imputed/total_vcfs_r2_0.8/filtered_1kg/chrom_pfiles/pfiles/merged_1kg_chr${chrom}
rfmix_msp=/u/project/geschwind/shared/PRS/20240223_ACE_RFMix/chr${chrom}.msp.tsv
out_prefix=/u/project/geschwind/shared/GenomicDatasets-processed/Imputed/total_vcfs_r2_0.8/filtered_1kg/chrom_pfiles/pfiles/merged_1kg_chr${chrom}.lanc


admix lanc-convert \
    --pfile ${pfile} \
    --rfmix ${rfmix_msp} \
    --out ${out_prefix}           

done

# find /u/project/geschwind/shared/GenomicDatasets-processed/Imputed/total_vcfs_r2_0.8/filtered_1kg/chrom_pfiles/pfiles/ -type f -name "*.lanc"