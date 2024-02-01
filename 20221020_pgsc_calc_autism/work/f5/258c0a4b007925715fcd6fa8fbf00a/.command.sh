#!/bin/bash -euo pipefail
plink \
    --vcf chr1.vcf.gz \
     \
    --threads 2 \
    --out null

cat <<-END_VERSIONS > versions.yml
"PGSC_CALC:PGSCALC:INPUT_CHECK:PLINK_VCF":
    plink: $(echo $(plink --version 2>&1) | sed 's/^PLINK v//' | sed 's/..-bit.*//' )
END_VERSIONS
