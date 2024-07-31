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

. /u/local/Modules/default/init/modules.sh
module load anaconda3/2020.11
conda activate plink2_update

mkdir /u/project/geschwind/shared/GenomicDatasets-processed/Imputed/SPARK/SPARK_HM3/spark_1kg_merged

ref_pfile=/u/home/a/afcarrol/project-pasaniuc/Projects/20240514_ACE_AD_2/1kg_ref/pgen/all_chr   # path to 1kg pgen file (all chromosomes)
sample_pfile=/u/project/geschwind/shared/GenomicDatasets-processed/Imputed/SPARK/SPARK_HM3/all_chr # path to sample pgen file (all chromosomes)
out_dir=/u/project/geschwind/shared/GenomicDatasets-processed/Imputed/SPARK/SPARK_HM3/spark_1kg_merged  # path to output directory

# merge 1kg dataset and sample dataset
admix pfile-merge-indiv \
    --pfile1 ${ref_pfile} \
    --pfile2 ${sample_pfile} \
    --out ${out_dir}/spark_1kg_ref

plink2 --bfile ${out_dir}/spark_1kg_ref \
    --pca approx \
    --out ${out_dir}/merged_pca

# admix plot-joint-pca \
#     --ref-pfile ${ref_pfile} \
#     --pca-prefix ${out_dir}/merged_pca \
#     --out ${out_dir}/merged_pca

admix select-admix-indiv \
    --ref-pfile ${ref_pfile} \
    --pca-prefix ${out_dir}/merged_pca \
    --superpop1 EUR --superpop2 AFR \
    --exclude-pop2 ASW,ACB \
    --out ${out_dir}/selected_admix

cp /u/project/geschwind/shared/GenomicDatasets-processed/Imputed/total_vcfs_r2_0.8/combined/hm3_filtered_pfiles/merged_pgen/1kg_merged/selected_admix.indiv \
    /u/home/a/afcarrol/project-pasaniuc/Projects/20240514_ACE_AD_2/