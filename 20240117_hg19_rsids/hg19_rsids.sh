#!/bin/bash     
#$ -N prscs_ace
#$ -e misc      
#$ -o misc      
#$ -cwd     
#$ -r y     
#$ -j y      
#$ -l h_data=60G    
#$ -l time=24:00:00     
#$ -l highp
#$ -t 1 

. /u/local/Modules/default/init/modules.sh
module load anaconda3/2023.03
module load bcftools

cd /u/home/a/afcarrol/project-pasaniuc/Projects/20240117_hg19_rsids

#wget https://ftp.ncbi.nih.gov/snp/latest_release/VCF/GCF_000001405.25.gz

#zcat /u/home/a/afcarrol/project-pasaniuc/Projects/20240117_hg19_rsids/GCF_000001405.25.gz | head -n 50



#https://www.dropbox.com/s/rhi806sstvppzzz/snpinfo_mult_1kg_hm3?dl=0
wget https://www.dropbox.com/s/rhi806sstvppzzz/snpinfo_mult_1kg_hm3?dl=0

#/u/home/a/afcarrol/project-pasaniuc/Projects/20240117_hg19_rsids/snpinfo_mult_1kg_hm3