#!/usr/bin/env bash
set -o errexit
set -o nounset
set -o pipefail

SQL_FILE="test-setup.sql"

[[ ! -s "${SQL_FILE}" ]] && echo "ERROR: '${SQL_FILE}' not found" && exit 1

. .envrc
./test-connection.sh
mysql -u"${DB_USER}" -p"${DB_PASSWD}" -h"${DB_ENDPOINT}" -P"${DB_PORT}" < test-setup.sql
