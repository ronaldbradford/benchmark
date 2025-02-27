#!/usr/bin/env bash

./test-connection.sh
. .envrc
mysql -u${DB_USER} -p${DB_PASSWD} -h${DB_ENDPOINT} -P${DB_PORT} < test-setup.sql
