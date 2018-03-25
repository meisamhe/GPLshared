REGISTER /home/004/m/mx/mxh109420/PIG_UDF/pig_udf.jar;

movies = load '/mxh109420/Spring-2015-input/movies.dat' using PigStorage(':') as (MOVIEID:int, TITLE:chararray, GENRE:chararray);
reformatedMovies = FOREACH movies GENERATE MOVIEID, TITLE, FORMAT_GENRE_PIG(GENRE);
only6Items = limit reformatedMovies 6;
DUMP reformatedMovies ;