#!/usr/bin/env bash

# We need to control the order of instance sizes.
TEST_CATEGORY=$(basename $(pwd))
(
ORDERED_DIRS="readyset-r6i.large readyset-r6i.xlarge readyset-r6i.2xlarge readyset-r6i.4xlarge"
echo "Threads,Test,Transactions"; for dir in ${ORDERED_DIRS}; do     awk -F, -v dir="$dir" '{printf("%s,%s,%s\n", $1, dir, $4)}' $dir/*.csv | grep -v "^Threads" | sort -n; done) | tee ${TEST_CATEGORY}-results.csv
