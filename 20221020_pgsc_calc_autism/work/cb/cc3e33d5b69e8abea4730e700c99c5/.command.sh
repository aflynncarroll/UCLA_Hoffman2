#!/bin/bash -euo pipefail
samplesheet_to_json.py chr1_test_2.csv out.json

cat <<-END_VERSIONS > versions.yml
SAMPLESHEET_JSON:
    python: $(echo $(python --version 2>&1) | cut -f 2 -d ' ')
END_VERSIONS
