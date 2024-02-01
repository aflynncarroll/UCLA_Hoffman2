#!/bin/bash -euo pipefail
plink2 \
    --score 22.keep \
    --pfile null_22 \
    --out null_22

cat <<-END_VERSIONS > versions.yml
PLINK2_SCORE:
    plink2: $(plink2 --version 2>&1 | sed 's/^PLINK v//; s/ 64.*$//' )
END_VERSIONS
