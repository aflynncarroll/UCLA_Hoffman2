#!/bin/bash    

. /u/local/Modules/default/init/modules.sh
module load anaconda3/2023.03

#conda activate plink2_env

#conda install crossmap

pip3 install CrossMap 
#crossmap.py
CrossMap.py


chain_file="/u/home/a/afcarrol/software/liftOver/chain_files/hg38ToHg19.over.chain.gz"

hg37_fasta="/u/home/a/afcarrol/software/liftOver/fasta_files/Homo_sapiens.GRCh37.dna.primary_assembly.fa"

hg38_vcf=""

hg19_vcf=""

CrossMap.py \
    vcf \
    $chain_file \
    $hg38_vcf \
    $hg37_fasta \
    $hg19_vcf


#### This is the script that I used to convert the hg18 vcf to hg38 vcf on Orion
##### convert hg18 to hg38
chain_file="/home/aflynn/tools/liftover/hg18ToHg38.over.chain.gz"
# https://hgdownload.soe.ucsc.edu/goldenPath/hg38/liftOver/
hg38_fasta="/home/aflynn/tools/crossmap/Homo_sapiens.GRCh38.dna.toplevel.fa"
#https://ftp.ensembl.org/pub/release-110/fasta/homo_sapiens/dna/
#https://ftp.ensembl.org/pub/grch37/current/fasta/homo_sapiens/dna/Homo_sapiens.GRCh37.dna.primary_assembly.fa.gz
hg38_vcf="${workdir}/hg38_vcf/${bfile_name}.vcf"

CrossMap.py \
    vcf \
    $chain_file \
    $hg18_vcf_x \
    $hg38_fasta \
    $hg38_vcf

#/u/home/a/afcarrol/software/liftOver/fasta_files/Homo_sapiens.GRCh37.dna.primary_assembly.fa
# /u/home/a/afcarrol/software/liftOver/chain_files/hg38ToHg19.over.chain.gz
