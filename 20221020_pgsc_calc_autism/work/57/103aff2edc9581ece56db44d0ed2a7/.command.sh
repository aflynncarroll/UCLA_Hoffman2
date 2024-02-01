#!/bin/bash -euo pipefail
pgs_api=$(printf 'https://www.pgscatalog.org/rest/score/%s' PGS000327)
curl -s $pgs_api -o PGS000327.json

# check for a valid response. empty response: {} = 2 chars
if [ $(wc -m < PGS000327.json) -eq 2 ]
then
    echo "PGS Catalog API error. Is --accession valid?"
    exit 1
fi

cat <<-END_VERSIONS > versions.yml
PGSCATALOG_API:
    curl: $(curl --version 2>&1 | head -n 1 | sed 's/curl //; s/ (x86.*$//')
END_VERSIONS
