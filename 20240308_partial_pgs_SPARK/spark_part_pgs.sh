#!/bin/bash
#$ -N spark ancestry partial pgs with admix-kit
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
module load anaconda3

mkdir /u/home/a/afcarrol/project-pasaniuc/Projects/20240308_partial_pgs_SPARK/out

for chrom in {1..22}
do
pfile=/u/home/a/afcarrol/project-pasaniuc/Projects/20230117_spark_pca_update/SPARK_pgen_by_chrom/SPARK_genos_chr${chrom}
weights=/u/home/a/afcarrol/project-pasaniuc/Projects/20240229_ace_partial_pgs/grove_hg19_asd.tsv
out_prefix=/u/home/a/afcarrol/project-pasaniuc/Projects/20240308_partial_pgs_SPARK/out/spark_chr${chrom}

admix calc-partial-pgs \
    --plink-path ${pfile}.pgen \
    --weights-path ${weights} \
    --dset-build 'hg38->hg19' \
    --out ${out_prefix}

done