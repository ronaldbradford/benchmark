#!/usr/bin/env bash

RESULTS_FILE=${RESULTS_FILE:-results.csv}
(
# We need to control the order of instance sizes.
  ORDERED_DIRS="rds-mysql-r6g.2xlarge rds-mysql-r6g.4xlarge rds-mysql-r6g.8xlarge"
  echo "Threads,Test,Transactions"
  for dir in ${ORDERED_DIRS}; do     
    awk -F, -v dir="$dir" '{printf("%s,%s,%s\n", $1, dir, $4)}' $dir/*.csv | grep -v "^Threads" | sort -n;
  done 
) | tee "${RESULTS_FILE}"
