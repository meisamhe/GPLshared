#===================================================================================
Submission: Homework 1 for NLP class of Dr. Dan Moldovan
Meisam Hejazi Nia 
Doctoral Candidate in Management Science (Marketing Analytics)
Naveen Jindal School of Management, The University of Texas at Dallas
800 W Campbell rd | School of Management |Richardson, TX, 75080
Cell: 469.999.2798 
Email: meisam.hejazinia@utdallas.edu 
View my complete profile: http://www.hejazinia.com/
#===================================================================================
The Zip file contains:
(1) ASRHW2mxh109420py: the main file for three types of bigram models
(2) Corpus.txt: the corpus given to calculate the bigram
(3) ReadmeFileMxh109420.txt: the readme file

Requirements:
#====================
This program uses the following python libraries: nltk, math, sys, re

How to use?
python ASRHW2mxh109420.py <CORPUS-PATH> <BIGRAM OPTION>

<BIGRAM OPTION> includes: without-smoothing, add-one-smoothing, and Good-Turing-discounting

example if corpus is in the same folder:
for without-smoothing case:
====================
python ASRHW2mxh109420.py Corpus.txt without-smoothing

for without-smoothing case:
====================
python ASRHW2mxh109420.py Corpus.txt add-one-smoothing

for Good Turing Discounting case:
====================
python ASRHW2mxh109420.py Corpus.txt Good-Turing-discounting

Considerations:
#============================
To avoid the problem of log(0) undefined, I truncated log(0) at -1e100
I have used nltk wordnet lemmatization
I have used a sparse matrix represenation (implemented in a hash table) to reduce memory usage

Results
#===============================
1. For withoug smoothing case, the probability of both sentences are zero
2. For add-one-smoothing, the log probability of the second sentence is -8.50 which is higher than the log probability of the first sentence which is -162.92
3. For Good-Turing-discounting the log probability of the second sentence is -4.5 which is higher than the log probability of the first sentence which is -13.016

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