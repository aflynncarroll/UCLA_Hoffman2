#!/bin/bash -l
#$ -N rfmix_spark
#$ -cwd
#$ -l h_data=120G,h_rt=16:00:00,highp
#$ -j y
#$ -o ./job_out
#$ -t 1-22

#Run local ancestry with RFmix using plink2 pfile
. /u/local/Modules/default/init/modules.sh
module load anaconda3/2020.11
conda activate plink2_env
module load bcftools
module load htslib
#chrom=1
chrom=${SGE_TASK_ID}
REF_DIR=/u/project/pasaniuc/pasaniucdata/DATA/1000_Genomes_30x_GRCh38_phased
RFMIX=/u/project/pasaniuc/kangchen/software/rfmix/rfmix
pfile=/u/project/geschwind/shared/GenomicDatasets-processed/Imputed/total_vcfs_r2_0.8/combined/hm3_filtered_pfiles/ace_hm3_chr${chrom}
out_prefix=/u/home/a/afcarrol/project-pasaniuc/Projects/20240718_global_rfmix/out/chr${chrom}
map_prefix=/u/home/a/afcarrol/project-pasaniuc/Projects/20240718_global_rfmix/ref

#mkdir -p /u/home/a/afcarrol/project-pasaniuc/Projects/16022022_ancestry/rfmix-lanc

plink2 --pfile ${pfile} \
    --chr ${chrom} \
    --output-chr 26 \
    --export vcf bgz id-delim=- \
    --out ${out_prefix}.tmp

tabix -p vcf ${out_prefix}.tmp.vcf.gz


# run RFmix
${RFMIX} \
    -f ${out_prefix}.tmp.vcf.gz \
    -r ${REF_DIR}/out/vcf/chr${chrom}.nochr.vcf.gz \
    -m ${map_prefix}/global_part.tsv \
    -g ${REF_DIR}/out/metadata/genetic_map/chr${chrom}.tsv \
    --chromosome=${chrom} \
    -o ${out_prefix}

rm ${out_prefix}*tmp*