#!/bin/bash     
#$ -N SPARK_chrom_split 
#$ -e misc      
#$ -o misc      
#$ -cwd     
#$ -r y     
#$ -j y     
#$ -l h_data=16G    
#$ -l time=23:00:00     
#$ -l highp
#$ -t 1-22:1 

. /u/local/Modules/default/init/modules.sh

module load plink


plink --bfile SPARK_20210118/SPARKiwes_TopMed_chr1.22_rsID.MikeDB_SPARKdb155_rm.sexmismatch.49.maf0.01.geno0.05.hwe1e6 \
--chr ${SGE_TASK_ID} \
--extract hm3_snp_pos.txt \
--make-bed \
--out \
SPARK_bed_by_chrom/SPARK_genos_chr${SGE_TASK_ID}; \
