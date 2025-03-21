#!/bin/bash -euo pipefail
plink2 \
    --threads 2 \
    --memory 8192 \
    --new-id-max-allele-len 100 missing --allow-extra-chr \
    --set-all-var-ids '@:#:$r:$a' \
    --var-id-multi @:# \
    --pfile chr8  \
    --make-just-pvar zs \
    --out SPARK_8

cp -RP chr8.pgen SPARK_8.pgen
cp -RP chr8.psam SPARK_8.psam

cat <<-END_VERSIONS > versions.yml
PLINK2_RELABELPVAR:
    plink2: $(plink2 --version 2>&1 | sed 's/^PLINK v//; s/ 64.*$//' )
END_VERSIONS
