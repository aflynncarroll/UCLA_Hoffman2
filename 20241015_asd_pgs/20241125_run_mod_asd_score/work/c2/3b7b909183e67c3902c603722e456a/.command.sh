#!/bin/bash -euo pipefail
download_scorefiles -i PGS002453                           -b GRCh38         -o $PWD -v         -c pgsc_calc/1.2.0

cat <<-END_VERSIONS > versions.yml
DOWNLOAD_SCOREFILES:
    pgscatalog_utils: $(echo $(python -c 'import pgscatalog_utils; print(pgscatalog_utils.__version__)'))
END_VERSIONS
