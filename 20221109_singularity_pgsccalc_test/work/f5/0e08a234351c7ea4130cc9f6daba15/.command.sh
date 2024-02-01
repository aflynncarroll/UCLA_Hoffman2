#!/bin/bash -euo pipefail
plink2 \
    --threads 2 \
    --memory 6144 \
    --seed 31 \
     \
    --score cineca-synthetic-subset_22_additive_0.scorefile.gz zs header-read cols=+scoresums,+denom,-fid    \
    --bfile vzs cineca_synthetic_subset_22 \
    --out cineca_synthetic_subset_22_additive_0

cat <<-END_VERSIONS > versions.yml
PLINK2_SCORE:
    plink2: $(plink2 --version 2>&1 | sed 's/^PLINK v//; s/ 64.*$//' )
END_VERSIONS
