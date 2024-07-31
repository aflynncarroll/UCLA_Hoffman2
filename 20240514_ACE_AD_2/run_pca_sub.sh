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

ref_pfile=/u/home/a/afcarrol/project-pasaniuc/Projects/20240514_ACE_AD_2/1kg_ref/pgen/all_chr   # path to 1kg pgen file (all chromosomes)
sample_pfile=/u/project/geschwind/shared/GenomicDatasets-processed/Imputed/total_vcfs_r2_0.8/combined/hm3_filtered_pfiles/merged_pgen/ace_hm3_merged # path to sample pgen file (all chromosomes)
out_dir=/u/project/geschwind/shared/GenomicDatasets-processed/Imputed/total_vcfs_r2_0.8/combined/hm3_filtered_pfiles/merged_pgen/1kg_merged  # path to output directory

# merge 1kg dataset and sample dataset
admix pfile-merge-indiv \
    --pfile1 ${ref_pfile} \
    --pfile2 ${sample_pfile} \
    --out ${out_dir}/merged

# perform PCA (you may want to remove the 'approx' modifier if you don't have many samples in your data set (<5,000 individuals))
# plink2 --bfile ${out_dir}/merged \
#     --pca approx \
#     --out ${out_dir}/merged_pca

plink2 --bfile ${out_dir}/merged \
    --pca \
    --out ${out_dir}/merged_pca

admix plot-joint-pca \
    --ref-pfile ${ref_pfile} \
    --pca-prefix ${out_dir}/merged_pca \
    --out ${out_dir}/merged_pca

admix select-admix-indiv \
    --ref-pfile ${ref_pfile} \
    --pca-prefix ${out_dir}/merged_pca \
    --superpop1 EUR --superpop2 AFR \
    --exclude-pop2 ASW,ACB \
    --out ${out_dir}/selected_admix

cp /u/project/geschwind/shared/GenomicDatasets-processed/Imputed/total_vcfs_r2_0.8/combined/hm3_filtered_pfiles/merged_pgen/1kg_merged/selected_admix.indiv \
    /u/home/a/afcarrol/project-pasaniuc/Projects/20240514_ACE_AD_2/
# /u/home/a/afcarrol/project-pasaniuc/Projects/20240514_ACE_AD_2/selected_admix.indiv


#     vim /u/home/a/afcarrol/.local/lib/python3.8/site-packages/admix/cli/_utils.py
#     commented out
#       File "/u/home/a/afcarrol/.local/lib/python3.8/site-packages/admix/cli/_utils.py", line 312, in select_admix_indiv
#     admix.plot.joint_pca(df_pc=df_plot, eigenval=eigenval, axes=axes)
# TypeError: joint_pca() got an unexpected keyword argument 'eigenval'