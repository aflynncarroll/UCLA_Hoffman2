#!/bin/bash -euo pipefail
sed -i '1s/^/url = /' PGS000327.txt
curl --connect-timeout 5 \
    --speed-time 10 \
    --speed-limit 1000 \
     -O -K PGS000327.txt
gunzip -c *.gz > scorefile

cat <<-END_VERSIONS > versions.yml
PGSCATALOG_GET:
    sed: $(sed --version 2>&1 | head -n 1 | cut -f 4 -d ' ')
    gzip: $(gzip --version 2>&1 | head -n 1 | cut -f 2 -d ' ')
    curl: $(curl --version 2>&1 | head -n 1 | sed 's/curl //; s/ (x86.*$//')
END_VERSIONS
