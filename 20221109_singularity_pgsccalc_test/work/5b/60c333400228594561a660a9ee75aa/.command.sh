#!/bin/bash -euo pipefail
cp -LR report.Rmd real_report.Rmd
mv real_report.Rmd report.Rmd

echo nextflow run pgscatalog/pgsc_calc -r v1.2.0 -profile singularity --input /u/project/pasaniuc/afcarrol/Projects/20221020_pgsc_calc_autism/SPARK_full.csv --target_build GRCh38 --pgs_id PGS000327 --min_overlap 0.5 > command.txt
echo "keep_multiallelic: false" > params.txt
echo "keep_ambiguous   : false"    >> params.txt
echo "min_overlap      : 0.5"       >> params.txt

R -e 'rmarkdown::render("report.Rmd",         output_options = list(self_contained=TRUE))'

cat <<-END_VERSIONS > versions.yml
SCORE_REPORT:
    R: $(echo $(R --version 2>&1) | head -n 1 | cut -f 3 -d ' ')
END_VERSIONS
