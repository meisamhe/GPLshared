movies = load '/mxh109420/Spring-2015-input/movies.dat' using PigStorage(':') as (MOVIEID:int, TITLE:chararray, Genres:chararray);
Rating = load '/mxh109420/Spring-2015-input/ratings.dat' using PigStorage(':') as (USERID:int, MOVIEID:int, RATING:double, TIMESTAMP:chararray);
coGroupedRatMov = COGROUP movies BY MOVIEID, Rating BY MOVIEID;
semiJoinedMv= filter coGroupedRatMov by not IsEmpty(movies);
semiJoinedRslt= foreach semiJoinedMv generate flatten(Rating),flatten(movies);
only6ItemsSJ = limit semiJoinedRslt 6;
dump only6ItemsSJ ;