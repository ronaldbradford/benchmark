#!/usr/bin/env bash
#set -o errexit
set -o nounset
set -o pipefail

[[ -n "${TRACE:-}" ]] && set -x

WARMUP_THREADS="${WARMUP_THREADS:-2}"
WARMUP_TIME="${WARMUP_TIME:-600}"

THREADS="${THREADS:-4 8 16 32 64}"
TIME="${TIME:-600}"
WARMDOWN_TIME="${WARMDOWN_TIME:-120}"

LOG_DIR="${LOG_DIR:-log}"
TEST_NAME="${TEST_NAME:-name}"
CONFIG_FILE="${CONFIG_FILE:-sysbench.cnf}"
TLS="${TLS:-off}"

info() {
  NOW=$(date +%Y%m%d.%H%M%S%z)
  echo "[${NOW}] INFO:  $*"
}

initialize() {
  mkdir -p ${LOG_DIR} || exit 1
  START_TIME="$(date +%Y%m%d.%H%M%S)"
}


run-test() {
  local TEST_TIME="$1"
  local TEST_THREADS="$2"
  local LOG_SUFFIX="${3:-}"

  local LOG_FILE="${LOG_DIR}/${START_TIME}.${TEST_NAME}${LOG_SUFFIX}.$(printf "%04d" "$TEST_THREADS").txt"
  info "Executing '${TEST_NAME}' ($LOG_SUFFIX)  with '${TEST_THREADS}' threads for '${TEST_TIME}' secs. Details in '${LOG_FILE}'"
  info "---  tail -f ${LOG_FILE}"
  sysbench --config-file="${CONFIG_FILE}" \
           --mysql-ssl=off --report-interval=1 --histogram=1 \
           --threads="${TEST_THREADS}" --time=${TEST_TIME} --type="${TEST_NAME}" \
           core.lua run > ${LOG_FILE} 2>&1
}


warmdown() {
  info "Warmdown for '${WARMDOWN_TIME}' secs"
  sleep "${WARMDOWN_TIME}"
}

warmup() {
  run-test "${WARMUP_TIME}" "${WARMUP_THREADS}" "-warmup"
  warmdown
}



### Benchmark
benchmark() {
  info "Starting benchmark, running with '${THREADS}' threads"
  for THREAD in $THREADS; do
    run-test ${TIME} ${THREAD}
    [[ $THREAD != ${THREADS##* } ]] && warmdown
  done
}


summary() {
  pwd
  ls -l ${LOG_DIR}
  ls -l ${LOG_DIR}/${START_TIME}.${TEST_NAME}.*
  grep -A 5 "Latency (ms)" ${LOG_DIR}/${START_TIME}.${TEST_NAME}.*
}

main() {
  initialize
  warmup
  benchmark
  summary
}


main "$*"
exit 0
