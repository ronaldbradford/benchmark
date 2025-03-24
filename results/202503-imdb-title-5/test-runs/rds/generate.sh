#!/usr/bin/env bash

# We need to control the order of instance sizes.
(echo "Threads,Test,Transactions"; for dir in readyset-r6i.large readyset-r6i.xlarge readyset-r6i.2xlarge; do     awk -F, -v dir="$dir" '{printf("%s,%s,%s\n", $1, dir, $4)}' $dir/*.csv | grep -v "^Threads" | sort -n; done) | tee rds-results.csv
