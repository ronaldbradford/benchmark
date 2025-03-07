# Better Benchmark Examples

The following benchmarks offer more flexible examples with human-realistic SQL workloads using public available datasets.

## External Datasets
- [IMDb](https://github.com/ronaldbradford/data/tree/main/mysql-data/imdb)
- [NYC Taxi](https://github.com/ronaldbradford/data/tree/main/mysql-data/nyc-taxi)

## Supported Databases

- MySQL
- PostgreSQL

## Approach

Using [sysbench](https://github.com/akopytov/sysbench), you can create a configurable series of SQL statements that accept a single parameter.
Combined with each series of SQL statements you also provide a file of values you wish to use in the benchmark.
The benchmark will construct for each thread, a random stream of combined SQL+data statements for execution endevouring to provide a more .

This repository requires NO data in order to validate the tests. The necessary table structures are included to validate tests can operate before you load any data.

The larger strategy is to trigger a smaller combination of different workloads with the goal to represent a benchmark which is more than a purely synthetic one table, one value, DML statement.

### Example Use Case

To build a use case you need 3 things.
1. A dataset.
2. Example SQL statements using one key attribute of the dataset.
3. Example values for those SQL statements.

#### SQL

Create an SQL file with a number of statements that accepts a single parameter, and the SQL queries can use that parameter to retreive different result sets. In this example, the single parameter is the "Title of a Movie", and the SQL queries perform

- Retrieve details of the movie (`title` table)
- Retrieve the average ratings of the movie (`title` and `title_rating` tables)
- Retrieve the genres of the movie (`title` and `title_genre` tables)
- Retrieve the name of participant in the movie and the character they played in that movie (`name`, `title_name_character` and `title` tables)

```
SELECT * FROM title t WHERE t.title = ? AND t.type = 'movie';
SELECT t.title, r.average_rating, r.num_votes FROM title t JOIN title_rating r USING (title_id) WHERE t.title = ? AND t.type = 'movie';
SELECT g.genre FROM title_genre g JOIN title t USING (title_id) WHERE t.title = ? AND t.type = 'movie';
SELECT n.name AS name, tnc.character_name FROM name n JOIN title_name_character tnc USING (name_id) JOIN title t USING (title_id) WHERE t.title = ? AND t.type = 'movie';
```

#### Data

Create a datafile of arbitary length that contains values you would pass to the SQL statements.

```
Toy Story 4
Con Air
Jurassic World: Fallen Kingdom
The Dark Knight
Interstellar
```

#### Benchmark Statements

The `sysbench` Lua script will construct a combination of actual SQL statements to execute across the threads for the duration of the test. Example SQL statements and the results would include:

```
mysql> SELECT * FROM title t WHERE t.title = 'Toy Story 4' AND t.type = 'movie';
+----------+-----------+-------+-------------+----------------+----------+------------+----------+---------------+---------------------+
| title_id | tconst    | type  | title       | original_title | is_adult | start_year | end_year | run_time_mins | updated             |
+----------+-----------+-------+-------------+----------------+----------+------------+----------+---------------+---------------------+
|  5082567 | tt1979376 | movie | Toy Story 4 | Toy Story 4    |        0 |       2019 |     NULL |           100 | 2025-02-28 21:15:38 |
+----------+-----------+-------+-------------+----------------+----------+------------+----------+---------------+---------------------+
1 row in set (0.01 sec)
```

```
mysql> SELECT g.genre FROM title_genre g JOIN title t USING (title_id) WHERE t.title = 'Interstellar' AND t.type = 'movie';
+-----------+
| genre     |
+-----------+
| Adventure |
| Drama     |
| Sci-Fi    |
+-----------+
3 rows in set (0.00 sec)
```

```
mysql> SELECT n.name AS name, tnc.character_name FROM name n JOIN title_name_character tnc USING (name_id) JOIN title t USING (title_id) WHERE t.title = 'Toy Story 4' AND t.type = 'movie';
+---------------------+------------------+
| name                | character_name   |
+---------------------+------------------+
| Tom Hanks           | Woody            |
| Keanu Reeves        | Duke Caboom      |
| Tim Allen           | Buzz Lightyear   |
| Annie Potts         | Bo Peep          |
| Tony Hale           | Forky            |
| Christina Hendricks | Gabby Gabby      |
| Keegan-Michael Key  | Ducky            |
| Ally Maki           | Giggle McDimples |
| Jordan Peele        | Bunny            |
| Madeleine McGraw    | Bonnie           |
+---------------------+------------------+
10 rows in set (0.00 sec)
```

## IMDb

Using the IMDb dataset there are several examples provided, to demonstrate a typical CRUD application with SQL to view information.

### Read-only Workload

* **name** - Select information given an individual name, retrieving details of the individual, movie titles they have appeared in, and the roles and characters for the titles.
* **title** - Select information for a given title, participants of the title,

See the [IMDb README](mysql/imdb/README.md) for information on how to setup and test.

### Read-write Workload

* **updates** - A small sample of updates that triggers a manipulation of the dataset.

## NYC Taxi

Using the NYC Taxi dataset the goal is to provide a ready stream of writes, and support up-to-date analytics dashboards of present data.

### Write-heavy Workload

Combined with the included dataset is a slow load process that is constantly inserting new data.

### Analytical Queries
* **weekly** - A dashboard of weekly information and weekly comparisons.

## Using `sysbench` with AWS RDS and GCP CloudSQL

The currently available binary version for distributions `sysbench 1.0.20` does not support using a cloud-managed RDBMS. There is a `bin/build-from-source.sh` script that will produce the current version `sysbench 1.1.0-de18a03` which can be used with RDS and CloudSQL.
