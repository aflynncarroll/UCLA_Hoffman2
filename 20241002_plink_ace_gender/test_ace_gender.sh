#!/bin/bash     
#$ -N ace saige
#$ -e misc      
#$ -o misc      
#$ -cwd     
#$ -r y     
#$ -j y     
#$ -l h_data=120G    
#$ -l time=3:00:00     
#$ -l highp
#$ -t 1 

cd /u/project/pasaniuc/afcarrol/Projects/20241002_plink_ace_gender/

. /u/local/Modules/default/init/modules.sh
module load anaconda3/2023.03

module load plink

# login 1
cd /u/project/geschwind/shared/GenomicDatasets-processed/Imputed/2013-438.clean230817


# 2013-438.clean230817

mkdir /u/project/geschwind/shared/GenomicDatasets-processed/ACE_X_chroms/2013-438.clean230817

unzip -P "va9ug9FWwGGR6C" /u/project/geschwind/shared/GenomicDatasets-processed/Imputed/2013-438.clean230817/chr_X.zip -d /u/project/geschwind/shared/GenomicDatasets-processed/ACE_X_chroms/2013-438.clean230817

plink --vcf /u/project/geschwind/shared/GenomicDatasets-processed/ACE_X_chroms/2013-438.clean230817/chrX.dose.vcf.gz --make-bed \
    --out /u/project/geschwind/shared/GenomicDatasets-processed/ACE_X_chroms/2013-438.clean230817/2013-438.clean230817_X

plink --bfile /u/project/geschwind/shared/GenomicDatasets-processed/ACE_X_chroms/2013-438.clean230817/2013-438.clean230817_X --check-sex \
    --out /u/project/geschwind/shared/GenomicDatasets-processed/ACE_X_chroms/2013-438.clean230817/2013-438.clean230817_X



# 2011-158.clean230815

mkdir /u/project/geschwind/shared/GenomicDatasets-processed/ACE_X_chroms/2011-158.clean230815

unzip -P "t3MYNd|aEI2o[k" /u/project/geschwind/shared/GenomicDatasets-processed/Imputed/2011-158.clean230815/chr_X.zip -d \
    /u/project/geschwind/shared/GenomicDatasets-processed/ACE_X_chroms/2011-158.clean230815


plink --vcf /u/project/geschwind/shared/GenomicDatasets-processed/ACE_X_chroms/2011-158.clean230815/chrX.dose.vcf.gz --make-bed \
    --out /u/project/geschwind/shared/GenomicDatasets-processed/ACE_X_chroms/2011-158.clean230815/2011-158.clean230815_X

plink --bfile /u/project/geschwind/shared/GenomicDatasets-processed/ACE_X_chroms/2011-158.clean230815/2011-158.clean230815_X --check-sex \
    --out /u/project/geschwind/shared/GenomicDatasets-processed/ACE_X_chroms/2011-158.clean230815/2011-158.clean230815_X

    # 2022-9163.clean230801

mkdir /u/project/geschwind/shared/GenomicDatasets-processed/ACE_X_chroms/2022-9163.clean230801

unzip -P "dwv4cjCqFhC1BE" /u/project/geschwind/shared/GenomicDatasets-processed/Imputed/2022-9163.clean230801/chr_X.zip -d \
    /u/project/geschwind/shared/GenomicDatasets-processed/ACE_X_chroms/2022-9163.clean230801


plink --vcf /u/project/geschwind/shared/GenomicDatasets-processed/ACE_X_chroms/2022-9163.clean230801/chrX.dose.vcf.gz --make-bed \
    --out /u/project/geschwind/shared/GenomicDatasets-processed/ACE_X_chroms/2022-9163.clean230801/2022-9163.clean230801_X

plink --bfile /u/project/geschwind/shared/GenomicDatasets-processed/ACE_X_chroms/2022-9163.clean230801/2022-9163.clean230801_X --check-sex \
    --out /u/project/geschwind/shared/GenomicDatasets-processed/ACE_X_chroms/2022-9163.clean230801/2022-9163.clean230801_X

process_genomic_data() {
# Assign input parameters to variables
local dataset_name="$1"
local password="$2"

# Create the directory
mkdir -p "/u/project/geschwind/shared/GenomicDatasets-processed/ACE_X_chroms/$dataset_name"

# Unzip the file
unzip -P "$password" "/u/project/geschwind/shared/GenomicDatasets-processed/Imputed/${dataset_name}/chr_X.zip" -d \
    "/u/project/geschwind/shared/GenomicDatasets-processed/ACE_X_chroms/${dataset_name}"

# Convert VCF to PLINK format
plink --vcf "/u/project/geschwind/shared/GenomicDatasets-processed/ACE_X_chroms/${dataset_name}/chrX.dose.vcf.gz" --make-bed \
    --out "/u/project/geschwind/shared/GenomicDatasets-processed/ACE_X_chroms/${dataset_name}/${dataset_name}_X"

# Check sex discrepancies
plink --bfile "/u/project/geschwind/shared/GenomicDatasets-processed/ACE_X_chroms/${dataset_name}/${dataset_name}_X" --check-sex \
    --out "/u/project/geschwind/shared/GenomicDatasets-processed/ACE_X_chroms/${dataset_name}/${dataset_name}_X"
}

process_genomic_data "2010-002.clean101007" "C)A6uZIAeVhcy6"

process_genomic_data "2020-9133.clean201112" "iXzHMFHj59mTwA"

process_genomic_data "2017-9154_merge_clean190118" "oM4gvZaR3fUwWG"

process_genomic_data "2016-9174_clean190123" "8QUfhsq2hGJTrZ"

process_genomic_data "2015-9017.clean170906" "V0YYB>rwFc3Nho"

process_genomic_data "2017-9154-merge_clean181212" "gpAQ9qxOb6iMDS"

process_genomic_data "2016-9174-3_clean190123" "IxHgVux3t.Q1yW"

process_genomic_data "2013-111A.ATN.clean170906" "NYojgSoTt3XT2<"

