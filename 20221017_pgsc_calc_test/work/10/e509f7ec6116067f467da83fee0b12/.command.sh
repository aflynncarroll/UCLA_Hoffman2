#!/bin/bash -euo pipefail
# dumb workaround symlink & out_dir (rmarkdown)
# don't want to stageInMode very big score files
cp report.Rmd report.rmd
R -e 'rmarkdown::render("report.rmd",         params = list(file = "results.scorefile"),         output_options = list(self_contained=TRUE))'

cat <<-END_VERSIONS > versions.yml
MAKE_REPORT:
    R: $(echo $(R --version 2>&1) | head -n 1 | cut -f 3 -d ' ')
END_VERSIONS
