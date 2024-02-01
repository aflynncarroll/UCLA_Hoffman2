#!/bin/bash -euo pipefail
plink2 \
    --new-id-max-allele-len 100 missing --exclude <(echo .) \
    --set-all-var-ids '@:#:$r:$a' \
    --bfile null \
    --make-pgen \
    --out null_1

cat <<-END_VERSIONS > versions.yml
PLINK2_RELABEL:
    plink2: $(plink2 --version 2>&1 | sed 's/^PLINK v//; s/ 64.*$//' )
END_VERSIONS
