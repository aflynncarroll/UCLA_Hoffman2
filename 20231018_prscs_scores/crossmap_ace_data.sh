#!/bin/bash     
#$ -N crossmap Ace data to hg19
#$ -e misc      
#$ -o misc      
#$ -cwd     
#$ -r y     
#$ -j y     
#$ -l h_data=130G    
#$ -l time=40:00:00     
#$ -l highp
#$ -t 1 

. /u/local/Modules/default/init/modules.sh
module load anaconda3/2023.03

#### This is the script that I used to convert the hg18 vcf to hg38 vcf on Orion
##### convert hg18 to hg38
chain_file="/u/home/a/afcarrol/software/liftOver/chain_files/hg38ToHg19.over.chain.gz"
# https://hgdownload.soe.ucsc.edu/goldenPath/hg38/liftOver/
hg19_fasta="/u/home/a/afcarrol/software/liftOver/fasta_files/Homo_sapiens.GRCh37.dna.primary_assembly.fa"
#https://ftp.ensembl.org/pub/release-110/fasta/homo_sapiens/dna/
#https://ftp.ensembl.org/pub/grch37/current/fasta/homo_sapiens/dna/Homo_sapiens.GRCh37.dna.primary_assembly.fa.gz

input_vcf="/u/project/geschwind/shared/GenomicDatasets-processed/Imputed/total_vcfs_r2_0.8/combined/merged_output_2.vcf.gz"

out_vcf="/u/project/geschwind/shared/GenomicDatasets-processed/Imputed/total_vcfs_r2_0.8/combined/hg19_vcf"

CrossMap.py \
    vcf \
    $chain_file \
    $input_vcf \
    $hg19_fasta \
    $out_vcf

#/u/home/a/afcarrol/software/liftOver/fasta_files/Homo_sapiens.GRCh37.dna.primary_assembly.fa
# /u/home/a/afcarrol/software/liftOver/chain_files/hg38ToHg19.over.chain.gz