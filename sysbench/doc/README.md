# Understanding `sysbench`

[Sysbench](https://github.com/akopytov/sysbench/) is a popular open-source benchmarking tool designed to evaluate the performance of system components such as CPU, memory, disk I/O, and databases. It is commonly used for testing MySQL, PostgreSQL, and other databases under different load conditions.

Created by Alexey Kopytov, `sysbench` has been around for approximately two decades. While `git` shows the first commit as `Jan 2006` this product was previously hosted on [Launchpad](https://launchpad.net/sysbench). The [ChangeLog](https://github.com/akopytov/sysbench/blob/master/ChangeLog) has a first reference of 2004-02-19. The current version is `1.0.20` however there has not been a version release in the past 5 years.

## Database Benchmarking

`sysbench` supports benchmarking of open source databases including [MySQL](https://www.mysql.com), [MariaDB](https://mariadb.org/), [PostgreSQL](https://postgres.org), [RocksDB](https://rocksdb.org/). PRs to support other RDBMS products, for example [SQLServer #PR549](https://github.com/akopytov/sysbench/pull/549) also exist.

This documentation focusses on a detailed analysis of the `sysbench` RDBMS database ecosystem, what`sysbench` tests actually do, and what types of tests are open-source available.

- [`sysbench` Arguments](ARGS.md)
- [`sysbench` Tests](TESTS.md) aggregated list

A deeper dive into the [Small Datum](https://smalldatum.blogspot.com/) available [sysbench tests](SMALLDATUM.md).

## What is Important with Benchmarking?

The answer will depend on who is asked and what product(s) are being evaluated. Generally the most important measurements for comparison include:

1. Query Throughput
2. Query Latency
3. Runtime Resource Utilization (e.g. CPU, RAM, I/O, Network)
4. Data Storage
5. Total Execution Time

## History of the Original 1 Billion Rows

While it's common now to hear about various 1 Billion row benchmarks, we need to recognize one the original architects behind this number. Tim Callaghan (yes related to Mark) created the original `iibench` (Index Insertion Benchmark) 1 Billion row challenge more than a decade ago. A good summary can be found in [1 Billion Insertions – The Wait is Over!](https://www.percona.com/blog/1-billion-insertions-the-wait-is-over/)  published - January 26, 2012.

Some other 1 Billion Row (1br) examples:

- [iibench implemented as a sysbench workload](https://mysqlperf.github.io/mysql/sysbench-iibench/) [source](https://github.com/Dmitree-Max/sysbench-iibench)
- [The One Billion Row Challenge](https://www.morling.dev/blog/one-billion-row-challenge/) - [1brc](https://github.com/gunnarmorling/1brc)
- [ClickHouse and The One Billion Row Challenge](https://clickhouse.com/blog/clickhouse-one-billion-row-challenge)

## Benchmarking Ecosystem

There are numerous products that perform benchmarks for given workloads, datasets and products. This is a short list of common benchmarks.

- [HammerDB](https://www.hammerdb.com/) is a product that supports a wider range of RDBMS products.
- [Yahoo! Cloud Serving Benchmark (YCSB)](https://ycsb.site) - a NoSQL database benchmark.
- [ClickBench](https://benchmark.clickhouse.com/) -  a Benchmark For Analytical DBMS.
- [JSONBench](https://jsonbench.com/) - a Benchmark For Data Analytics On JSON.
- [NoSQLBench](https://github.com/nosqlbench/nosqlbench) - NoSQL Benchmarking Suite.
- [BMK-kit](http://dimitrik.free.fr/blog/posts/mysql-perf-bmk-kit.html) - MySQL Performance : Benchmark kit.
- [ DBT2](https://dev.mysql.com/downloads/benchmarks.html) - MySQL DBT2 Benchmark
- [dim_STAT](http://dimitrik.free.fr/) - high-level and detailed, monitoring and performance analysis of Solaris, Linux, and other UNIX systems.
- [pgbench](https://www.postgresql.org/docs/current/pgbench.html) - PostgreSQL benchmark program
- [pgbench-tools](https://github.com/gregs1104/pgbench-tools) - PostgreSQL Benchmark Toolkit
- [yugabyte-sysbench](https://github.com/yugabyte/sysbench) - Yugabyte (PostgreSQL) sysbench
- [TPC](https://www.tpc.org/) - Transaction Processing Performance Council benchmarks.
- [ dbstress](https://github.com/semberal/dbstress) -
- [ db-stress-bench](https://github.com/freakynit/db-stress-bench) -
