#!/bin/bash -euo pipefail
mawk -v out=pgs_updated_2.txt_checked.txt         -f /u/home/a/afcarrol/.nextflow/assets/pgscatalog/pgsc_calc/bin/check_scorefile.awk         pgs_updated_2.txt

cat <<-END_VERSIONS > versions.yml
SCOREFILE_CHECK:
    mawk: $(echo $(mawk -W version 2>&1) | cut -f 2 -d ' ')
END_VERSIONS
