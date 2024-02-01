

. /u/local/Modules/default/init/modules.sh
module load anaconda3/2023.03

conda activate plink2_env

cd /u/project/geschwind/shared/GenomicDatasets-processed/Imputed/total_vcfs_r2_0.8/combined_hm3_filtered/chr_run/failed_retry

plink2 --vcf /u/project/geschwind/shared/GenomicDatasets-processed/Imputed/total_vcfs_r2_0.8/combined/merged_output_2.vcf.gz \
       --chr 12 \
       --extract /u/project/pasaniuc/afcarrol/Projects/20230906_imputed_data_qc/hm3_filtered_snps_ace.txt \
       --max-alleles 2 \
       --make-bed \
       --out "/u/project/geschwind/shared/GenomicDatasets-processed/Imputed/total_vcfs_r2_0.8/combined_hm3_filtered/chr_run/failed_retry/merged_hm3_chr12"
       
       plink2 --vcf /u/project/geschwind/shared/GenomicDatasets-processed/Imputed/total_vcfs_r2_0.8/combined/merged_output_2.vcf.gz \
       --chr 21 \
       --extract /u/project/pasaniuc/afcarrol/Projects/20230906_imputed_data_qc/hm3_filtered_snps_ace.txt \
       --max-alleles 2 \
       --make-bed \
       --out "/u/project/geschwind/shared/GenomicDatasets-processed/Imputed/total_vcfs_r2_0.8/combined_hm3_filtered/chr_run/failed_retry/merged_hm3_chr21"