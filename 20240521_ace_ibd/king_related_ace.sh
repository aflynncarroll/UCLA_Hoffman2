#!/bin/bash
#$ -N king_ibd_ace
#$ -e misc      
#$ -o misc      
#$ -cwd     
#$ -r y     
#$ -j y     
#$ -l h_data=120G    
#$ -l time=10:00:00     
#$ -l highp
#$ -t 1 


bed_file=/u/project/geschwind/shared/GenomicDatasets-processed/Imputed/total_vcfs_r2_0.8/filtered_1kg/merged/maf_0.4/total_1kg_ace_0.4.bed
out_path=/u/home/a/afcarrol/project-pasaniuc/Projects/20240521_ace_ibd/king_ace_related
king_exec="/u/home/a/afcarrol/software/king"

# Run the king command with the variables
$king_exec -b $bed_file --related --prefix $out_path