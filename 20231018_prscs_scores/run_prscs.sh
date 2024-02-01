
#!/bin/bash     
#$ -N prs_cs
#$ -e misc      
#$ -o misc      
#$ -cwd     
#$ -r y     
#$ -j y      
#$ -l h_data=130G    
#$ -l time=40:00:00     
#$ -l highp
#$ -t 1 



#EUR ld reference
/u/project/pasaniuc/afcarrol/software/PRScs_ref/ldblk_1kg_eur

#AFR ld reference
/u/project/pasaniuc/afcarrol/software/PRScs_ref/ldblk_1kg_afr

# Path to PRS-CS script 
PRS_CS_SCRIPT="/u/project/pasaniuc/afcarrol/software/PRScs/PRScs.py"

# Path to summary statistics
# gwas for SPARK autism
# hg38
SUMMARY_STATS_spark="/u/project/geschwind/vishakha/Projects/GWAS_AFR/GWAS_SAIGE_AFR_11M_var/SAIGE_RESULT/SPARK_AA_marker_chr1-22_vcf.txt"

# gwas for iPSYCH autism - grove et al
# hg19
SUMMARY_STATS_grove="/u/project/pasaniuc/afcarrol/Projects/20231018_prscs_scores/iPSYCH-PGC_ASD_Nov2017.txt"




# Target dataset (plink .bed/.bim/.fam files)
TARGET_DATASET_PREFIX="target_data"

# Output directory
OUTPUT_DIR="prs_output"

# LD reference panel (e.g., 1000 Genomes)
LD_REFERENCE_PANEL="/path/to/ld_reference_panel"

# Set the p-value threshold for clumping
P_VALUE_THRESHOLD="0.001"

# Set the clumping window and r2 threshold
CLUMP_WINDOW="1000"
CLUMP_R2="0.1"

# Run PRS-CS
python $PRS_CS_SCRIPT \
  --ref_dir $LD_REFERENCE_PANEL \
  --bim_prefix $TARGET_DATASET_PREFIX \
  --sst_file $SUMMARY_STATS_spark \
  --n_gwas 100000 \
  --p_thr $P_VALUE_THRESHOLD \
  --out_dir $OUTPUT_DIR \
  --a "0.01 0.05 0.1" \
  --c $CLUMP_R2 \
  --b $CLUMP_WINDOW

  