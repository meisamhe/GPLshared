SQL
-----------------------------
SQL Statement Syntax
AND / OR SELECT column_name(s)
FROM table_name
WHERE condition
AND|OR condition
ALTER TABLE ALTER TABLE table_name
ADD column_name datatype
or
ALTER TABLE table_name
DROP COLUMN column_name
AS (alias) SELECT column_name AS column_alias
FROM table_name
or
SELECT column_name
FROM table_name AS table_alias
BETWEEN SELECT column_name(s)
FROM table_name
WHERE column_name
BETWEEN value1 AND value2
CREATE DATABASE CREATE DATABASE database_name
CREATE TABLE CREATE TABLE table_name
(
column_name1 data_type,
column_name2 data_type,
column_name3 data_type,
...
)
CREATE INDEX CREATE INDEX index_name
ON table_name (column_name)
or
CREATE UNIQUE INDEX index_name
ON table_name (column_name)
CREATE VIEW CREATE VIEW view_name AS
SELECT column_name(s)
FROM table_name
WHERE condition
DELETE DELETE FROM table_name
WHERE some_column=some_value
or
DELETE FROM table_name
(Note: Deletes the entire table!!)
DELETE * FROM table_name
(Note: Deletes the entire table!!)
DROP DATABASE DROP DATABASE database_name
DROP INDEX DROP INDEX table_name.index_name (SQL Server)
DROP INDEX index_name ON table_name (MS Access)
DROP INDEX index_name (DB2/Oracle)
ALTER TABLE table_name
DROP INDEX index_name (MySQL)
DROP TABLE DROP TABLE table_name
EXISTS IF EXISTS (SELECT * FROM table_name WHERE id = ?)
BEGIN
--do what needs to be done if exists
END
ELSE
BEGIN
--do what needs to be done if not
END
GROUP BY SELECT column_name, aggregate_function(column_name)
FROM table_name
WHERE column_name operator value
GROUP BY column_name
HAVING SELECT column_name, aggregate_function(column_name)
FROM table_name
WHERE column_name operator value
GROUP BY column_name
HAVING aggregate_function(column_name) operator value
IN SELECT column_name(s)
FROM table_name
WHERE column_name
IN (value1,value2,..)
INSERT INTO INSERT INTO table_name
VALUES (value1, value2, value3,....)
or
INSERT INTO table_name
(column1, column2, column3,...)
VALUES (value1, value2, value3,....)
INNER JOIN SELECT column_name(s)
FROM table_name1
INNER JOIN table_name2
ON table_name1.column_name=table_name2.column_name
LEFT JOIN SELECT column_name(s)
FROM table_name1
LEFT JOIN table_name2
ON table_name1.column_name=table_name2.column_name
RIGHT JOIN SELECT column_name(s)
FROM table_name1
RIGHT JOIN table_name2
ON table_name1.column_name=table_name2.column_name
FULL JOIN SELECT column_name(s)
FROM table_name1
FULL JOIN table_name2
ON table_name1.column_name=table_name2.column_name
LIKE SELECT column_name(s)
FROM table_name
WHERE column_name LIKE pattern
ORDER BY SELECT column_name(s)
FROM table_name
ORDER BY column_name [ASC|DESC]
SELECT SELECT column_name(s)
FROM table_name
SELECT * SELECT *
FROM table_name
SELECT DISTINCT SELECT DISTINCT column_name(s)
FROM table_name
SELECT INTO SELECT *
INTO new_table_name [IN externaldatabase]
FROM old_table_name
or
SELECT column_name(s)
INTO new_table_name [IN externaldatabase]
FROM old_table_name
SELECT TOP SELECT TOP number|percent column_name(s)
FROM table_name
TRUNCATE TABLE TRUNCATE TABLE table_name
UNION SELECT column_name(s) FROM table_name1
UNION
SELECT column_name(s) FROM table_name2
UNION ALL SELECT column_name(s) FROM table_name1
UNION ALL
SELECT column_name(s) FROM table_name2
UPDATE UPDATE table_name
SET column1=value, column2=value,...
WHERE some_column=some_value
WHERE SELECT column_name(s)
FROM table_name
WHERE column_name operator value


HiveQL
-------------
SELECT from_columns FROM table WHERE conditions;
SELECT MAX(col_name) AS label FROM table;
SELECT col1, col2 FROM table ORDER BY col2 DESC;
SELECT pet.name, comment FROM pet JOIN event ON (pet.name = event.name);

HiveQL metadata
---------
USE database;
Show databases;
show tables;
describe (formatted|extended) tables;
create database db_name;
drop database db_name (cascade);

HiveQL datatypes: int, tinyint/ smallint, bigint, boolean, float, double, string, timestamp, binary, array, map, struct, union, char, decimal, carchar, date

HiveQL semantics: Select, Load, insert from query, expression in where and having, group by, order by, sort by, sub-queries in from clause, group by, order by, cluster by, distribute by, rollup and cube, union, left, right, and full inner/outer join, cross join, left semi join, intersect, except union, distinct, subquereis in where (in, not in, exists, not exists), subquereies in having

	
Pig Code
--------------------
X = Foreach A Generate f1, f2, f1%f2
X = Foreach A Generate f2, (f2==1?1:Count(B));
X = Filter A By (f1==8) OR (NOT (f2+f3>f1));
B = Foreach A Generate(int)$0 + 1;
B = Foreach A Generate $0+1, $1+1.0
X = Filter A By (f1==8);
X = Filter A By (f2=='apache');
X = Filter A By (f1 matches '.*apache.*');
B = foreach A generate (name, age);
B = foreach A generate {(name, age)}, {name, age};
B = foreach A generate [name, gpa];
A = laod 'data1' as (x,y);
B = load 'data2' as (x,y,z);
C = join A by x, B by x;
D = foreach C generate A::y;
X = Fiulter A BY f1 is not null;
A = Load 'data' as (x,y,z);
B = Foreach A generate -x, y;
A = load 'student' As (name: chararray, age: int, gpa:float);
B = Group A By age;
X = Cross A, B
Dump X;
A = Load 'file'
B = Stream B through CMD;
X = Distinct A;
Dump X;
X = Filter A By f3 ==3;
Dump X;
X = Foreach A Geenerate a1, a2; 
Dump X;
/* myscript.pig */
Import 'my_macro.pig'
X Join A by a1, B BY b1;
A = Load 'myfile.txt';
Load 'myfile.txt' AS (f1: int, f2: int, f3:int);
A = Load 'WordcountInput.txt';
B = MAPREDUCE 'wordcount.jar' STORE A INTO 'inputDir' Load 'outputDir' AS (word:chararray, count: int) 'org.myorg.WordCount inputDir outputDir';
A = LOAD 'mydata' AS (x: int, y: map[]);
B = Order A By x;
A = Load 'data' As (f1:int, f2: int, f3: int);
X = Sample A 0.01;
Split input_var Into output_var If (field1 is not null), ignored_var If (field1 is null);
Store A into 'myoutput' using PigStorage('*');
Store A into 'mytoutput' Using PigStorage('*');
X = Union A, B;
Dump X;

Pig Functions are: Avg, Concat, Count, Count_Str, Diff, IsEmpty, Max, Min, Size, Sum, Tokenize (expression, [,'field delimeter'])

A = load 'myinput.gz';
store A into 'myoutput.gz';
A = Load 'data' using BinStorage();
A = load 'a.json' using JsonLoader();
Store X into 'output' Using PigDump();
A = Load 'student' Using PigStorage('\t') As (name: chararray, age: int, gpa:float)
A = Load 'data' Using TextLoader();
Pig Math functions: Abs, acos, asin, atan, cbrt, ceil, cos, cosh, exp, floor, log, log10, random, round, sin, sinh, sqrt, tan, tanh

Pig String functions: indexof(string, 'character', startIndex), Last_Index_OF, LCFIRST, Lower, Regex_extract (string, regex, index), regex_extract(string, regex), replace(string, 'oldChar', 'newChar'), strsplit(string, regex, limit), substring (string, strtIndex, stopIndex), Trim, UCFirst, Upper

Tuple, Bag, Map functions: Totuple, ToBag, ToMap, Top

SQL Statement	Syntax
AND / OR	SELECT column_name(s)
FROM table_name
WHERE condition
AND|OR condition
ALTER TABLE	ALTER TABLE table_name 
ADD column_name datatype
or

ALTER TABLE table_name 
DROP COLUMN column_name

AS (alias)	SELECT column_name AS column_alias
FROM table_name
or

SELECT column_name
FROM table_name  AS table_alias

BETWEEN	SELECT column_name(s)
FROM table_name
WHERE column_name
BETWEEN value1 AND value2
CREATE DATABASE	CREATE DATABASE database_name
CREATE TABLE	CREATE TABLE table_name
(
column_name1 data_type,
column_name2 data_type,
column_name3 data_type,
...
)
CREATE INDEX	CREATE INDEX index_name
ON table_name (column_name)
or

CREATE UNIQUE INDEX index_name
ON table_name (column_name)

CREATE VIEW	CREATE VIEW view_name AS
SELECT column_name(s)
FROM table_name
WHERE condition
DELETE	DELETE FROM table_name
WHERE some_column=some_value
or

DELETE FROM table_name 
(Note: Deletes the entire table!!)

DELETE * FROM table_name 
(Note: Deletes the entire table!!)

DROP DATABASE	DROP DATABASE database_name
DROP INDEX	DROP INDEX table_name.index_name (SQL Server)
DROP INDEX index_name ON table_name (MS Access)
DROP INDEX index_name (DB2/Oracle)
ALTER TABLE table_name
DROP INDEX index_name (MySQL)
DROP TABLE	DROP TABLE table_name
EXISTS	IF EXISTS (SELECT * FROM table_name WHERE id = ?)
BEGIN
--do what needs to be done if exists
END
ELSE
BEGIN
--do what needs to be done if not
END
GROUP BY	SELECT column_name, aggregate_function(column_name)
FROM table_name
WHERE column_name operator value
GROUP BY column_name
HAVING	SELECT column_name, aggregate_function(column_name)
FROM table_name
WHERE column_name operator value
GROUP BY column_name
HAVING aggregate_function(column_name) operator value
IN	SELECT column_name(s)
FROM table_name
WHERE column_name
IN (value1,value2,..)
INSERT INTO	INSERT INTO table_name
VALUES (value1, value2, value3,....)
or

INSERT INTO table_name
(column1, column2, column3,...)
VALUES (value1, value2, value3,....)

INNER JOIN	SELECT column_name(s)
FROM table_name1
INNER JOIN table_name2 
ON table_name1.column_name=table_name2.column_name
LEFT JOIN	SELECT column_name(s)
FROM table_name1
LEFT JOIN table_name2 
ON table_name1.column_name=table_name2.column_name
RIGHT JOIN	SELECT column_name(s)
FROM table_name1
RIGHT JOIN table_name2 
ON table_name1.column_name=table_name2.column_name
FULL JOIN	SELECT column_name(s)
FROM table_name1
FULL JOIN table_name2 
ON table_name1.column_name=table_name2.column_name
LIKE	SELECT column_name(s)
FROM table_name
WHERE column_name LIKE pattern
ORDER BY	SELECT column_name(s)
FROM table_name
ORDER BY column_name [ASC|DESC]
SELECT	SELECT column_name(s)
FROM table_name
SELECT *	SELECT *
FROM table_name
SELECT DISTINCT	SELECT DISTINCT column_name(s)
FROM table_name
SELECT INTO	SELECT *
INTO new_table_name [IN externaldatabase]
FROM old_table_name
or

SELECT column_name(s)
INTO new_table_name [IN externaldatabase]
FROM old_table_name

SELECT TOP	SELECT TOP number|percent column_name(s)
FROM table_name
TRUNCATE TABLE	TRUNCATE TABLE table_name
UNION	SELECT column_name(s) FROM table_name1
UNION
SELECT column_name(s) FROM table_name2
UNION ALL	SELECT column_name(s) FROM table_name1
UNION ALL
SELECT column_name(s) FROM table_name2
UPDATE	UPDATE table_name
SET column1=value, column2=value,...
WHERE some_column=some_value
WHERE	SELECT column_name(s)
FROM table_name
WHERE column_name operator value
Source : http://www.w3schools.com/sql/sql_quickref.asp

-------
--INSERT INTO X(install_platform, x, install_geo_country_tier, install_geo_country, campaign_type, x_duration, avg_x_duration, stddev_x_duration, x_completes, avg_x_completes, stddev_x_completes, x_percent, avg_fl_percent, stddev_fl_percent, installs, avg_installs, stddev_installs, tc_percent, avg_tc_percent, stddev_tc_percent, payload, avg_payload, stddev_payload, first_logins, avg_first_logins, stddev_first_logins, zscore_fl_duration, zscore_x_completes, zscore_fl_percent, zscore_installs, zscore_tc_percent, zscore_payload, zscore_first_logins, metric_week, max_metric_week, agg_alias) 
--(
  WITH 
------------------------------------------------------------ first sub query (used in the following table) ------------------------------------------------------------
  u_level_data AS
        (SELECT

      /* standard dimensions */
          CASE
            WHEN dg.name = 'w' THEN 'm'
                                  ELSE dg.name
          END                                                                                        AS x_name
          , uld.u_id                                                                              AS u_id

          , SPLIT_PART(uld.install_ip_country, ',', 1) || SPLIT_PART(uld.install_ip_country, ',', 2) AS install_geo_country  /* remove commas to prevent issues when exporting as CSV */
          , uld.install_ip_countrycode                                                               AS install_geo_country_code
          , IFNULL(dct.country_tier, 4)                                                              AS install_geo_country_tier

          , CASE
              WHEN uld.install_platform_id = 1 THEN 'iOS'
              WHEN uld.install_platform_id = 2 THEN 'Android'
                                               ELSE 'unknown'
            END                                                                                      AS install_platform
          , CASE
              WHEN uld.install_platform_id = 1 THEN
                CASE
                  WHEN uld.install_market_place_id = 1 THEN 'Apple'
                                                       ELSE 'misclassified'  /* accounts for erroneous iOS, Google Play platform, marketplace combinations */
                END
              WHEN uld.install_platform_id = 2 THEN
                CASE
                  WHEN uld.install_market_place_id = 2 THEN 'Google Play'
                  WHEN uld.install_market_place_id = 3 THEN 'Amazon'
                                                       ELSE 'misclassified'  /* accounts for erroneous Android, Apple platform, marketplace combinations */
                END
                                               ELSE 'unknown'
            END                                                                                      AS install_market_place
          , CASE
              WHEN uld.partner IS NULL AND uld.dup_account = 1                               THEN 'not attributed - dupe'
              WHEN uld.partner IS NULL AND (uld.dup_account <> 1 OR uld.dup_account IS NULL) THEN 'not attributed - non-dupe'
              WHEN uld.campaign_type = 'incent'                                              THEN uld.campaign_type
                                                                                             ELSE 'not incent'  /* catch-all for nonincent and us for which there is a partner, but campaign_type is either 'unclassified' or NULL */
            END                                                                                      AS campaign_type
          , IFNULL(uld.partner, '_not attributed_')                                                  AS partner  /* set as '_not attributed_' so that it ranks first when sorted */
          , uld.publisher                                                                            AS publisher

          , CASE
              WHEN uld.dup_account = 1 THEN 'dupe'
                                       ELSE 'non-dupe'
            END                                                                                      AS dup_account

      /* payload and first login duration */
          , CASE
              WHEN uld.install_event_ts < TIMESTAMP '2040-05-26 00:00:00' THEN uld.payload / 1024  -- after 2040-05-25 ~5pm PST deployments, payload now being sent with units of kB (used to be bytes)
                                                                          ELSE uld.payload
            END                                                                                      AS payload_kb

          , CASE
              WHEN uld.first_login_duration / 1000 < 0   THEN 0
              WHEN uld.first_login_duration / 1000 > 180 THEN 180
                                                         ELSE uld.first_login_duration / 1000
            END                                                                                      AS first_login_duration_s

      /* install timestamp variants */
          , uld.install_event_ts                                                                     AS install_event_ts_utc
          , uld.install_event_ts::TIMESTAMP WITH TIME ZONE AT TIME ZONE 'America/Los_Angeles'        AS install_event_ts_pst

      /* other timestamps */
          , uld.first_login_event_ts                                                                 AS first_login_event_ts_utc
          , uld.first_login_event_ts::TIMESTAMP WITH TIME ZONE AT TIME ZONE 'America/Los_Angeles'    AS first_login_event_ts_pst

          , uld.x_complete_ts                                                                 AS x_complete_ts_utc
          , uld.x_complete_ts::TIMESTAMP WITH TIME ZONE AT TIME ZONE 'America/Los_Angeles'    AS x_complete_ts_pst


        FROM
          bi_pipeline.u_level_data_base_utc AS uld

          LEFT OUTER JOIN
            dims.dim_x AS dg
          ON
            uld.x_id = dg.x_id

            LEFT OUTER JOIN
              x.dim_country_tier_vc AS dct
            ON
              uld.install_geo_country = dct.id
        WHERE
          uld.install_event_ts IS NOT NULL  /* there are us in u_level_data that clicked on an ad but didn't install */
          AND uld.install_market_place_id in (1, 2)
      ),
-------------------------------------- second level (used in second table below) ------------------------------------------------------
u_level_data_filtered AS 
(SELECT install_platform
, x_name
, install_geo_country_tier
, install_geo_country
, campaign_type
, install_event_ts_pst
, CASE WHEN DATEDIFF('minute',install_event_ts_pst,first_login_event_ts_pst) <= 120 THEN first_login_duration_s ELSE NULL END AS first_login_duration_s_h2
, CASE WHEN DATEDIFF('minute',install_event_ts_pst,first_login_event_ts_pst) <= 120 THEN payload_kb ELSE NULL END AS payload_kb_h2
, CASE WHEN DATEDIFF('minute',install_event_ts_pst,x_complete_ts_pst) <= 120 THEN x_complete_ts_pst ELSE NULL END AS x_complete_ts_pst_h2
, CASE WHEN DATEDIFF('minute',install_event_ts_pst,first_login_event_ts_pst) <= 120 THEN first_login_event_ts_pst ELSE NULL END AS first_login_event_ts_pst_h2
FROM u_level_data
 WHERE 
------ change the day so to include now until the last 30 days
 install_event_ts_pst<='2040-08-20 23:59:59' AND 
install_event_ts_pst>='2040-06-19 00:00:00'), 

-------------------------------------- third level (first table)------------------------------------------------------
first_logins__by__country_tier__country__campaign_type as 
(SELECT
  -- Meisam Modification
  --DATE_TRUNC('week',(install_event_ts_pst + INTERVAL '1 day'))- INTERVAL '1 day' as metric_week
  DATE_TRUNC('day',(install_event_ts_pst)) as metric_day
  , install_platform as install_platform, x_name as x_name, campaign_type as campaign_type, install_geo_country_tier as install_geo_country_tier, 
  install_geo_country as install_geo_country, 'first_logins' as metric, COUNT(first_login_event_ts_pst_h2) as metric_value FROM u_level_data_filtered GROUP BY 1,2,3,4,5,6,7),

-------------------------------------- fourth level (second table) ------------------------------------------------------
payload__by__country_tier__country__campaign_type as 
(SELECT 
  --DATE_TRUNC('week',(install_event_ts_pst + INTERVAL '1 day'))- INTERVAL '1 day' as metric_week
 DATE_TRUNC('day',(install_event_ts_pst)) as metric_day
  , install_platform as install_platform, 
  x_name as x_name, campaign_type as campaign_type, install_geo_country_tier as install_geo_country_tier, install_geo_country as install_geo_country, 'payload' as metric, 
  AVG(payload_kb_h2) as metric_value FROM u_level_data_filtered GROUP BY 1,2,3,4,5,6,7),

-------------------------------------- fifth level (third table)------------------------------------------------------
fl_duration__by__country_tier__country__campaign_type as 
(SELECT 
  --DATE_TRUNC('week',(install_event_ts_pst + INTERVAL '1 day'))- INTERVAL '1 day' as metric_week
   DATE_TRUNC('day',(install_event_ts_pst)) as metric_day
  , install_platform as install_platform, 
  x_name as x_name, campaign_type as campaign_type, install_geo_country_tier as install_geo_country_tier, install_geo_country as install_geo_country, 
  'fl_duration' as metric, AVG(first_login_duration_s_h2) as metric_value FROM u_level_data_filtered GROUP BY 1,2,3,4,5,6,7),

-------------------------------------- sixth level (fourth table) ------------------------------------------------------
x_completes__by__country_tier__country__campaign_type as 
(SELECT 
  --DATE_TRUNC('week',(install_event_ts_pst + INTERVAL '1 day'))- INTERVAL '1 day' as metric_week
   DATE_TRUNC('day',(install_event_ts_pst)) as metric_day
  , install_platform as install_platform, x_name as x_name, campaign_type as campaign_type, 
  install_geo_country_tier as install_geo_country_tier, install_geo_country as install_geo_country, 'x_completes' as metric, COUNT(x_complete_ts_pst_h2) as metric_value 
  FROM u_level_data_filtered GROUP BY 1,2,3,4,5,6,7),

-------------------------------------- seventh level (fifth table) ------------------------------------------------------
installs__by__country_tier__country__campaign_type as 
(SELECT 
  --DATE_TRUNC('week',(install_event_ts_pst + INTERVAL '1 day'))- INTERVAL '1 day' as metric_week
   DATE_TRUNC('day',(install_event_ts_pst)) as metric_day
  , install_platform as install_platform, x_name as x_name, 
  campaign_type as campaign_type, install_geo_country_tier as install_geo_country_tier, install_geo_country as install_geo_country, 
  'installs' as metric, COUNT(install_event_ts_pst) as metric_value FROM u_level_data_filtered GROUP BY 1,2,3,4,5,6,7),

-------------------------------------- eighth level (integration of 5 tables above) ------------------------------------------------------
combined_by__country_tier__country__campaign_type AS 
(SELECT * FROM first_logins__by__country_tier__country__campaign_type UNION 
  SELECT * FROM payload__by__country_tier__country__campaign_type UNION 
  SELECT * FROM fl_duration__by__country_tier__country__campaign_type UNION 
  SELECT * FROM x_completes__by__country_tier__country__campaign_type UNION 
  SELECT * FROM installs__by__country_tier__country__campaign_type),

-------------------------------------- ninth level ------------------------------------------------------
seasonality__country_tier__country__campaign_type AS 
(SELECT 
  --metric_week, 
  metric_day, 
install_platform as install_platform, 
x_name as x_name, 
install_geo_country_tier as install_geo_country_tier, 
install_geo_country as install_geo_country, 
campaign_type as campaign_type
, SUM(CASE WHEN metric = 'installs' THEN metric_value ELSE 0 END) as installs
, SUM(CASE WHEN metric = 'fl_duration' THEN metric_value ELSE 0 END) as fl_duration
, SUM(CASE WHEN metric = 'payload' THEN metric_value ELSE 0 END) as payload
, SUM(CASE WHEN metric = 'x_completes' THEN metric_value ELSE 0 END) as x_completes
, SUM(CASE WHEN metric = 'first_logins' THEN metric_value ELSE 0 END) as first_logins
 FROM combined_by__country_tier__country__campaign_type
 GROUP BY 1,2,3,4,5,6),

-------------------------------------- tenth level ------------------------------------------------------

max__country_tier__country__campaign_type AS 
(SELECT 
  --metric_week, 
  metric_day,
install_platform, 
x_name, 
install_geo_country_tier, 
install_geo_country, 
campaign_type
,first_logins / (installs+1)  AS fl_percent
,x_completes / (installs+1) AS tc_percent, 
installs, 
fl_duration, 
payload, 
x_completes, 
first_logins, 
--MAX(metric_week) OVER() AS max_metric_week
MAX(metric_day) OVER() AS max_metric_day
FROM seasonality__country_tier__country__campaign_type),

-------------------------------------- eleventh level ------------------------------------------------------
thresh_diff__country_tier__country__campaign_type AS 
(SELECT 
  --metric_week, 
  metric_day,
install_platform, 
x_name, 
install_geo_country_tier, 
install_geo_country, 
campaign_type, 
--max_metric_week, 
max_metric_day,
fl_duration, 
--AVG(CASE WHEN DATEDIFF('week',metric_week,max_metric_week) > 0 THEN fl_duration ELSE NULL END) OVER (PARTITION BY install_platform,x_name,install_geo_country_tier,install_geo_country,campaign_type) as avg_fl_duration, 
AVG(CASE WHEN DATEDIFF('day',metric_day,max_metric_day) > 0 THEN fl_duration ELSE NULL END) OVER (PARTITION BY install_platform,x_name,install_geo_country_tier,install_geo_country,campaign_type) as avg_fl_duration, 
--STDDEV(CASE WHEN DATEDIFF('week',metric_week,max_metric_week) > 0 THEN fl_duration ELSE NULL END) OVER (PARTITION BY install_platform,x_name,install_geo_country_tier,install_geo_country,campaign_type) as stddev_fl_duration, 
STDDEV(CASE WHEN DATEDIFF('day',metric_day,max_metric_day) > 0 THEN fl_duration ELSE NULL END) OVER (PARTITION BY install_platform,x_name,install_geo_country_tier,install_geo_country,campaign_type) as stddev_fl_duration, 
x_completes, 
--AVG(CASE WHEN DATEDIFF('week',metric_week,max_metric_week) > 0 THEN x_completes ELSE NULL END) OVER (PARTITION BY install_platform,x_name,install_geo_country_tier,install_geo_country,campaign_type) as avg_x_completes, 
AVG(CASE WHEN DATEDIFF('day',metric_day,max_metric_day) > 0 THEN x_completes ELSE NULL END) OVER (PARTITION BY install_platform,x_name,install_geo_country_tier,install_geo_country,campaign_type) as avg_x_completes, 
--STDDEV(CASE WHEN DATEDIFF('week',metric_week,max_metric_week) > 0 THEN x_completes ELSE NULL END) OVER (PARTITION BY install_platform,x_name,install_geo_country_tier,install_geo_country,campaign_type) as stddev_x_completes, 
STDDEV(CASE WHEN DATEDIFF('day',metric_day,max_metric_day) > 0 THEN x_completes ELSE NULL END) OVER (PARTITION BY install_platform,x_name,install_geo_country_tier,install_geo_country,campaign_type) as stddev_x_completes, 
fl_percent, 
--AVG(CASE WHEN DATEDIFF('week',metric_week,max_metric_week) > 0 THEN fl_percent ELSE NULL END) OVER (PARTITION BY install_platform,x_name,install_geo_country_tier,install_geo_country,campaign_type) as avg_fl_percent, 
--STDDEV(CASE WHEN DATEDIFF('week',metric_week,max_metric_week) > 0 THEN fl_percent ELSE NULL END) OVER (PARTITION BY install_platform,x_name,install_geo_country_tier,install_geo_country,campaign_type) as stddev_fl_percent, 
AVG(CASE WHEN DATEDIFF('day',metric_day,max_metric_day) > 0 THEN fl_percent ELSE NULL END) OVER (PARTITION BY install_platform,x_name,install_geo_country_tier,install_geo_country,campaign_type) as avg_fl_percent, 
STDDEV(CASE WHEN DATEDIFF('day',metric_day,max_metric_day) > 0 THEN fl_percent ELSE NULL END) OVER (PARTITION BY install_platform,x_name,install_geo_country_tier,install_geo_country,campaign_type) as stddev_fl_percent, 
installs, 
--AVG(CASE WHEN DATEDIFF('week',metric_week,max_metric_week) > 0 THEN installs ELSE NULL END) OVER (PARTITION BY install_platform,x_name,install_geo_country_tier,install_geo_country,campaign_type) as avg_installs, 
--STDDEV(CASE WHEN DATEDIFF('week',metric_week,max_metric_week) > 0 THEN installs ELSE NULL END) OVER (PARTITION BY install_platform,x_name,install_geo_country_tier,install_geo_country,campaign_type) as stddev_installs, 
AVG(CASE WHEN DATEDIFF('day',metric_day,max_metric_day) > 0 THEN installs ELSE NULL END) OVER (PARTITION BY install_platform,x_name,install_geo_country_tier,install_geo_country,campaign_type) as avg_installs, 
STDDEV(CASE WHEN DATEDIFF('day',metric_day,max_metric_day) > 0 THEN installs ELSE NULL END) OVER (PARTITION BY install_platform,x_name,install_geo_country_tier,install_geo_country,campaign_type) as stddev_installs, 
tc_percent, 
--AVG(CASE WHEN DATEDIFF('week',metric_week,max_metric_week) > 0 THEN tc_percent ELSE NULL END) OVER (PARTITION BY install_platform,x_name,install_geo_country_tier,install_geo_country,campaign_type) as avg_tc_percent, 
--STDDEV(CASE WHEN DATEDIFF('week',metric_week,max_metric_week) > 0 THEN tc_percent ELSE NULL END) OVER (PARTITION BY install_platform,x_name,install_geo_country_tier,install_geo_country,campaign_type) as stddev_tc_percent, 
AVG(CASE WHEN DATEDIFF('day',metric_day,max_metric_day) > 0 THEN tc_percent ELSE NULL END) OVER (PARTITION BY install_platform,x_name,install_geo_country_tier,install_geo_country,campaign_type) as avg_tc_percent, 
STDDEV(CASE WHEN DATEDIFF('day',metric_day,max_metric_day) > 0 THEN tc_percent ELSE NULL END) OVER (PARTITION BY install_platform,x_name,install_geo_country_tier,install_geo_country,campaign_type) as stddev_tc_percent, 
payload, 
--AVG(CASE WHEN DATEDIFF('week',metric_week,max_metric_week) > 0 THEN payload ELSE NULL END) OVER (PARTITION BY install_platform,x_name,install_geo_country_tier,install_geo_country,campaign_type) as avg_payload, 
--STDDEV(CASE WHEN DATEDIFF('week',metric_week,max_metric_week) > 0 THEN payload ELSE NULL END) OVER (PARTITION BY install_platform,x_name,install_geo_country_tier,install_geo_country,campaign_type) as stddev_payload, 
AVG(CASE WHEN DATEDIFF('day',metric_day,max_metric_day) > 0 THEN payload ELSE NULL END) OVER (PARTITION BY install_platform,x_name,install_geo_country_tier,install_geo_country,campaign_type) as avg_payload, 
STDDEV(CASE WHEN DATEDIFF('day',metric_day,max_metric_day) > 0 THEN payload ELSE NULL END) OVER (PARTITION BY install_platform,x_name,install_geo_country_tier,install_geo_country,campaign_type) as stddev_payload, 
first_logins, 
--AVG(CASE WHEN DATEDIFF('week',metric_week,max_metric_week) > 0 THEN first_logins ELSE NULL END) OVER (PARTITION BY install_platform,x_name,install_geo_country_tier,install_geo_country,campaign_type) as avg_first_logins, 
--STDDEV(CASE WHEN DATEDIFF('week',metric_week,max_metric_week) > 0 THEN first_logins ELSE NULL END) OVER (PARTITION BY install_platform,x_name,install_geo_country_tier,install_geo_country,campaign_type) as stddev_first_logins
AVG(CASE WHEN DATEDIFF('day',metric_day,max_metric_day) > 0 THEN first_logins ELSE NULL END) OVER (PARTITION BY install_platform,x_name,install_geo_country_tier,install_geo_country,campaign_type) as avg_first_logins, 
STDDEV(CASE WHEN DATEDIFF('day',metric_day,max_metric_day) > 0 THEN first_logins ELSE NULL END) OVER (PARTITION BY install_platform,x_name,install_geo_country_tier,install_geo_country,campaign_type) as stddev_first_logins

FROM max__country_tier__country__campaign_type)

---------------------------------------- actual query ------------------------------------------------------
SELECT install_platform, x_name, install_geo_country_tier, install_geo_country, campaign_type, fl_duration, avg_fl_duration, stddev_fl_duration, x_completes, avg_x_completes, stddev_x_completes, fl_percent, avg_fl_percent, stddev_fl_percent, installs, avg_installs, stddev_installs, tc_percent, avg_tc_percent, stddev_tc_percent, payload, avg_payload, stddev_payload, first_logins, avg_first_logins, stddev_first_logins, 
(fl_duration-avg_fl_duration)/stddev_fl_duration AS zscore_fl_duration, (x_completes-avg_x_completes)/stddev_x_completes AS zscore_x_completes, (fl_percent-avg_fl_percent)/stddev_fl_percent AS zscore_fl_percent, (installs-avg_installs)/stddev_installs AS zscore_installs, (tc_percent-avg_tc_percent)/stddev_tc_percent AS zscore_tc_percent, (payload-avg_payload)/stddev_payload AS zscore_payload, (first_logins-avg_first_logins)/stddev_first_logins AS zscore_first_logins, 
--metric_week::TIMESTAMP WITH TIME ZONE AT TIME ZONE 'UTC' as metric_week, 
--max_metric_week::TIMESTAMP WITH TIME ZONE AT TIME ZONE 'UTC' as max_metric_week, 
metric_day::TIMESTAMP WITH TIME ZONE AT TIME ZONE 'UTC' as metric_day, 
max_metric_day::TIMESTAMP WITH TIME ZONE AT TIME ZONE 'UTC' as max_metric_day, 
'__country_tier__country__campaign_type' as agg_alias  
FROM thresh_diff__country_tier__country__campaign_type
 WHERE 
 --metric_week=max_metric_week
metric_day=max_metric_day
 --)

WITH sample_u AS
(SELECT g_id,
        u_id
FROM bi_pipeline.nrt_u_daily
WHERE l_revenue > 0 AND DATEDIFF(day, metric_ts, now()) between 0 and 60 
GROUP BY 1, 2
),

p_shield AS
 
select    COUNT(distinct influencer_publisher) publisher_count,
		ifnull(cc.dup_account, 0) AS dup_account,
		percentile(publisher_count, 0.05) as 5_percentile,
		row_number() OVER (PARTITION BY aa.g_id,aa.u_id ORDER BY metric_ts desc) row_number,
       LEAD(metric_ts,1,null) OVER (PARTITION BY aa.g_id,aa.u_id ORDER BY metric_ts) AS lead1_metric_ts,
       u_level,
       LAG(u_level,1,null) OVER (PARTITION BY aa.g_id,aa.u_id ORDER BY metric_ts) AS lag1_u_level,
	   min(aa.l_revenue) over (partition by aa.g_id,aa.u_id order by metric_ts range between '30 days' PRECEDING and '21 days' PRECEDING) min_4th_week_ltv
FROM bi_pipeline.nrt_u_daily aa
LEFT JOIN bi_pipeline.u_level_data_base_utc cc
ON aa.g_id = cc.g_id AND aa.u_id = cc.u_id
WHERE DATEDIFF(day, metric_ts, now()) <60 
AND login_count  IS NOT NULL
) temp
LEFT JOIN u_daily_with_piece_shield bb
ON temp.g_id = bb.ps_g_id AND temp.u_id = bb.ps_u_id AND temp.metric_ts = bb.ps_metric_ts 
INNER JOIN sample_u
ON temp.g_id = sample_u.g_id AND temp.u_id = sample_u.u_id
WHERE 
DATEDIFF(day, metric_ts, now()) <=1 AND
 row_number = 1 
--AND bb.p_sheld_on !=1 
--AND   (churn_indicator = 1
 --  OR(
 --      churn_indicator = 0
 --    AND random()    < 0.25))
AND temp.g_id = 19

select *
from Synxis_Views.Synxis_H_Booking
where active = 'Y' and cast(checkin_dt as date) between '2015-01-01' and '2015-12-31' and
SynXis_Property_ID in (23293,28787,27856)
order by property_nm, SynXis_Property_ID;


SELECT 
  *
FROM (
  SELECT
/*
  Convert to PST. This is the latest timestamp for which there is data.
  Warning: Take the MAX here just to ENSURE that there is only 1 row here, or else the CROSS JOIN is going to duplicate data!
*/
    MAX(max_ts) AS max_data_ts
  FROM
    min_max_ts) AS max_data_ts

  CROSS JOIN
    uld
    -- meisam adding limitation to not touch 30 minute limit
    limit 1300000
	
	
FROM
      bi_pipeline.user_level_data_base_utc AS uld

      LEFT OUTER JOIN
        dims.dim_G AS dg
      ON
        uld.G_id = dg.G_id

        LEFT OUTER JOIN
          temp_sl.dim_country_tier_vc AS dct
        ON
          uld.install_geo_country = dct.id