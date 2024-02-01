#!/bin/bash -euo pipefail
mawk \
    'FNR == 1 && NR != 1 { next }
    { print }' null_22.pvar > null.combined

cat <<-END_VERSIONS > versions.yml
COMBINE_BIM:
    mawk: $(echo $(mawk -W version 2>&1) | cut -f 2 -d ' ')
END_VERSIONS
