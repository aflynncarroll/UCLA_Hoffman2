#!/bin/bash     
#$ -N ace_crossmap
#$ -e misc      
#$ -o misc      
#$ -cwd     
#$ -r y     
#$ -j y     
#$ -l h_data=100G    
#$ -l time=40:00:00     
#$ -l highp

# it took around 6h and needed 1.8T of space before it compressed to 49gb
#mkdir /u/project/geschwind/shared/GenomicDatasets-processed/Imputed/total_vcfs_r2_0.8/combined/ace_merged_hg19

. /u/local/Modules/default/init/modules.sh
module load anaconda3/2023.03

chain_file="/u/home/a/afcarrol/software/liftOver/chain_files/hg38ToHg19.over.chain.gz"

hg19_fasta="/u/home/a/afcarrol/software/liftOver/fasta_files/Homo_sapiens.GRCh37.dna.primary_assembly.fa"

hg38_vcf="/u/project/geschwind/shared/GenomicDatasets-processed/Imputed/total_vcfs_r2_0.8/combined/merged_output_2.vcf.gz"

hg19_vcf="/u/project/geschwind/shared/GenomicDatasets-processed/Imputed/total_vcfs_r2_0.8/combined/ace_merged_hg19/ace_merged_hg19.vcf"

CrossMap.py \
    vcf \
    $chain_file \
    $hg38_vcf \
    $hg19_fasta \
    $hg19_vcf \
    --compress

# Total entries: 55254922
# Failed to map: 127212
