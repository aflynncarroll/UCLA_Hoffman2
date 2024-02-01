#!/bin/bash -euo pipefail
mawk -v out=PGS001229_22.txt.txt         -f /u/home/a/afcarrol/.nextflow/assets/pgscatalog/pgsc_calc/bin/qc_scorefile.awk         PGS001229_22.txt_checked.txt

cat <<-END_VERSIONS > versions.yml
SCOREFILE_QC:
    mawk: $(echo $(mawk -W version 2>&1) | cut -f 2 -d ' ')
END_VERSIONS
