#!/usr/bin/Rscript
#$ -N plot gwas results
#$ -e misc      
#$ -o misc      
#$ -cwd     
#$ -r y     
#$ -j y     
#$ -l h_data=60G    
#$ -l time=4:00:00     
#$ -l highp
#$ -t 1 

#cd /u/home/a/afcarrol/project-pasaniuc/Projects/20240223_SPARK_AFR_GWAS_even_case_controls 

module load R

R

########################################################################################################################################
# load libraries
########################################################################################################################################

library(tidyverse)

library(qqman)

########################################################################################################################################
# read in results
########################################################################################################################################

all_results <- data.frame()

# Loop over chromosomes 1 to 22
for (chr in 1:22) {
    print(chr)
  # Construct the path to the result file for the current chromosome
  result_file <- sprintf("/u/project/pasaniuc/afcarrol/Projects/20240305_asd_afr_gwas_no_sex_age/output_files/asd_afr_gwas_chr%d.ASD.glm.logistic", chr)

  # Read the result file
  result <- read.table(result_file, sep = "\t", header = FALSE)

  # Filter results where V7 column is equal to "ADD"
  filtered_results <- result[result$V7 == "ADD", ]

  # Add the filtered results to the data frame for all chromosomes
  all_results <- rbind(all_results, filtered_results)
}

# Print a summary of the combined results
summary(all_results)

########################################################################################################################################
# format results
########################################################################################################################################

colnames(all_results) <- c("CHROM", "POS", "ID", "REF", "ALT", "A1", "TEST", "OBS_CT", "OR", "LOG(OR)_SE", "Z_STAT", "P")


all_results <- all_results[complete.cases(all_results$P), ]

########################################################################################################################################
# make manhattan plot
########################################################################################################################################

# Specify the JPEG file path
jpeg_file <- "manhattan_plot_spark_afr_asd_nas.jpg"

# Open a JPEG device
jpeg(jpeg_file, width = 31, height = 21, units="cm", res=500)

# Create a Manhattan plot within the JPEG device
manhattan(all_results, chr = "CHROM", bp = "POS", snp = "ID", p = "P", 
          col = c("black", "grey"), main = "ASD - SPARK AFR Unrelated")

# Close the JPEG device
dev.off()

########################################################################################################################################
# make qq plot
########################################################################################################################################

jpeg(filename = "QQ_plot_spark_asd_unre_nas.jpeg", width = 31, height = 31, units="cm", res=500, type="cairo")
alpha<-median(qchisq(1-all_results$P,1))/qchisq(0.5,1)
qq(all_results$P)
text(0.5,4, paste("lambda","=",  signif(alpha, digits = 3)) )
dev.off()

########################################################################################################################################
# format and save summary table for all chromosomes
########################################################################################################################################

result_table <- all_results[,c("ID", "ALT", "REF", "OR", "P")]
colnames(result_table) <- c("SNP", "A1", "A2", "OR", "P")


write.table(result_table, file = "spark_afr_asd_unre_gwas_prscs_nas.txt", sep = "\t", quote = FALSE, row.names = FALSE, col.names = TRUE)