#!/bin/bash -euo pipefail
aggregate_scores -s SPARK_11_additive_0.sscore.zst SPARK_15_additive_0.sscore.zst SPARK_7_additive_0.sscore.zst SPARK_6_additive_0.sscore.zst SPARK_8_additive_0.sscore.zst SPARK_3_additive_0.sscore.zst SPARK_13_additive_0.sscore.zst SPARK_9_additive_0.sscore.zst SPARK_10_additive_0.sscore.zst SPARK_20_additive_0.sscore.zst SPARK_16_additive_0.sscore.zst SPARK_2_additive_0.sscore.zst SPARK_18_additive_0.sscore.zst SPARK_19_additive_0.sscore.zst -o . -v

cat <<-END_VERSIONS > versions.yml
SCORE_AGGREGATE:
    pgscatalog_utils: $(echo $(python -c 'import pgscatalog_utils; print(pgscatalog_utils.__version__)'))
END_VERSIONS
