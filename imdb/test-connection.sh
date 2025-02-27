#!/usr/bin/env bash
set -o errexit
set -o nounset
set -o pipefail

. .envrc
mysql -u"${DB_USER}" -p"${DB_PASSWD}" -h"${DB_ENDPOINT}" -P"${DB_PORT}" "${DB_NAME}" -e "SELECT VERSION()";
