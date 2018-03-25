#======================================================
# create the output from output of vowpel wabbit
# to start just open vW output and put simple prediction word at top 
# to make the files syncronized
#======================================================
logisticOut ="C:\\Users\\mxh109420\\Desktop\\KaggleCometition\\predictions.out"
#svmOut = "C:\\Users\\mxh109420\\Desktop\\KaggleCometition\\predictionsSVM.out" # path of to be outputted submission file
test = "C:\\Users\\mxh109420\\Desktop\\KaggleCometition\\test\\test.csv" 
submitableVWLR = "C:\\Users\\mxh109420\\Desktop\\KaggleCometition\\submissionVWPredictionsLR.csv" # path of to be outputted submission file
#submitableVWSVM = "C:\\Users\\mxh109420\\Desktop\\KaggleCometition\\submissionVWPredictionsSVM.csv" # path of to be outputted submission file


# I should add to one and divid by two because its current output is between -1 and 1
from itertools import izip
from datetime import datetime
from csv import DictReader
from math import exp, log, sqrt

numerator = 0	
with open(test, "r") as idFile, open(logisticOut, "r") as predFile, open(submitableVWLR, 'w') as outfile:
	outfile.write('id,click\n')
	for x, y in izip(idFile, predFile):
		# because the separator is comma
		numerator += 1
		if (numerator>1):
			ID = x.split(',')[0]
			y = y.split('\n')[0]
			print('LogRegnumerator is:%s'%numerator)
			prediction = (float(y)+1)/2
			outfile.write('%s,%s\n' % (ID, str(prediction)))



			
#numerator = 0	
#with open(test, "r") as idFile, open(svmOut, "r") as predFile, open(submitableVWSVM, 'w') as outfile:
#	outfile.write('id,click\n')
#	for x, y in izip(idFile, predFile):
#		# because the separator is comma
#		numerator += 1
#		if (numerator>1):
#			ID = x.split(',')[0]
#			y = y.split('\n')[0]
#			print('SVMnumerator is:%s'%numerator)
#			prediction = (float(y)+1)/2
#			outfile.write('%s,%s\n' % (ID, str(prediction)))


