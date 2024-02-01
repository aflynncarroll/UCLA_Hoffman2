#!/bin/bash     
#$ -N filter_r2_0.8  
#$ -e misc      
#$ -o misc      
#$ -cwd     
#$ -r y     
#$ -j y     
#$ -l h_data=32G    
#$ -l time=23:00:00     
#$ -l highp
#$ -t 1-11:1 

. /u/local/Modules/default/init/modules.sh

module load bcftools

cd /u/project/geschwind/shared/GenomicDatasets-processed/Imputed/

run_dir="/u/project/geschwind/shared/GenomicDatasets-processed/Imputed/"

output_dir="${run_dir}total_vcfs_r2_0.8/"

# Define the list of directories you want to process
directories=(
    "2010-002.clean101007"
    "2011-158.clean230815"
    "2013-111A.ATN.clean170906"
    "2013-438.clean230817"
    "2015-9017.clean170906"
    "2016-9174-3_clean190123"
    "2016-9174_clean190123"
    "2017-9154-merge_clean181212"
    "2017-9154_merge_clean190118"
    "2020-9133.clean201112"
    "2022-9163.clean230801"
)

# Get the job number from the command line argument
#job_number="${SGE_TASK_ID}"
# this was changed as the first element in the list is 0 -- not tested
job_number=$((SGE_TASK_ID - 1))

# Check if the job number is within the valid range
if [ "$job_number" -ge 0 ] && [ "$job_number" -lt "${#directories[@]}" ]; then
    # Get the directory name corresponding to the job number
    dir_to_process="${directories[$job_number]}"

    # Define the full path to the output file
    output_file="${output_dir}${dir_to_process}.vcf.gz"

    # Concatenate VCF files, filter, normalize, and annotate
    bcftools concat "${run_dir}${dir_to_process}/"chr*.dose.vcf.gz -Ou |
      bcftools view -Ou -i 'R2>0.8' |
      bcftools norm -Ou -m -any |
      bcftools norm -Ou -f /u/project/pasaniuc/afcarrol/Projects/20230906_imputed_data_qc/hg38.fa |
      bcftools annotate -Oz -o "$output_file"

    echo "Processed directory: $dir_to_process"
else
    echo "Invalid job number. Provide a job number between 0 and $(( ${#directories[@]} - 1 ))."
fi
