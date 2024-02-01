#!/bin/bash -euo pipefail
plink2 \
    --threads 2 \
    --memory 8192 \
    --new-id-max-allele-len 100 missing --allow-extra-chr \
    --set-all-var-ids '@:#:$r:$a' \
    --var-id-multi @:# \
    --pfile chr20  \
    --make-just-pvar zs \
    --out SPARK_20

cp -RP chr20.pgen SPARK_20.pgen
cp -RP chr20.psam SPARK_20.psam

cat <<-END_VERSIONS > versions.yml
PLINK2_RELABELPVAR:
    plink2: $(plink2 --version 2>&1 | sed 's/^PLINK v//; s/ 64.*$//' )
END_VERSIONS
