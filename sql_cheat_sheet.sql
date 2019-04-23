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

