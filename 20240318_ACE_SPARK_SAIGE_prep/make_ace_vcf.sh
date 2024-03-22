#!/bin/bash
#$ -N ace_afr_vcf
#$ -e misc      
#$ -o misc      
#$ -cwd     
#$ -r y     
#$ -j y     
#$ -l h_data=60G    
#$ -l time=10:00:00     
#$ -l highp
#$ -t 1 

#mkdir /u/project/geschwind/shared/GenomicDatasets-processed/Imputed/total_vcfs_r2_0.8/combined/ace_afr_gia_sub/bed_files
#mkdir /u/project/geschwind/shared/GenomicDatasets-processed/Imputed/total_vcfs_r2_0.8/combined/ace_afr_gia_sub/vcf_file
#mkdir /u/project/geschwind/shared/GenomicDatasets-processed/Imputed/total_vcfs_r2_0.8/combined/ace_afr_gia_sub/pgen_files
#mkdir /u/project/geschwind/shared/GenomicDatasets-processed/Imputed/total_vcfs_r2_0.8/combined/ace_afr_gia_sub/covar_files

. /u/local/Modules/default/init/modules.sh
module load anaconda3/2023.03

conda activate plink2_env


vcf_input="/u/project/geschwind/shared/GenomicDatasets-processed/Imputed/total_vcfs_r2_0.8/combined/merged_output_2.vcf.gz"
keep_list="/u/home/a/afcarrol/project-pasaniuc/Projects/20240318_ACE_SPARK_SAIGE_prep/ace_afr_sub.txt"
bed_output="/u/project/geschwind/shared/GenomicDatasets-processed/Imputed/total_vcfs_r2_0.8/combined/ace_afr_gia_sub/bed_files/merged_ace_afr"

total_pgen_output="/u/project/geschwind/shared/GenomicDatasets-processed/Imputed/total_vcfs_r2_0.8/combined/merged_output_2"

pgen_output="/u/project/geschwind/shared/GenomicDatasets-processed/Imputed/total_vcfs_r2_0.8/combined/ace_afr_gia_sub/pgen_files/merged_ace_afr"

vcf_output="/u/project/geschwind/shared/GenomicDatasets-processed/Imputed/total_vcfs_r2_0.8/combined/ace_afr_gia_sub/vcf_file/merged_ace_afr"

# Run PLINK to convert the VCF to pgen files
plink2 --vcf "${vcf_input}" \
       --make-pgen \
       --out "${total_pgen_output}"

# remove duplicated IID from psam file
awk 'NR==1 || NR>1{sub(/_.*/, "", $1)}1' "/u/project/geschwind/shared/GenomicDatasets-processed/Imputed/total_vcfs_r2_0.8/combined/merged_output_2.psam" > "/u/project/geschwind/shared/GenomicDatasets-processed/Imputed/total_vcfs_r2_0.8/combined/merged_output_2_test.psam"

# rename my test with the OG version saved
cd /u/project/geschwind/shared/GenomicDatasets-processed/Imputed/total_vcfs_r2_0.8/combined/
mv merged_output_2.psam merged_output_2_og.psam
mv merged_output_2_test.psam merged_output_2.psam
# I made a new sublist in R

cd /u/home/a/afcarrol/project-pasaniuc/Projects/20240318_ACE_SPARK_SAIGE_prep/
# subset the total pgen set to an afr pgen set
plink2 --pfile "${total_pgen_output}" \
       --keep "${keep_list}" \
       --make-pgen \
       --out "${pgen_output}"


# Run PLINK to convert the binary PLINK file to a VCF file

plink2 --pfile "${pgen_output}" \
       --export vcf bgz \
       --out "${vcf_output}"



cp ace_saige_covar.csv /u/project/geschwind/shared/GenomicDatasets-processed/Imputed/total_vcfs_r2_0.8/combined/ace_afr_gia_sub/covar_files
# ${input_dir}/merge_list.txt

# /path/to/chr1.pgen
# /path/to/chr2.pgen
# /path/to/chr3.pgen
# ...


# # Define the directory containing the PGEN files
# input_dir="/path/to/input_dir"

# # Create the merge list file
# for chrom in {1..22}; do
#     echo "${input_dir}/chr${chrom}.pgen" >> "${input_dir}/merge_list.txt"
# done

# /u/project/geschwind/shared/GenomicDatasets-processed/Imputed/total_vcfs_r2_0.8/combined/ace_afr_gia_sub/pgen_files/merged_ace_afr.pvar.
# Note: No phenotype data present.
# Warning: '_' present in original sample IDs; --export vcf will not be able to
# reconstruct them. Consider rerunning with a suitable --export id-delim= value.
# --export vcf bgz to .vcf.gz ... 59%^C