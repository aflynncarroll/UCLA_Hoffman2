#!/bin/bash

#===============================#
#    setup
#===============================#

# Parameters
NCORES=20
N_PC=20

# Data paths
ATLAS_BFILE=/opt/genomics/IPHatlasreleases/ucla_atlas/qc_genotypes_archive/plink/06_17_2022/06_17_2022.qc5
ONEKG_INFO_FILE=/opt/genomics/IPHinvestigators/bogdanlab/onekg_data/20130606_g1k_3202_samples_ped_population.txt
ONEKG_BFILE=/opt/genomics/IPHinvestigators/bogdanlab/onekg_data/hg38_phase2_qced/geno/onekg.chrall.phase2.qced

# Directories
ROOT_DIR=/opt/genomics/workingdir/yiding/projects/prepare_data/01_genetic_ancestry
OUT_DIR=$ROOT_DIR/out

# Software paths
PLINK=/opt/genomics/tools/plink-1.90-x86_64/plink190
PLINK2=/opt/genomics/IPHinvestigators/bogdanlab/shared_software/plink2
ADMIXTURE=XXX

#===================================================================#
#    Define Continental Genetic Ancestry Clusters with 1000 Genome 
#===================================================================#

GIA_CONT_DIR=$OUT_DIR/gia_cont
mkdir -p $GIA_CONT_DIR

Rscript continental_ancestry.r \
    --plink=$PLINK \
    --plink2=$PLINK2 \
    --onekg_bfile=$ONEKG_BFILE.bed \
    --atlas_bfile=$ATLAS_BFILE.bed \
    --onekg_info_file=$ONEKG_INFO_FILE \
    --out_dir=$GIA_CONT_DIR \
    --ncores=$NCORES \
    --K=$N_PC
