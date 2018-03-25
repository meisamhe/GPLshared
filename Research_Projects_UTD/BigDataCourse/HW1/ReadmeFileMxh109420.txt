#===================================================================================
Submission: Homework 1 for Big Data class of Dr. Latifur Khan
Meisam Hejazi Nia 
Doctoral Candidate in Management Science (Marketing Analytics)
Naveen Jindal School of Management, The University of Texas at Dallas
800 W Campbell rd | School of Management |Richardson, TX, 75080
Cell: 469.999.2798 
Email: meisam.hejazinia@utdallas.edu 
View my complete profile: http://www.hejazinia.com/
#===================================================================================
The Zip file contains:
(1) HW1Q1.jar : the jar file for the solution of question 1 of homework 1: list of all male user id, whose age is in group 7
(2) HW1Q2.jar : the jar file for the solution of question 2 of homework 1: Find the count of female and male users in each age group
(3) HW1Q3.jar : the jar file for the solution of question 3 of homework 1: List of all movie titles in genre "Fantasy"
(4) HW1Q1Q2Q3.jar: the signle jar file containing the solutions for question 1, 2 and 3
(5) *. java: the source code corresponding to each of the jar file solutions

How to use?
#====================
HW1 commands
#===============================================

#==================
Q1
#==================
clear
# put files of input for users into the hdfs
hdfs dfs -put HW1Users HW1Users

# remove the output of previous run
hdfs dfs -rmr outHW1Users

# run the map-reduce program and check the results
hadoop jar HW1Q1.jar HW1Q1 HW1Users outHW1Users
hdfs dfs -cat outHW1Users/*

#==================
Q2
#==================
clear
# put files of input for users into the hdfs
hdfs dfs -put HW1Users HW1Users

# remove the output of previous run
hdfs dfs -rmr outHW1Q2MFAge

# run the map-reduce program and check the results
hadoop jar HW1Q2.jar HW1Q2 HW1Users outHW1Q2MFAge
hdfs dfs -cat outHW1Q2MFAge/*

#==================
Q3
#==================
clear
# put files of input for movies into the hdfs
hdfs dfs -put HW1Movies HW1Movies

# remove the output of previous run
hdfs dfs -rmr outHW1Q3TTlGnre

# run the map-reduce program and check the results
hadoop jar HW1Q3.jar HW1Q3 HW1Movies outHW1Q3TTlGnre Fantasy
hdfs dfs -cat outHW1Q3TTlGnre/*


#==============================
Single File of Q1, Q2, and Q3
#==============================
clear
# put files of input which are in folders of HW1Users and HW1 Movies into the hdfs
hdfs dfs -put HW1Users HW1Users
hdfs dfs -put HW1Movies HW1Movies

# remove the output of previous run
hdfs dfs -rmr outHW1Users
hdfs dfs -rmr outHW1Q2MFAge
hdfs dfs -rmr outHW1Q3TTlGnre

# run the map-reduce program and check the results

#Q1
clear
hadoop jar HW1Q1Q2Q3.jar HW1Q1 HW1Users outHW1Users
hdfs dfs -cat outHW1Users/*

#Q2
clear
hadoop jar HW1Q1Q2Q3.jar HW1Q2 HW1Users outHW1Q2MFAge
hdfs dfs -cat outHW1Q2MFAge/*

#Q3
clear
hadoop jar HW1Q1Q2Q3.jar HW1Q3 HW1Movies outHW1Q3TTlGnre Fantasy
hdfs dfs -cat outHW1Q3TTlGnre/*

if you had any problem in running the program, please do not hesistate to drop me an email: meisam.hejazinia@utdallas.edu 

#===================================================================================
# End of File
Meisam Hejazi Nia 
Doctoral Candidate in Management Science (Marketing Analytics)
Naveen Jindal School of Management, The University of Texas at Dallas
800 W Campbell rd | School of Management |Richardson, TX, 75080
Cell: 469.999.2798 
Email: meisam.hejazinia@utdallas.edu 
View my complete profile: http://www.hejazinia.com/
#====================================================
#===================================================================================