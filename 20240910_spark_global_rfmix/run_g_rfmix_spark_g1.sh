#!/bin/bash -l
#$ -N rfmix_spark
#$ -cwd
#$ -l h_data=200G,h_rt=3:00:00
#$ -j y
#$ -o ./job_out
#$ -t 1-22

#job numbers changed after failure
#Run local ancestry with RFmix using plink2 pfile
# chr2 and chr3 failed so run interactively with 250gb ram - maybe took longer than 3h (?)

. /u/local/Modules/default/init/modules.sh
module load anaconda3/2020.11
conda activate plink2_env
module load bcftools
module load htslib
#chrom=3
chrom=${SGE_TASK_ID}
REF_DIR=/u/project/pasaniuc/pasaniucdata/DATA/1000_Genomes_30x_GRCh38_phased
RFMIX=/u/project/pasaniuc/kangchen/software/rfmix/rfmix
###### To change by dataset
pfile=/u/project/geschwind/shared/GenomicDatasets-processed/ACE-ANALYSIS/freeze0/SPARK/hm3/chr${chrom}
out_prefix=/u/home/a/afcarrol/project-pasaniuc/Projects/20240910_spark_global_rfmix/out_g1/chr${chrom}
######
map_prefix=/u/home/a/afcarrol/project-pasaniuc/Projects/20240718_global_rfmix/ref
subset_file=/u/home/a/afcarrol/project-pasaniuc/Projects/20240910_spark_global_rfmix/spark_ids_g1.txt

#mkdir -p /u/home/a/afcarrol/project-pasaniuc/Projects/16022022_ancestry/rfmix-lanc

plink2 --pfile ${pfile} \
    --chr ${chrom} \
    --keep "${subset_file}" \
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
rm ${out_prefix}.fb.tsv