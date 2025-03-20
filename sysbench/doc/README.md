# Understanding `sysbench`

[Sysbench](https://github.com/akopytov/sysbench/) is a popular open-source benchmarking tool designed to evaluate the performance of system components such as CPU, memory, disk I/O, and databases. It is commonly used for testing MySQL, PostgreSQL, and other databases under different load conditions.

## Database Benchmarking

`sysbench` supports benchmarking of the [MySQL](https://www.mysql.com), [MariaDB](https://mariadb.org/) and [PostgreSQL](https://postgres.org) open source relational databases. PRs to support other RDBMS products, for example [SQLServer #PR549](https://github.com/akopytov/sysbench/pull/549) also exist.

This documentation focusses on a detailed analysis of the `sysbench` database ecosystem, what`sysbench` tests actually do, and what types of tests are available.

- [`sysbench` Arguments](ARGS.md)
- [`sysbench` Tests](TESTS.md) aggregated list

A deeper dive into the [Small Datum](https://smalldatum.blogspot.com/) available [tests](SMALLDATUM.md).

## What is Important with Benchmarking?

The answer will depend on who is asked and what product(s) are being evaluated. Generally the most important measurements for comparison include:

1. Throughput
2. latency
3. Runtime Resource Utilization (e.g. CPU, RAM, I/O, Network)
4. Storage

## The Original 1 Billion Rows

While it's common now to hear about various 1 Billion row benchmarks, we need to recognize one the orginal architects behind this number. Tim Callaghan (yes related to Mark) created the orginal `iibench` (Index Insertion Benchmark) 1 Billion row challenge more than a decade ago.  [1 Billion Insertions – The Wait is Over!](https://www.percona.com/blog/1-billion-insertions-the-wait-is-over/)  published - January 26, 2012.

Some other examples:

- [iibench implemented as a sysbench workload](https://mysqlperf.github.io/mysql/sysbench-iibench/) [source](https://github.com/Dmitree-Max/sysbench-iibench)
- [The One Billion Row Challenge](https://www.morling.dev/blog/one-billion-row-challenge/) - [1brc](https://github.com/gunnarmorling/1brc)
- [ClickHouse and The One Billion Row Challenge](https://clickhouse.com/blog/clickhouse-one-billion-row-challenge)

## Benchmarking Ecosystem

There are numerous products that perform benchmarks for given workloads, datasets and products. This is a short list of common benchmarks.

- [HammerDB](https://www.hammerdb.com/) is a product that supports a wider range of RDBMS products.
- [Yahoo! Cloud Serving Benchmark (YCSB)](https://ycsb.site)
- [ClickBench](https://benchmark.clickhouse.com/) -  a Benchmark For Analytical DBMS
- [JSONBench](https://jsonbench.com/) - a Benchmark For Data Analytics On JSON
- [NoSQLBench](https://github.com/nosqlbench/nosqlbench) - NoSQL Benchmarking Suite
- [BMK-kit](http://dimitrik.free.fr/blog/posts/mysql-perf-bmk-kit.html) - MySQL Performance : Benchmark kit (BMK-kit)
- [dim_STAT](http://dimitrik.free.fr/) - high-level and detailed, monitoring and performance analysis of Solaris, Linux, and other UNIX systems
- [TPC](https://www.tpc.org/) - Transaction Processing Performance Council benchmarks
