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

#cd /u/home/a/afcarrol/project-pasaniuc/Projects/20240314_ACE_ASD_gwas_larger_pop

#module load R

#R

########################################################################################################################################
# load libraries
########################################################################################################################################

library(tidyverse)

library(qqman)

########################################################################################################################################
# read in results
########################################################################################################################################

all_results <- read.csv("raw_ace_gwas.csv")


########################################################################################################################################
# make manhattan plot
########################################################################################################################################

# Specify the JPEG file path
jpeg_file <- "manhattan_plot_ace_afr_asd_nas.jpg"

# Open a JPEG device
jpeg(jpeg_file, width = 31, height = 21, units="cm", res=500)

# Create a Manhattan plot within the JPEG device
manhattan(all_results, chr = "CHROM", bp = "POS", snp = "ID", p = "P", 
          col = c("black", "grey"), main = "ASD - ACE AFR Unrelated")

# Close the JPEG device
dev.off()

########################################################################################################################################
# make qq plot
########################################################################################################################################

jpeg(filename = "QQ_plot_ace_asd_unre_nas.jpeg", width = 31, height = 31, units="cm", res=500, type="cairo")
alpha<-median(qchisq(1-all_results$P,1))/qchisq(0.5,1)
qq(all_results$P)
text(0.5,4, paste("lambda","=",  signif(alpha, digits = 3)) )
dev.off()
