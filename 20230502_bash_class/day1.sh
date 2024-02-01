#!/bin/bash

# qrsh -l h_data=16G,h_rt=8:00:00
# cd project-pasaniuc/Projects/20230502_bash_class/

NUMcores=3; GBperCORE=4; TIME="3:30:00"

qrsh -pe shared "${NUMcores}"  \
  -l i,h_rt="${TIME}",h_data="${GBperCORE}"g,h_vmem="$((NUMcores*GBperCORE))"g
# should request in this format for hoffman resources

ls /u/scratch/c/cokus/ADVUXworkshop2023May
# this is where the data is for this class

# input files
#SRX101207se--cat-SRR400579-SRR400580-SRR400573-SRR400572-SRR364317.fastq.gz
#SRX101208se--cat-SRR364090-SRR400574-SRR400575-SRR400581.fastq.gz

# less - can read gzip files

less /u/scratch/c/cokus/ADVUXworkshop2023May/SRX101207se--cat-SRR400579-SRR400580-SRR400573-SRR400572-SRR364317.fastq.gz

# paste - can merge files together line by line (?)

cd /u/scratch/c/cokus/ADVUXworkshop2023May

gzip -c -d SRX101207se--cat-SRR400579-SRR400580-SRR400573-SRR400572-SRR364317.fastq.gz | paste - - - -             | less

# ctr + c = cancel

# gzip -c -d SRX101207se--cat-SRR400579-SRR400580-SRR400573-SRR400572-SRR364317.fastq.gz | paste - - - - | cut -c 2- |    \
#     awk -F $'\t' '{ split($1, name, / /); printf("@%s %s\n%s\n+\n%s\n", name[2], name[1], $2, $4); }' | gzip -c --best  \
#   > SRX101207se--cat-SRR400579-SRR400580-SRR400573-SRR400572-SRR364317-deSRAified.fastq.gz &
#### & makes the command run in the backround

# pv SRX101207se--cat-SRR400579-SRR400580-SRR400573-SRR400572-SRR364317.fastq.gz | gzip -c -d | paste - - - - |      \
#   cut -c 2- | awk -F $'\t' '{ split($1, name, / /); printf("@%s %s\n%s\n+\n%s\n", name[2], name[1], $2, $4); }' |  \
#   gzip -c --best  > SRX101207se--cat-SRR400579-SRR400580-SRR400573-SRR400572-SRR364317-deSRAified.fastq.gz
#### pv creates a progress bar for interactive running jobs

#for x in a b c; do  sleep 600 & done
## for will make the run parallel on an interactive node
## the sleep command just runs a countdown as an example

# name file in progress_... then last step renames it as the correct name - you can easily check

# && run thing to left and only if that succeeds, run the thing to the right

# for x in SRX*[0-9].fastq.gz; do
#   gzip -c -d "${x}" | wc > "${x%.gz}".WC &
# done
### decompresses by row then changes name ? i thought it counts lines and such? why is he renaming it?
### wc > "${x%.gz}".WC replacing the .gz with .WC at end of file name

## local sets where the variable names are applicable - useful when you are stringing multiple pieces together



$ for x in SRX*[0-9].fastq.gz; do # ...SHOULD REALLY DO A UNIFORMLY RANDOM SAMPLING, BUT WE ARE NOT USING THIS DATA FOR REAL... gzip -c -d "${x}" | head -n $(( (10*1000*1000 + 100*1000) * 4)) | gzip -c --fast > "${x%--*}"-head.fastq.gz &
done # ...real work might use --best to trade more time for reduced space. $ jobs
$ ps -Fww -u "${USER}"
$ set -b; watch ls -la '*-head.fastq.gz' «CTRL+C» # ...use “set +b” to go back to shell default of deferred status updates.
# you basically see if their are updates to the file every couple of seconds

# leading 0 activates octal in bash - base 8 counting
# awk can be used to avoid this

# xargs - you can run things in parallel from a list of file names

# /usr/bin/time -v 
## you can run this with a test to see time and memory needed to run one partitian of a job

# tell me my memory usage



###### day 2

# qacct -j Job_number
### see after the fact what resources the job needed

# qsub multiple jobs at a time on hoffman - your limit is 100-200 or so




# can copy everything into my scratch directory and follow along
# these provide good templates if you want to use them for your analysis
cp -pRvi /u/scratch/c/cokus/ADVUXworkshop2023May/SJCstylesOfUsingHoffman2 \
Example: older versions of Workshop 6 included Style 6’s, "${SCRATCH}"/SJCstylesOfUsingHoffman2-20230503 && \
cd     "${SCRATCH}"/SJCstylesOfUsingHoffman2-20230503
newer versions have switched to Style 5



# make config files - lists of the files to run on ect. using ls -a (I think it was -a...)

# makedir -p   it makes a directory only if it does not already exist