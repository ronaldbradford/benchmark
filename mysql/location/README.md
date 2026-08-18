# Custom DataSource Benchmark

## Required Files

- .envrc          - MySQL Connection Environment Variables
- sysbench.cnf    - MySQL Connection sysbench config
- core.lua        - Core Benchmarking Framework
- oltp_common.lua - sysbench common functions
- benchmark.sh    - Core Benchmark Script

## Test Files

- test.txt - A text file with a single value per line
- test.sql - A SQL file with SQL statement that accept one parameter, the value of test.txt
- test-connection.sh - Will test and verify the database connection with configuration
- test-sysbench - Verify the setup with test.* data.

#

