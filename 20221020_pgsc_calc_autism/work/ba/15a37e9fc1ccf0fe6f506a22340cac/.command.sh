#!/bin/bash -euo pipefail
aggregate_scores -s SPARK_1_additive_0.sscore.zst -o . -v

cat <<-END_VERSIONS > versions.yml
SCORE_AGGREGATE:
    pgscatalog_utils: $(echo $(python -c 'import pgscatalog_utils; print(pgscatalog_utils.__version__)'))
END_VERSIONS
