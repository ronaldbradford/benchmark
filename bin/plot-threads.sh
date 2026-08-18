#!/usr/bin/env bash
set -euo pipefail

PYTHON=${PYTHON:-python}
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

error() {
  echo "ERROR: $*"
  exit 1
}

usage() {
  error "$0 <log-file-path> <log-file-pattern>"
}

[[ $# -ne 2 ]] && usage

LOG_FILE_PATH="$1"
INPUT_FILE_PATTERN="$2"
[[ "${INPUT_FILE_PATTERN}" != *. ]] && INPUT_FILE_PATTERN="${INPUT_FILE_PATTERN}."

rm -f ${LOG_FILE_PATH}/${INPUT_FILE_PATTERN}*.tsv

# Log files may be plain text or gzip-compressed (*.txt.gz); zgrep reads both transparently.
shopt -s nullglob
INPUT_FILES=(${LOG_FILE_PATH}/${INPUT_FILE_PATTERN}*.txt ${LOG_FILE_PATH}/${INPUT_FILE_PATTERN}*.txt.gz)
shopt -u nullglob

[[ ${#INPUT_FILES[@]} -eq 0 ]] && error "no files matching '${LOG_FILE_PATH}/${INPUT_FILE_PATTERN}*.txt(.gz)' found"

(
echo "Threads,Avg,95th,Transactions"
for INPUT_FILE in "${INPUT_FILES[@]}"; do
  N=$(basename "${INPUT_FILE}" | cut -f4 -d'.' | sed 's/^0*//')
  AVG_VALUE=$(zgrep "avg:" "${INPUT_FILE}" | awk '{print $2}')
  MAX_VALUE=$(zgrep "95th percentile:" "${INPUT_FILE}" | awk '{print $3}')
  TRANSACTIONS=$(zgrep "transactions:" "${INPUT_FILE}" | tr -d '()' |  awk '{print $3}')
  echo "${N},${AVG_VALUE},${MAX_VALUE},${TRANSACTIONS}"
done
) > ${LOG_FILE_PATH}/${INPUT_FILE_PATTERN}threads.csv

echo "Created ${LOG_FILE_PATH}/${INPUT_FILE_PATTERN}threads.csv"
${PYTHON} "${SCRIPT_DIR}/plot-threads.py" "${LOG_FILE_PATH}" "${INPUT_FILE_PATTERN}"
