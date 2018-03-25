import os

# to remove noisy features and put -1 and 1
os.system("pypy removeDevice_ipDevice_id.py")

# converting the training data into vowpal wabbit data
os.system("pypy ./FormatConversionVWLibSVM/phraug2-master/phraug2-master/csv2vwHeader.py ./train/trainRmDidDip.csv ./vwtrain.data -l 0 -s -c")

# converting the test data into vowpal wabbit data
os.system("pypy ./FormatConversionVWLibSVM/phraug2-master/phraug2-master/csv2vwHeader.py ./test/testRmDidDip.csv ./vwttest.data -l -1 -s -c")


#=====================================================================================
# l1 and l2 regularization: 0.689
#=====================================================================================
# run vowpal wabbit
os.system(".\vowelWabbit\vw.exe -d .\vwtrain.data -f .\predictor.vw --loss_function logistic --l2 1 --l1 1")
os.system(".\vowelWabbit\vw.exe -d .\vwttest.data -t -i .\predictor.vw -p .\predictions.out")

os.system(".\vowelWabbit\vw.exe -d .\vwttest.data -t -i .\predictor.vw -p .\predictions1.out + /utl/logistic ")

# before running this open the file and include header for it
os.system("pypy vowpelWabbitOutputCreation.py")


#=====================================================================================
# learning rate test: 1.10
#=====================================================================================
# run vowpal wabbit
os.system(".\vowelWabbit\vw.exe -d .\vwtrain.data -f .\predictorLr.vw --loss_function logistic --l2 1 --l1 1 -l 1")
os.system(".\vowelWabbit\vw.exe -d .\vwttest.data -t -i .\predictorLr.vw -p .\predictionsLr.out")

#***************
# before running this open the file and include header for it
#***************
os.system("pypy vowpelWabbitOutputCreationLr.py")

#=====================================================================================
# bucket size increase: 0.57
#=====================================================================================
# run vowpal wabbit
os.system(".\vowelWabbit\vw.exe -d .\vwtrain.data -f .\predictorBu.vw --loss_function logistic --l2 1 --l1 1 -b 20")
os.system(".\vowelWabbit\vw.exe -d .\vwttest.data -t -i .\predictorBu.vw -p .\predictionsBu.out")

#***************
# before running this open the file and include header for it
#***************
os.system("pypy vowpelWabbitOutputCreationBu.py")

#=====================================================================================
# Adaptive:0.400
#=====================================================================================
# run vowpal wabbit
os.system(".\vowelWabbit\vw.exe -d .\vwtrain.data -f .\predictorAd.vw --loss_function logistic --l2 0 --l1 0 --sgd")
os.system(".\vowelWabbit\vw.exe -d .\vwttest.data -t -i .\predictorAd.vw -p .\predictionsAd.out")

#***************
# before running this open the file and include header for it
#***************
os.system("pypy vowpelWabbitOutputCreationAd.py")

#=====================================================================================
# Adaptive: 0.93
#=====================================================================================
# run vowpal wabbit
os.system(".\vowelWabbit\vw.exe -d .\vwtrain.data -f .\predictorAd.vw --loss_function logistic --l2 0.001 --l1 0.000000001 --sgd")
os.system(".\vowelWabbit\vw.exe -d .\vwttest.data -t -i .\predictorAd.vw -p .\predictionsAd.out")

#***************
# before running this open the file and include header for it
#***************
os.system("pypy vowpelWabbitOutputCreationAd.py")

#=====================================================================================
# Adaptive: 0.93
#=====================================================================================
# run vowpal wabbit
os.system(".\vowelWabbit\vw.exe -d .\vwtrain.data -f .\predictorAd.vw --loss_function logistic --l2 0.000001 --l1 0.000000001 --sgd")
os.system(".\vowelWabbit\vw.exe -d .\vwttest.data -t -i .\predictorAd.vw -p .\predictionsAd.out")

#***************
# before running this open the file and include header for it
#***************
os.system("pypy vowpelWabbitOutputCreationAd.py")

#=====================================================================================
# Adaptive (no SGD anymore): 02/01/2015: 0.60255
#=====================================================================================
# run vowpal wabbit
os.system(".\vowelWabbit\vw.exe -d .\vwtrain.data -f .\predictorAd.vw --loss_function logistic --l2 1e-2 --l1 1e-8 --adaptive")
os.system(".\vowelWabbit\vw.exe -d .\vwttest.data -t -i .\predictorAd.vw -p .\predictionsAd.out")

#***************
# before running this open the file and include header for it
#***************
os.system("pypy vowpelWabbitOutputCreationAd.py")

#=====================================================================================
# Test SVM (no SGD anymore): 02/01/2015: 0.4734
#=====================================================================================
# run vowpal wabbit
os.system(".\vowelWabbit\vw.exe -d .\vwtrain.data -f .\predictorAd.vw --loss_function hinge --l2 1e-2 --l1 1e-8 --adaptive")
os.system(".\vowelWabbit\vw.exe -d .\vwttest.data -t -i .\predictorAd.vw -p .\predictionsAd.out")

#***************
# before running this open the file and include header for it
#***************
os.system("pypy vowpelWabbitOutputCreationAd.py")

#=====================================================================================
# Test SVM no regularization and not adaptive (no SGD anymore): 02/01/2015: 
#=====================================================================================
# run vowpal wabbit
os.system(".\vowelWabbit\vw.exe -d .\vwtrain.data -f .\predictorAd.vw --loss_function hinge --l2 0 --l1 0")
os.system(".\vowelWabbit\vw.exe -d .\vwttest.data -t -i .\predictorAd.vw -p .\predictionsAd.out")

#***************
# before running this open the file and include header for it
#***************
os.system("pypy vowpelWabbitOutputCreationAd.py")

#****************
# Linear transformation
#****************
os.system("pypy vowpelWabbitOutputCreationAdSVM.py")

#=====================================================================================
# Create test and validation set: 01/31/2015
#=====================================================================================
# to remove noisy features and put -1 and 1
os.system("pypy removeDevice_ipDevice_idTrainingValidation.py")

#trainRmDidDip ="C:\\Users\\mxh109420\\Desktop\\KaggleCometition\\train\\trainvalidRmDidDip.csv" # path of to be outputted submission file
#validRmDidDip = "C:\\Users\\mxh109420\\Desktop\\KaggleCometition\\test\\validationRmDidDip.csv" # path of to be outputted submission file

# converting the training data into vowpal wabbit data
os.system("pypy ./FormatConversionVWLibSVM/phraug2-master/phraug2-master/csv2vwHeader.py ./train/trainvalidRmDidDip.csv ./vwtrainvalid.data -l 0 -s -c")

# converting the test data into vowpal wabbit data
os.system("pypy ./FormatConversionVWLibSVM/phraug2-master/phraug2-master/csv2vwHeader.py ./test/validationRmDidDip.csv ./vwtValidation.data -l 0 -s -c")

# Trainvalidation set:  ./vwtrainvalid.data
# Validation set: ./vwtValidation.data


#=====================================================================================
# Adaptive sgd (training and validation set test):0.400
#=====================================================================================
# no regularization (training: 0.40, valid: 3.518)
os.system(".\vowelWabbit\vw.exe -d .\vwtrainvalid.data -f .\predictorAd.vw --loss_function logistic --l2 0 --l1 0 --sgd")
os.system(".\vowelWabbit\vw.exe -d .\vwtValidation.data -t -i .\predictorAd.vw -p .\predictionsAd.out")
# tiney regualirazation (training: 0.40, valid: 3.85)
os.system(".\vowelWabbit\vw.exe -d .\vwtrainvalid.data -f .\predictorAd.vw --loss_function logistic --l2 1e-8 --l1 1e-8 --sgd")
os.system(".\vowelWabbit\vw.exe -d .\vwtValidation.data -t -i .\predictorAd.vw -p .\predictionsAd.out")
# bigger regulization 2 (training: 0.48, valid: 59)
os.system(".\vowelWabbit\vw.exe -d .\vwtrainvalid.data -f .\predictorAd.vw --loss_function logistic --l2 1e-2 --l1 1e-8 --sgd")
os.system(".\vowelWabbit\vw.exe -d .\vwtValidation.data -t -i .\predictorAd.vw -p .\predictionsAd.out")
# small regularization (training: 0.39, valid: 3.51)
os.system(".\vowelWabbit\vw.exe -d .\vwtrainvalid.data -f .\predictorAd.vw --loss_function logistic --l2 1e-16 --l1 1e-16 --sgd")
os.system(".\vowelWabbit\vw.exe -d .\vwtValidation.data -t -i .\predictorAd.vw -p .\predictionsAd.out")

#=====================================================================================
# Adaptive adaptive (training and validation set test)
#=====================================================================================
# no regularization (training: 0.46, valid: 94.0)
os.system(".\vowelWabbit\vw.exe -d .\vwtrainvalid.data -f .\predictorAd.vw --loss_function logistic --l2 0 --l1 0 --adaptive")
os.system(".\vowelWabbit\vw.exe -d .\vwtValidation.data -t -i .\predictorAd.vw -p .\predictionsAd.out")
# tiney regualirazation (training: 0.45, valid: 3.16)
os.system(".\vowelWabbit\vw.exe -d .\vwtrainvalid.data -f .\predictorAd.vw --loss_function logistic --l2 1e-8 --l1 1e-8 --adaptive")
os.system(".\vowelWabbit\vw.exe -d .\vwtValidation.data -t -i .\predictorAd.vw -p .\predictionsAd.out")
# bigger regulization 2 (training: 0.55, valid: 0.599)
os.system(".\vowelWabbit\vw.exe -d .\vwtrainvalid.data -f .\predictorAd.vw --loss_function logistic --l2 1e-2 --l1 1e-8 --adaptive")
os.system(".\vowelWabbit\vw.exe -d .\vwtValidation.data -t -i .\predictorAd.vw -p .\predictionsAd.out")
# small regularization (training: 0.69, valid: 11)
os.system(".\vowelWabbit\vw.exe -d .\vwtrainvalid.data -f .\predictorAd.vw --loss_function logistic --l2 1e-2 --l1 1e-2 --adaptive")
os.system(".\vowelWabbit\vw.exe -d .\vwtValidation.data -t -i .\predictorAd.vw -p .\predictionsAd.out")
# Ali's configuration (training: 0.66, valid: 0.74)
os.system(".\vowelWabbit\vw.exe -d .\vwtrainvalid.data -f .\predictorAd.vw --loss_function logistic --l2 1e-1 --l1 0 --adaptive")
os.system(".\vowelWabbit\vw.exe -d .\vwtValidation.data -t -i .\predictorAd.vw -p .\predictionsAd.out")


