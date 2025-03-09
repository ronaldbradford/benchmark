#!/usr/bin/env bash


[[ $# -eq 0 ]] && exit 1
# log/20250309.134152.name.0032.txt > 0032.txt
INPUT_FILE_PATTERN="$1"

rm -f ${INPUT_FILE_PATTERN}*.tsv
for INPUT_FILE in $(ls ${INPUT_FILE_PATTERN}*.txt); do
  OUTPUT_FILE=$(sed -e "s/txt/tsv/" <<< ${INPUT_FILE})
  [[ ! -s "${INPUT_FILE}" ]] && echo "ERROR: '${INPUT_FILE}' not found" && exit 1
  MAX_VALUE=$(grep "95th percentile" ${INPUT_FILE} | awk '{print $3}')
  awk -v max="$MAX_VALUE" '
/Latency histogram/ { found=1; next }
/SQL statistics/ { found=0 }
found && NF >= 3 {
    if ($1+0 > max+0) exit;  # Ensures numerical comparison for floats
    print $1 "\t" $3
}
' ${INPUT_FILE} > ${OUTPUT_FILE}
  echo "${OUTPUT_FILE}"
done

python plot-latency.py ${INPUT_FILE_PATTERN}*.tsv


for INPUT_FILE in $(ls ${INPUT_FILE_PATTERN}*.txt); do
  grep "queries:" ${INPUT_FILE} | cut -d'(' -f2 | cut -d' ' -f1
done
