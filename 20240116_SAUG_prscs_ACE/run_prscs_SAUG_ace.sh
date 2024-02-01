#!/bin/bash     
#$ -N prscs_ace
#$ -e misc      
#$ -o misc      
#$ -cwd     
#$ -r y     
#$ -j y      
#$ -l h_data=130G    
#$ -l time=40:00:00     
#$ -l highp
#$ -t 1 
### PRScs.sh
### Use PRScs to generate SNP weights, then use plink to get individual PRS


. /u/local/Modules/default/init/modules.sh
module load anaconda3/2023.03
module load plink

######### PRS-CS #########
tar -O -xzf /u/project/pasaniuc/afcarrol/software/PRScs_ref/ldblk_1kg_afr.tar.gz | head -n 10

# run #1 - wrong format  aka no rsids
# ace_bim="/u/project/geschwind/shared/GenomicDatasets-processed/Imputed/total_vcfs_r2_0.8/combined/ace_merged_hg19/ace_merged_hg19_afr"
# afr_ref="/u/project/pasaniuc/afcarrol/software/PRScs_ref/ldblk_1kg_afr"
# prscs_out="/u/home/a/afcarrol/project-pasaniuc/Projects/20240116_SAUG_prscs_ACE/PRSCS_output_weights"
# sst_saug="/u/home/a/afcarrol/project-pasaniuc/Projects/20231219_SPARK_AFR_ASD_GWAS/spark_afr_asd_unre_gwas_prscs_hg19.txt"
# prscs="/u/project/pasaniuc/afcarrol/software/PRScs/PRScs.py"

#mkdir /u/home/a/afcarrol/project-pasaniuc/Projects/20240116_SAUG_prscs_ACE/PRSCS_output_weights

ace_bim="/u/project/geschwind/shared/GenomicDatasets-processed/Imputed/total_vcfs_r2_0.8/combined/ace_merged_hg19/prscs_filtered/ace_merged_hg19_afr_prscs_rsids"
afr_ref="/u/project/pasaniuc/afcarrol/software/PRScs_ref/ldblk_1kg_afr"
prscs_out="/u/home/a/afcarrol/project-pasaniuc/Projects/20240116_SAUG_prscs_ACE/PRSCS_output_weights/saug_output_weights"
sst_saug="/u/project/pasaniuc/afcarrol/Projects/20240117_hg19_rsids/saug_1kg_hg19.txt"
prscs="/u/project/pasaniuc/afcarrol/software/PRScs/PRScs.py"




# Run PRScs
python ${prscs}\
    --ref_dir=${afr_ref} \
    --bim_prefix=${ace_bim} \
    --sst_file=${sst_saug} \
    --n_gwas=2088 \
    --phi=1e-2 \
    --out_dir=${prscs_out}


#### concatenate output files
cat /u/home/a/afcarrol/project-pasaniuc/Projects/20240116_SAUG_prscs_ACE/PRSCS_output_weights/*.txt > /u/home/a/afcarrol/project-pasaniuc/Projects/20240116_SAUG_prscs_ACE/PRSCS_output_weights/saug_output_weights_total.txt


#### run plink to calculate PRS
plink \
    --bfile ${ace_bim} \
    --score /u/home/a/afcarrol/project-pasaniuc/Projects/20240116_SAUG_prscs_ACE/PRSCS_output_weights/saug_output_weights_total.txt 2 4 6 \
    --out /u/home/a/afcarrol/project-pasaniuc/Projects/20240116_SAUG_prscs_ACE/saug_scores

# Results written to /u/home/a/afcarrol/project-pasaniuc/Projects/20240116_SAUG_prscs_ACE/saug_scores.profile
nrows /u/home/a/afcarrol/project-pasaniuc/Projects/20240116_SAUG_prscs_ACE/saug_scores.profile

##### file structire
# tar -O -xzf /u/project/pasaniuc/afcarrol/software/PRScs_ref/ldblk_1kg_afr.tar.gz | head -n 10
# CHR     SNP     BP      A1      A2      MAF
# 1       rs2185539       566875  T       C       0.124800
# 1       rs6681105       592075  C       T       0.021940
# 1       rs3131972       752721  G       A       0.290500
# 1       rs3131969       754182  G       A       0.352500
# 1       rs1048488       760912  T       C       0.444800
# 1       rs12562034      768448  A       G       0.085480
# 1       rs4040617       779322  G       A       0.472800
# 1       rs2905036       792480  C       T       0.078670
# 1       rs4245756       799463  T       C       0.098340

# head /u/project/geschwind/shared/GenomicDatasets-processed/Imputed/total_vcfs_r2_0.8/combined/ace_merged_hg19/ace_merged_hg19_afr.bim
# 1       chr1:10930:G:A  0       10930   A       G
# 1       chr1:10989:G:A  0       10989   A       G
# 1       chr1:51955:G:C  0       51955   C       G

# a1 then a2

#tar -xvzf /u/project/pasaniuc/afcarrol/software/PRScs_ref/ldblk_1kg_afr.tar.gz -C /u/home/a/afcarrol/project-pasaniuc/Projects/20240117_hg19_rsids