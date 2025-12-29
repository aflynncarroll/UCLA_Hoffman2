#!/usr/bin/env Rscript


. /u/local/Modules/default/init/modules.sh
module load R
R 

library(tidyverse)

##############################################################################################################################
# load variants of interest
##############################################################################################################################

#vars of interest
raw_vars <- read.table('ACE_de_novo_SNVs_Indels_table_Children_included_in_analysis_v2024-03-14.txt', sep = "\t")

# Make the first row as column names
colnames(raw_vars) <- raw_vars[1, ]

# Remove the first row
raw_vars <- raw_vars[-1, ]

#raw_vars$sampleID <- paste0(raw_vars$sampleID, "_", raw_vars$sampleID) 

##############################################################################################################################
# format variants table
##############################################################################################################################

var_indv <- raw_vars %>%
  group_by(variant) %>%
  summarize(sampleIDs = list(unique(sampleID)))

vars <- as.data.frame(unique(raw_vars[,c("variant")]))
colnames(vars) <- "variant"

# Split the column into separate columns
split_data <- str_split(vars$variant, ":", simplify = TRUE)

# Rename the columns
colnames(split_data) <- c("chrom", "pos", "ref", "alt")

# Bind the split columns to the original dataframe
vars <- cbind(vars, split_data)

vars$pos <- as.numeric(vars$pos)

vars <- vars[!(vars$chrom == "chrX"),]
# remove x

vars$chr_num <- as.numeric(sub("^chr", "", vars$chrom))

##############################################################################################################################
# function to find overlapping regions
##############################################################################################################################

find_regions <- function(chr_vars, msp){

# Initialize an empty dataframe to store the results
results_df <- data.frame(variant = character(), zeros = integer(), ones = integer(), zero_ids = I(list()), one_ids = I(list()), stringsAsFactors = FALSE)
#i <- 1
# Loop through each variant in chr_vars
for (i in seq_along(chr_vars$variant)) {
  # Subset var_msp for the corresponding position
  var_msp <- msp[msp$spos <= chr_vars$pos[i] & msp$epos >= chr_vars$pos[i], ]

  var_cols <- c(outer(unlist(var_indv[var_indv$variant == chr_vars$variant[i],]$sampleIDs), c(".0", ".1"), paste0))
  #print(var_cols)
  var_msp <- var_msp[,colnames(var_msp) %in% var_cols]
  #print(colnames(var_msp))  
    
 if(nrow(var_msp)>1){
    print(paste("Overlapping variant window:", chr_vars$variant[i]))
  }
  # Extract columns ending with .0
 # id_columns <- grep(paste0(chr_vars$variant[i], "\\.0$"), names(var_msp), value = TRUE)
  id_columns <- grep("\\.0$", names(var_msp), value = TRUE)
  # Initialize counters for zeros and ones
  num_zeros <- 0
  num_ones <- 0
  zero_indv <- list()
  one_indv <- list()
  # Loop through each column and count zeros and ones
  for (col_name in id_columns) {
    # Get corresponding .1 column
    id_col_1 <- sub("\\.0$", ".1", col_name)
    
    
    # Count zeros and ones
    if(var_msp[[col_name]] == 0 & var_msp[[id_col_1]] == 0){
        zero_indv <- c(zero_indv, list(sub("\\.0$", "", col_name)))
        num_zeros <- num_zeros + 1
    }
    if(var_msp[[col_name]] == 1 & var_msp[[id_col_1]] == 1){
        one_indv <- c(one_indv, list(sub("\\.0$", "", col_name)))
        num_ones <- num_ones + 1
    }
  }
  if(length(zero_indv)<1){
        zero_indv <- NA
  }
    if(length(one_indv)<1){
            one_indv <- NA
    }
  # Append results to the dataframe
  results_df <- rbind(results_df, data.frame(variant = chr_vars$variant[i], zeros = num_zeros, ones = num_ones, zero_ids = paste(unlist(zero_indv), sep=", "), one_ids = paste(unlist(one_indv),sep=", ")))
}
 return(results_df)
    }

##############################################################################################################################
# run function on chrom 1:22 of rfmix output 
##############################################################################################################################

start.time <- Sys.time()
total_results <- data.frame(variant = character(), zeros = integer(), ones = integer(), stringsAsFactors = FALSE)

msp_dir <- "/u/home/a/afcarrol/project-pasaniuc/Projects/20240423_ace_partial_hm3/rfmix_out/"

for(chr in 1:22){
    print(paste("Starting Chromosome:", chr))
    msp_path <- paste0(msp_dir, "chr", chr, ".msp.tsv")

    # Read the first line of the file to extract column names
    col_names <- readLines(msp_path, n = 2)[2]
    col_names <- strsplit(col_names, "\t")[[1]]
    col_names[1] <- substring(col_names[1], 2)  # Remove the leading #

    # Read the .tsv file into R, skipping the first line
    msp <- read.table(msp_path, header = FALSE, sep = "\t", col.names = col_names)
    
    chr_vars <- vars[vars$chr_num == chr,]
    
    chr_result <- find_regions(chr_vars, msp)
    
    total_results <- rbind(total_results, chr_result)
}
end.time <- Sys.time()
time.taken <- round(end.time - start.time,2)
time.taken

#Time difference of 37.4 secs

write.csv(total_results, file = "ace_rare_anc_deconv.csv", row.names = FALSE)
