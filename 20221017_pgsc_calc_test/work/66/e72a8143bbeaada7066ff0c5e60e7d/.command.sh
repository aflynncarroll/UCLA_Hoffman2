#!/bin/bash -euo pipefail
sed -i -e 's/:/\t/' null.scorefile > scorefile # fix first column
mawk -v split_mode=chromosome         -f /u/home/a/afcarrol/.nextflow/assets/pgscatalog/pgsc_calc/bin/split_bim.awk         null.scorefile
sed -i -e 's/\t/:/' *.keep # restore first column

cat <<-END_VERSIONS > versions.yml
SCOREFILE_SPLIT:
    mawk: $(echo $(mawk -W version 2>&1) | cut -f 2 -d ' ')
END_VERSIONS
