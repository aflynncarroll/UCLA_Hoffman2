#!/bin/bash -euo pipefail
jq '[.ftp_scoring_file] | @tsv' PGS000327.json > PGS000327.txt

cat <<-END_VERSIONS > versions.yml
PGSCATALOG_PARSE:
    jq: $(jq --version 2>&1 | sed 's/jq-//')
END_VERSIONS
