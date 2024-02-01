#!/bin/bash -euo pipefail
plink2 \
    --threads 2 \
    --memory 6144 \
    --new-id-max-allele-len 100 missing --allow-extra-chr \
    --set-all-var-ids '@:#:$r:$a' \
    --var-id-multi @:# \
    --bfile cineca_synthetic_subset \
    --make-just-bim zs \
    --out cineca_synthetic_subset_22

cp -RP cineca_synthetic_subset.bed cineca_synthetic_subset_22.bed
cp -RP cineca_synthetic_subset.fam cineca_synthetic_subset_22.fam

cat <<-END_VERSIONS > versions.yml
PLINK2_RELABELBIM:
    plink2: $(plink2 --version 2>&1 | sed 's/^PLINK v//; s/ 64.*$//' )
END_VERSIONS
