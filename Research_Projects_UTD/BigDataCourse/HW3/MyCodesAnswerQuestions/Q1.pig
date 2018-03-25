movies = load '/mxh109420/Spring-2015-input/movies.dat' using PigStorage(':') as (MOVIEID:int, TITLE:chararray, Genres:chararray);
onlyDramaComedy= FILTER movies BY ((Genres matches '.*Drama.*') AND (Genres matches '.*Comedy.*'));
Rating = load '/mxh109420/Spring-2015-input/ratings.dat' using PigStorage(':') as (USERID:int, MOVIEID:int, RATING:double, TIMESTAMP:chararray);
MVIDG = group Rating by MOVIEID;
AVGRT = foreach MVIDG generate group as MovieID,AVG(Rating.RATING) as avgRating;
moviesRating = JOIN onlyDramaComedy by MOVIEID, AVGRT by MovieID;
OrdrdComedyDrama = order moviesRating by avgRating ASC;
lowestComedyDrama = limit OrdrdComedyDrama 1;
ratedLCD = JOIN lowestComedyDrama by MOVIEID, Rating by MOVIEID;
users  = load '/mxh109420/Spring-2015-input/users.dat' using PigStorage(':') as (UserID:int, Gender:chararray, Age: int, Occupation:int, ZipCode:int);
users2040 = FILTER users BY ((Age>20) and (Age<40) and Gender=='M');
M2040RLCD = JOIN ratedLCD by USERID, users2040 by UserID;
M2040RLCDZ1 = FILTER M2040RLCD BY (( ZipCode >= 10000) AND ( ZipCode < 20000));
dump M2040RLCDZ1;