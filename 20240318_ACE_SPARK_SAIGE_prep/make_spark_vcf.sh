#!/bin/bash
#$ -N spark_afr_vcf
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

conda activate plink2_env

cd /u/home/a/afcarrol/project-pasaniuc/Projects/20240318_ACE_SPARK_SAIGE_prep/

mkdir /u/project/geschwind/shared/GWAS/20240319_spark_saige_data

pgen_path="/u/project/geschwind/shared/GenomicDatasets-processed/ACE-ANALYSIS/freeze0/SPARK/imputed"
file_list="/u/home/a/afcarrol/project-pasaniuc/Projects/20240318_ACE_SPARK_SAIGE_prep/spark_pgen_list.txt"
keep_spark="/u/home/a/afcarrol/project-pasaniuc/Projects/20240318_ACE_SPARK_SAIGE_prep/spark_afr_sub.txt"
spark_out="/u/project/geschwind/shared/GWAS/20240319_spark_saige_data/spark_afr"
keep_iids="/u/home/a/afcarrol/project-pasaniuc/Projects/20240318_ACE_SPARK_SAIGE_prep/iid_list.txt"

# ls ${pgen_path}/*.pgen ${pgen_path}/*.psam ${pgen_path}/*.pvar > spark_pgen_list.txt


# plink2 \
#     --merge-list "${file_list}" \
#     --keep "${keep_spark}"\
#     --make-pgen \
#     --out "${spark_out}"



total_spark="/u/project/gandalm/shared/GenomicDatasets-processed/SPARK/genotype/iWES/TOPMed_imputed/SPARKiwes_TopMed_chr1.22_rsID.MikeDB_SPARKdb155"

#plink2 --bfile "${total_spark}" --make-pgen --out "${spark_out}"


plink2 --bfile "${total_spark}" \
       --keep "${keep_iids}" \
       --make-bed \
       --out "${spark_out}"



#spark_afr_covar_2.csv