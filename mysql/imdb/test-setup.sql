DROP SCHEMA IF EXISTS imdb;
CREATE SCHEMA imdb;
USE imdb;
CREATE TABLE name (
  name_id        INT UNSIGNED NOT NULL AUTO_INCREMENT,
  nconst         CHAR(10) NOT NULL,
  name           VARCHAR(120) NOT NULL,
  born           SMALLINT UNSIGNED NULL DEFAULT NULL,
  died           SMALLINT UNSIGNED NULL DEFAULT NULL,
  professions    VARCHAR(80), # 66 3/24
  known_for      VARCHAR(80), # 71 3/24, has null 12/22
  PRIMARY KEY (name_id),
  UNIQUE KEY (nconst),
  KEY (name)
);

CREATE TABLE title (
  title_id       INT UNSIGNED NOT NULL AUTO_INCREMENT,
  tconst         CHAR(10) NOT NULL,
  type           VARCHAR(12) NOT NULL,
  title          VARCHAR(600) NOT NULL,
  original_title VARCHAR(600) NOT NULL,
  is_adult       BOOLEAN NOT NULL,
  start_year     SMALLINT UNSIGNED NULL DEFAULT NULL,
  end_year       SMALLINT UNSIGNED NULL DEFAULT NULL,
  run_time_mins  SMALLINT UNSIGNED DEFAULT NULL,
  genres         VARCHAR(32),
  PRIMARY KEY (title_id),
  UNIQUE KEY (tconst),
  KEY (title)
);

CREATE TABLE title_episode(
  tconst         CHAR(10) NOT NULL,
  parent_tconst  CHAR(10) NOT NULL,
  season         SMALLINT UNSIGNED NULL DEFAULT NULL,
  episode        MEDIUMINT UNSIGNED NULL DEFAULT NULL, # now 72615, 91334 3/24
  PRIMARY KEY (tconst, parent_tconst),
  INDEX (parent_tconst)
);

#select max(length(directors)), max(length(writers)) from title_crew;
#+------------------------+----------------------+
#| max(length(directors)) | max(length(writers)) |
#+------------------------+----------------------+
#|                   4987 |                13414 |
#+------------------------+----------------------+
CREATE TABLE title_crew(
  crew_id        INT UNSIGNED NOT NULL AUTO_INCREMENT,
  tconst         CHAR(10) NOT NULL,
  directors      TEXT NULL,
  writers        TEXT NULL,
  PRIMARY KEY (crew_id),
  INDEX (tconst)
);

CREATE TABLE title_rating(
  tconst         CHAR(10) NOT NULL,
  average_rating DECIMAL(3,1) NOT NULL,
  num_votes      INT UNSIGNED NOT NULL,
  PRIMARY KEY (tconst)
);

CREATE TABLE title_principal(
  tconst         CHAR(10) NOT NULL,
  ordering       TINYINT UNSIGNED NOT NULL,
  nconst         CHAR(10) NOT NULL,
  category       VARCHAR(20) NOT NULL,
  job            VARCHAR(500) NULL,
  characters     TEXT NULL,
  PRIMARY KEY (tconst, ordering),
  INDEX (nconst)
);

CREATE TABLE title_character (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  title_id INT UNSIGNED NOT NULL,
  name_id INT UNSIGNED NOT NULL,
  character_id INT UNSIGNED NOT NULL,
  PRIMARY KEY (id),
  INDEX (title_id,name_id,character_id),
  INDEX (name_id,character_id),
  INDEX (character_id)
);

CREATE TABLE character_name (
  character_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(1000) DEFAULT NULL,
  PRIMARY KEY (character_id),
  INDEX (name(50))
);

CREATE TABLE title_genre (
  title_id INT UNSIGNED NOT NULL,
  genre VARCHAR(30) NOT NULL,
  INDEX (title_id)
);

CREATE TABLE name_profession (
  name_id INT UNSIGNED NOT NULL,
  profession VARCHAR(30) NOT NULL,
  INDEX (name_id)
);

CREATE TABLE title_director (
  title_id INT UNSIGNED NOT NULL,
  nconst CHAR(10) NOT NULL,
  INDEX (title_id),
  KEY (nconst)
);
SHOW TABLES;

