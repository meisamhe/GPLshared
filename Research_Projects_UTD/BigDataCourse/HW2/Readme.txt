#===================================================================================
Submission: Homework 2 for Big Data class of Dr. Latifur Khan
Meisam Hejazi Nia 
Doctoral Candidate in Management Science (Marketing Analytics)
Naveen Jindal School of Management, The University of Texas at Dallas
800 W Campbell rd | School of Management |Richardson, TX, 75080
Cell: 469.999.2798 
Email: meisam.hejazinia@utdallas.edu 
View my complete profile: http://www.hejazinia.com/
#===================================================================================
The Zip file contains:
(1) HW2Q1.jar : the jar file for the solution of question 1 of homework 2: top 10 female rated movie titles, and their rating
(2) HW2Q2.jar : the jar file for the solution of question 2 of homework 2: given the ID of a movie, returns user id, gender and age of users who rated the movie 4 or above
(3) *. java: the source code corresponding to each of the jar file solutions

#===================================================================================================
# preparation with putting the data files into the related folders (ratings.dat, users.dat, movies.dat) each in the related folder
#===================================================================================================
hdfs dfs -put HW2Ratings HW2Ratings
hdfs dfs -put HW1Users HW1Users
hdfs dfs -put HW1Movies HW1Movies

#=========================================
//Big Data Homework one one IMDB basic statistics
// Code written by: Meisam Hejazi Nia
// Date: 03/05/2015
// Part 1: top 10 movies rated by female: output (title, average rating by female)
#=========================================
hdfs dfs -rmr outHW2Q1 
hadoop jar HW2Q1.jar HW2Q1 HW1Movies HW1Users HW2Ratings outHW2Q1
hdfs dfs -cat outHW2Q1/*


#==============================================
# Results
#================================================
Ulysses (Ulisse) (1954) 5.0
Time of the Gypsies (Dom za vesanje) (1989)     4.8333335
I Am Cuba (Soy Cuba/Ya Kuba) (1964)     4.75
Lamerica (1994) 4.6666665
Sanjuro (1962)  4.639344
Apple, The (Sib) (1998) 4.6
Godfather, The (1972)   4.5833335
Seven Samurai (The Magnificent Seven) (Shichinin no samurai) (1954)     4.576628
Shawshank Redemption, The (1994)        4.560625
Raiders of the Lost Ark (1981)  4.5205975


#=============================================
# Updated
#=============================================
hdfs dfs -rmr outHW2Q1 
hadoop jar HW2Q1Updated.jar HW2Q1 HW1Movies HW1Users HW2Ratings outHW2Q1
hdfs dfs -cat outHW2Q1/*

#========================================
//Big Data Homework one one IMDB basic statistics
// Code written by: Meisam Hejazi Nia
// Date: 03/05/2015
// Part 2: Given the id of a movie, find all userids,gender and age of users who rated the
// movie 4 or greater.
// You will input the movie id from command line.
#=========================================
# example movieID that user 1 rates 5: 1193
hdfs dfs -rmr outHW2Q2 
hadoop jar HW2Q2.jar HW2Q2 HW2Ratings HW1Users outHW2Q2 movieID
# e.g.
hadoop jar HW2Q2.jar HW2Q2 HW2Ratings HW1Users outHW2Q2 1193
hdfs dfs -cat outHW2Q2/*


#================================
# corrected version of the example given
#===============================
hdfs dfs -rmr outHW2Sample
hadoop jar HW2SimpleStartingPoint.jar HW2SimpleStartingPoint HW2Ratings HW1Movies outHW2Sample 12333
hdfs dfs -cat outHW2Sample/*

#===================================================================================
# End of File
Meisam Hejazi Nia 
Doctoral Candidate in Management Science (Marketing Analytics)
Naveen Jindal School of Management, The University of Texas at Dallas
800 W Campbell rd | School of Management |Richardson, TX, 75080
Cell: 469.999.2798 
Email: meisam.hejazinia@utdallas.edu 
View my complete profile: http://www.hejazinia.com/
#===================================================================================