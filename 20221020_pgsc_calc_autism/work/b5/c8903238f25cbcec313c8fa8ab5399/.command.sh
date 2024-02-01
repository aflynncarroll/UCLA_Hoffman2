#!/bin/bash -euo pipefail
export POLARS_MAX_THREADS=2

match_variants         --min_overlap 0.75         --dataset cineca_synthetic_subset         --scorefile scorefiles.txt.gz         --target *.vars         --split                                    --outdir $PWD         -v

cat <<-END_VERSIONS > versions.yml
MATCH_VARIANTS:
    pgscatalog_utils: $(echo $(python -c 'import pgscatalog_utils; print(pgscatalog_utils.__version__)'))
END_VERSIONS
