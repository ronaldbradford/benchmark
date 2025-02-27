#!/usr/bin/env bash
set -o errexit
set -o nounset
set -o pipefail

sysbench --config-file=sysbench.cnf --mysql-ssl=off --report-interval=1 --histogram=1 --threads=4 core.lua --type=title run
sysbench --config-file=sysbench.cnf --mysql-ssl=off --report-interval=1 --histogram=1 --threads=4 core.lua --type=name run
