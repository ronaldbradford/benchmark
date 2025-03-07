# IMDb Sysbench Test

This directory contains a MySQL benchmark test setup to be used with Sysbench that runs tests against
an [enhanced IMDb dataset](https://github.com/ronaldbradford/data/tree/main/mysql-data/imdb) (~ 20GB).
This data is based on the source [IMDb Non-Commercial Datasets](https://developer.imdb.com/non-commercial-datasets/).

## Prerequisites

* Install [sysbench](https://github.com/akopytov/sysbench) locally
* Install [MySQL](https://www.mysql.com) locally or have an accessible MySQL installation
* Install [MySQL client](https://dev.mysql.com/doc/refman/8.0/en/mysql.html) if using the test validation steps

## Test Validation

The file `.envrc` contains the configuration for MySQL database connection.
The included example file uses a local [DBDeployer](https://github.com/datacharmer/dbdeployer) installation.

```
./test-connection.sh
```

With a valid connection, you can install a test installation of needed database objects to validate the test with no data.

```
./test-install.sh
```

To test the example sysbench tests run.

```
./test-sysbench.sh
```

These will validate two use cases, the `title` test and the `name` test.

The valid output would look like.

```
sysbench 1.0.20 (using system LuaJIT 2.1.1727870382)

Running the test with following options:
Number of threads: 4
Report intermediate results every 1 second(s)
Initializing random number generator from current time


Initializing worker threads...

Preparing queries
Preparing queries
Preparing queries
Preparing queries
Threads started!

[ 1s ] thds: 4 tps: 13145.28 qps: 65727.39 (r/w/o: 65727.39/0.00/0.00) lat (ms,95%): 0.00 err/s: 0.00 reconn/s: 0.00
[ 2s ] thds: 4 tps: 14619.84 qps: 73106.18 (r/w/o: 73106.18/0.00/0.00) lat (ms,95%): 0.00 err/s: 0.00 reconn/s: 0.00
[ 3s ] thds: 4 tps: 14697.19 qps: 73485.94 (r/w/o: 73485.94/0.00/0.00) lat (ms,95%): 0.00 err/s: 0.00 reconn/s: 0.00
[ 4s ] thds: 4 tps: 14459.11 qps: 72292.57 (r/w/o: 72292.57/0.00/0.00) lat (ms,95%): 0.00 err/s: 0.00 reconn/s: 0.00
Latency histogram (values are in milliseconds)

SQL statistics:
    queries performed:
        read:                            357030
        write:                           0
        other:                           0
        total:                           357030
    transactions:                        71406  (14276.55 per sec.)
    queries:                             357030 (71382.73 per sec.)
    ignored errors:                      0      (0.00 per sec.)
    reconnects:                          0      (0.00 per sec.)

General statistics:
    total time:                          5.0014s
    total number of events:              71406

Latency (ms):
         min:                                    0.22
         avg:                                    0.28
         max:                                    0.82
         95th percentile:                        0.00
         sum:                                19979.39

Threads fairness:
    events (avg/stddev):           17851.5000/4.15
    execution time (avg/stddev):   4.9948/0.00

sysbench 1.0.20 (using system LuaJIT 2.1.1727870382)

Running the test with following options:
Number of threads: 4
Report intermediate results every 1 second(s)
Initializing random number generator from current time


Initializing worker threads...

Preparing queries
Preparing queries
Preparing queries
Preparing queries
Threads started!

[ 1s ] thds: 4 tps: 8178.70 qps: 65446.56 (r/w/o: 65446.56/0.00/0.00) lat (ms,95%): 0.00 err/s: 0.00 reconn/s: 0.00
[ 2s ] thds: 4 tps: 9141.04 qps: 73123.36 (r/w/o: 73123.36/0.00/0.00) lat (ms,95%): 0.00 err/s: 0.00 reconn/s: 0.00
[ 3s ] thds: 4 tps: 8995.29 qps: 71970.31 (r/w/o: 71970.31/0.00/0.00) lat (ms,95%): 0.00 err/s: 0.00 reconn/s: 0.00
[ 4s ] thds: 4 tps: 8680.15 qps: 69433.26 (r/w/o: 69433.26/0.00/0.00) lat (ms,95%): 0.00 err/s: 0.00 reconn/s: 0.00
Latency histogram (values are in milliseconds)

SQL statistics:
    queries performed:
        read:                            353352
        write:                           0
        other:                           0
        total:                           353352
    transactions:                        44169  (8830.59 per sec.)
    queries:                             353352 (70644.73 per sec.)
    ignored errors:                      0      (0.00 per sec.)
    reconnects:                          0      (0.00 per sec.)

General statistics:
    total time:                          5.0016s
    total number of events:              44169

Latency (ms):
         min:                                    0.36
         avg:                                    0.45
         max:                                   10.95
         95th percentile:                        0.00
         sum:                                19986.36

Threads fairness:
    events (avg/stddev):           11042.2500/14.46
    execution time (avg/stddev):   4.9966/0.00
```
