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
# log/20250309.134152.name.0032.txt > 0032.tsv

LOG_FILE_PATH="$1"
INPUT_FILE_PATTERN="$2"
[[ "${INPUT_FILE_PATTERN}" != *. ]] && INPUT_FILE_PATTERN="${INPUT_FILE_PATTERN}."

rm -f ${LOG_FILE_PATH}/${INPUT_FILE_PATTERN}*.tsv

# Log files may be plain text or gzip-compressed (*.txt.gz); zcat/zgrep read both transparently.
shopt -s nullglob
INPUT_FILES=(${LOG_FILE_PATH}/${INPUT_FILE_PATTERN}*.txt ${LOG_FILE_PATH}/${INPUT_FILE_PATTERN}*.txt.gz)
shopt -u nullglob

[[ ${#INPUT_FILES[@]} -eq 0 ]] && error "no files matching '${LOG_FILE_PATH}/${INPUT_FILE_PATTERN}*.txt(.gz)' found"

for INPUT_FILE in "${INPUT_FILES[@]}"; do
  OUTPUT_FILE="${INPUT_FILE%.gz}"
  OUTPUT_FILE="${OUTPUT_FILE%.txt}.tsv"
  MAX_VALUE=$(zgrep "95th percentile:" "${INPUT_FILE}" | awk '{print $3}')
  zcat -f "${INPUT_FILE}" | awk -v max="$MAX_VALUE" '
/Latency histogram/ { found=1; next }
/SQL statistics/ { found=0 }
found && NF >= 3 {
    if ($1+0 > max+0) exit;  # Ensures numerical comparison for floats
    print $1 "\t" $3
}
' > "${OUTPUT_FILE}"
  echo "${OUTPUT_FILE}"
done

${PYTHON} "${SCRIPT_DIR}/plot-latency.py" "${LOG_FILE_PATH}" "${INPUT_FILE_PATTERN}"
