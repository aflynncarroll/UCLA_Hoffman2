#!/bin/bash -euo pipefail
plink2 \
    --threads 2 \
    --memory 8192 \
    --new-id-max-allele-len 100 missing --allow-extra-chr \
    --set-all-var-ids '@:#:$r:$a' \
    --var-id-multi @:# \
    --pfile chr10  \
    --make-just-pvar zs \
    --out SPARK_10

cp -RP chr10.pgen SPARK_10.pgen
cp -RP chr10.psam SPARK_10.psam

cat <<-END_VERSIONS > versions.yml
PLINK2_RELABELPVAR:
    plink2: $(plink2 --version 2>&1 | sed 's/^PLINK v//; s/ 64.*$//' )
END_VERSIONS
