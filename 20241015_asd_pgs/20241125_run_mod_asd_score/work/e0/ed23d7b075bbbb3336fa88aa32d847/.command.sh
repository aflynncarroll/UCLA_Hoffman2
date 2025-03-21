#!/bin/bash -euo pipefail
plink2 \
    --threads 2 \
    --memory 8192 \
    --seed 31 \
     \
    --score SPARK_9_additive_0.scorefile.gz zs header-read cols=+scoresums,+denom,-fid    \
    --pfile vzs SPARK_9 \
    --out SPARK_9_additive_0

cat <<-END_VERSIONS > versions.yml
PLINK2_SCORE:
    plink2: $(plink2 --version 2>&1 | sed 's/^PLINK v//; s/ 64.*$//' )
END_VERSIONS
