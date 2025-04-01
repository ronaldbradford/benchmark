#!/usr/bin/env bash
set -o errexit
set -o nounset
set -o pipefail

CONFIG_FILE="${CONFIG_FILE:-sysbench.cnf}"
TLS="${TLS:-off}"

sysbench --config-file=${CONFIG_FILE} --mysql-ssl=${TLS} --report-interval=1 --histogram=1 --threads=4 core.lua --type=title run
sysbench --config-file=${CONFIG_FILE} --mysql-ssl=${TLS} --report-interval=1 --histogram=1 --threads=4 core.lua --type=name run
