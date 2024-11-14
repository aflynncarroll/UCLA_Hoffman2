#!/bin/bash -l
#$ -N rfmix_spark
#$ -cwd
#$ -l h_data=120,h_rt=5:00:00
#$ -j y
#$ -o ./job_out



. /u/local/Modules/default/init/modules.sh
module load anaconda3/2023.03

conda config --add channels conda-forge
conda config --add channels bioconda

cd /u/home/a/aflynnca/old-home-afcarrol/afcarrol/project-pasaniuc/Projects/20240918_saige_info

# https://github.com/saigegit/SAIGE/blob/main/conda_env/createCondaEnvSAIGE_steps.txt
conda create -n RSAIGE r-essentials r-base=4.1.2 python=3.10
conda activate RSAIGE
conda install -c anaconda cmake
conda install -c conda-forge gettext lapack r-matrix
conda install -c r r-rcpp  r-rcpparmadillo r-data.table r-bh r-matrix
conda install -c conda-forge r-spatest r-rcppeigen r-devtools  r-skat r-rcppparallel r-optparse boost openblas r-rhpcblasctl r-metaskat r-skat r-qlcmatrix r-rsqlite
pip3 install cget click
conda env export > environment-RSAIGE.yml

src_branch=main
repo_src_url=https://github.com/saigegit/SAIGE
install_dir=/path/to/your/desired/folder  # Set your desired installation directory

# Clone the repository into the specified location
git clone --depth 1 -b $src_branch $repo_src_url /u/home/a/aflynnca/software/
mv /u/home/a/aflynnca/software/ /u/home/a/aflynnca/SAIGE/

Rscript /u/home/a/aflynnca/SAIGE/extdata/install_packages.R
R CMD INSTALL --library=/u/home/a/aflynnca/SAIGE SAIGE


#/u/home/a/aflynnca/SAIGE/extdata/step1_fitNULLGLMM.R


conda create -n saige

#conda env create -f environment-RSAIGE.yml