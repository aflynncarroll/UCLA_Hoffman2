#!/bin/bash -euo pipefail
combine_scorefiles -s asd_genes.txt             -t GRCh38             -o scorefiles.txt.gz             -v

cat <<-END_VERSIONS > versions.yml
COMBINE_SCOREFILES:
    pgscatalog_utils: $(echo $(python -c 'import pgscatalog_utils; print(pgscatalog_utils.__version__)'))
END_VERSIONS
