__author__ = 'MeisamHe'

# feature selection in WEKA
# keep only n features
nfeatures = 10
import os
inputFile = "C:\\Users\\MeisamHe\\Desktop\\BackupToRestoreComputerApril15\\MachineLearning\\Project\\combinedARFF\\combinedARFF.arff"
outputFile = "C:\\Users\\MeisamHe\\Desktop\\BackupToRestoreComputerApril15\\MachineLearning\\Project\\combinedARFF\\featureSelectedcombinedARFF.arff"
method = "weka.attributeSelection.PrincipalComponents -R 0.95 -A 5 -O"
#ranker = "weka.attributeSelection.Ranker -N %s"%nfeatures
evaluation = "weka.attributeSelection.InfoGainAttributeEval"
#filter = 'weka.filters.supervised.attribute.AttributeSelection'
numiter = -1
Wekapath = "C:/Python27/jars/weka.jar"
#featureSelectionCommand = 'java -Xmx6G -cp "%s" %s -S "%s" -E "%s" -i "%s" -o "%s" -c last'% (Wekapath, filter, ranker,evaluation,inputFile,outputFile)
ranker ="weka.attributeSelection.Ranker -T -1.7976931348623157E308 -N -1"

#trainingCommand = 'java -Xmx6G -cp "%s" %s -t "%s" -d "%s" > "%s"'% (Wekapath, method,ranker,inputFile,modelFile,trainingOutput)
#featureSelectionCommand = 'java -Xmx6G -cp "%s" %s -S "%s" -i "%s" -o "%s"'% (Wekapath, method,ranker,inputFile,outputFile)
#featureSelectionCommand = 'java -Xmx2G -cp "%s" %s -S "%s" -E "%s" -i "%s" -o "%s" -c last'% (Wekapath, method, ranker,evaluation,inputFile,outputFile)
featureSelectionCommand = 'java -Xmx2G -cp "%s" %s -i "%s"'% (Wekapath, method, inputFile)
# evaluation = "weka.attributeSelection.CfsSubsetEval -M"
# ranker = "weka.attributeSelection.BestFirst -D 1 -N 5"
# method = "weka.filters.supervised.attribute.AttributeSelection"
# featureSelectionCommand = 'java -Xmx2G -cp "%s" %s -E "%s" -S "%s" -i "%s" -o "%s"'%(Wekapath, method, evaluation,ranker,inputFile,outputFile)
print featureSelectionCommand
output=os.system(featureSelectionCommand)
print "output is:%s"%output
