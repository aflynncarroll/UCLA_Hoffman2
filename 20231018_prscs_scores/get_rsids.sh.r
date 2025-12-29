#!/bin/bash     
#$ -N get_vars
#$ -e misc      
#$ -o misc      
#$ -cwd     
#$ -r y     
#$ -j y     
#$ -l h_data=130G    
#$ -l time=40:00:00     
#$ -l highp
#$ -t 1 


module load R

R

library(dplyr)
library(biomaRt)

if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("biomaRt")



spark_table <- read.table("spark_gwas.txt")

# Set the column names using the values from the first row
colnames(spark_table) <- unlist(spark_table[1,])

# Remove the first row (optional if you don't need it anymore)
spark_table <- spark_table[-1,]

rsids <- c(unique(spark_table$SNP))

snpmart = useEnsembl(biomart = "snp", dataset="hsapiens_snp", version = "GRCh37")

# Get the chromosome, position, reference allele, and alternate allele for each rsID
snp_info <- getBM(attributes = c("refsnp_id", "chr_name", "chrom_start", "allele", "minor_allele"),
                  filters = "snp_filter", values = rsids, mart = snpmart)

writeLines(unlist(rsids), "spark_rsids.txt")