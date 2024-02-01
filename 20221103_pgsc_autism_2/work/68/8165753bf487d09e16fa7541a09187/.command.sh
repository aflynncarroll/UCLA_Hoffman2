#!/bin/bash -euo pipefail
combine_scorefiles -s PGS000327_hmPOS_GRCh37.txt.gz             -t GRCh37             -o scorefiles.txt.gz             -v

cat <<-END_VERSIONS > versions.yml
COMBINE_SCOREFILES:
    pgscatalog_utils: $(echo $(python -c 'import pgscatalog_utils; print(pgscatalog_utils.__version__)'))
END_VERSIONS
