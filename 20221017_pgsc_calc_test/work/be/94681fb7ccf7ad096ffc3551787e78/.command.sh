#!/bin/bash -euo pipefail
match_variants.py         --min_overlap=0.75         --scorefile PGS001229_22.txt.txt         --target null.combined         --db match.db         --out null.scorefile

cat <<-END_VERSIONS > versions.yml
MATCH_VARIANTS:
    python: $(echo $(python -V 2>&1) | cut -f 2 -d ' ')
    sqlite: $(echo $(sqlite3 -version 2>&1) | cut -f 1 -d ' ')
END_VERSIONS
