#!/bin/bash     
#$ -N KING_spark
#$ -e misc      
#$ -o misc      
#$ -cwd     
#$ -r y     
#$ -j y     
#$ -l h_data=130G    
#$ -l time=40:00:00     
#$ -l highp
#$ -t 1 

#https://kingrelatedness.com/

# Set variables for the paths
king_exec="/u/home/a/afcarrol/software/king"
bed_file="/u/project/pasaniuc/afcarrol/Projects/20230117_spark_pca_update/SPARK_20210118/SPARKiwes_TopMed_chr1.22_rsID.MikeDB_SPARKdb155_rm.sexmismatch.49.maf0.01.geno0.05.hwe1e6.bed"
out_path="/u/home/a/afcarrol/project-pasaniuc/Projects/20231012_king_spark/king_spark_output"
# Run the king command with the variables
$king_exec -b $bed_file --unrelated --degree 2 --prefix $out_path

#535
#116gb needed
#KING starts at Thu Oct 12 17:35:30 2023
# Options in effect:
#         --unrelated
#         --degree 2
#         --prefix /u/home/a/afcarrol/project-pasaniuc/Projects/20231012_king_spark/king_spark_output

# Family clustering starts at Thu Oct 12 17:54:54 2023
# Autosome genotypes stored in 88731 words for each of 69487 individuals.
# Sorting autosomes...
# Total length of 40 chromosomal segments usable for IBD segment analysis is 2642.9 Mb.
#   Information of these chromosomal segments can be found in file /u/home/a/afcarrol/project-pasaniuc/Projects/20231012_king_spark/king_spark_outputallsegs.txt

# 18 CPU cores are used to compute the pairwise kinship coefficients...
# Clustering up to 2nd-degree relatives in families...
# Individual IDs are unique across all families.

# Relationship summary (total relatives: 0 by pedigree, 154 by inference)
#                 MZ      PO      FS      2nd     3rd     4th
#   =========================================================
#   Inference     0       7       21      126     0       0

# Families are clustered into 107 new families

# A list of 40508 unrelated individuals saved in file /u/home/a/afcarrol/project-pasaniuc/Projects/20231012_king_spark/king_spark_outputunrelated.txt
# An alternative list of 28979 to-be-removed individuals saved in file /u/home/a/afcarrol/project-pasaniuc/Projects/20231012_king_spark/king_spark_outputunrelated_toberemoved.txt

# Extracting a subset of unrelated individuals ends at Thu Oct 12 17:57:58 2023
#KING ends at Thu Oct 12 17:57:58 2023