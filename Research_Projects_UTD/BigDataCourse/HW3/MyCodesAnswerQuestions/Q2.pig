movies = load '/mxh109420/Spring-2015-input/movies.dat' using PigStorage(':') as (MOVIEID:int, TITLE:chararray, Genres:chararray);
Rating = load '/mxh109420/Spring-2015-input/ratings.dat' using PigStorage(':') as (USERID:int, MOVIEID:int, RATING:double, TIMESTAMP:chararray);
coGroupedRatMov = COGROUP movies BY MOVIEID, Rating BY MOVIEID;
only6Items = limit coGroupedRatMov 6;
dump only6Items ;