#!/bin/bash
#$ -N spark lanc files from admix-kit
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

pfile=/u/home/a/afcarrol/project-pasaniuc/Projects/20230117_spark_pca_update/SPARK_pgen_by_chrom/SPARK_genos_chr${chrom}
rfmix_msp=/u/project/geschwind/shared/PRS/20240221_SPARK_RFMix/chr${chrom}.msp.tsv
out_prefix=/u/home/a/afcarrol/project-pasaniuc/Projects/20230117_spark_pca_update/SPARK_pgen_by_chrom/SPARK_genos_chr${chrom}.lanc


admix lanc-convert \
    --pfile ${pfile} \
    --rfmix ${rfmix_msp} \
    --out ${out_prefix}           

done
