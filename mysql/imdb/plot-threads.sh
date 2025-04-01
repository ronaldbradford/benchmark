#!/usr/bin/env bash

PYTHON=${PYTHON:-python}

[[ $# -eq 0 ]] && exit 1
# log/20250309.134152.name.0032.txt > 0032.txt
INPUT_FILE_PATTERN="$1"

rm -f ${INPUT_FILE_PATTERN}*.tsv


(
echo "Threads,Avg,95th,Transactions"
for INPUT_FILE in $(ls ${INPUT_FILE_PATTERN}*.txt); do
  N=$(cut -f4 -d'.' <<< ${INPUT_FILE} | sed 's/^0*//')
  AVG_VALUE=$(grep "avg:" ${INPUT_FILE} | awk '{print $2}')
  MAX_VALUE=$(grep "95th percentile:" ${INPUT_FILE} | awk '{print $3}')
  TRANSACTIONS=$(grep "transactions:" ${INPUT_FILE} | tr -d '()' |  awk '{print $3}')
  echo "${N},${AVG_VALUE},${MAX_VALUE},${TRANSACTIONS}"
done
) > ${INPUT_FILE_PATTERN}threads.csv

${PYTHON} plot-threads.py ${INPUT_FILE_PATTERN}threads.csv
PNG_FILE="${INPUT_FILE_PATTERN}threads.png"
echo "Creating '${PNG_FILE}'"
mv threads_chart.png "${PNG_FILE}"
