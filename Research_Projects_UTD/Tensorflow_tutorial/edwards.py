import os
import datetime
from json import loads
import os
import matplotlib.pyplot as plt
import pandas as pd
import pandas as pd
import numpy as np
import datetime
from scipy.sparse import csc_matrix
from sklearn import preprocessing

inspect.getsourcelines(cc.load_spark_context)

os.environ["SPARK_HOME"] = cc.SPARK_HOME
conf = cc.SparkConf()  .setMaster(cc.SPARK_MASTER)  .set('spark.executor.memory', '8g')  .set('spark.speculation',True)  .set('spark.locality.wait', 3000)  .setAppName('Analysis of EP')  .set('spark.ui.port', 24123)  .set("spark.cores.max", str(32))  .set("spark.sql.crossJoin.enabled", False)  .set("spark.task.maxFailures",50)
sc = cc.SparkContext(conf=conf)
sc.addPyFile('x.py')

sqlContext = pyspark.SQLContext(sc)

print(cc.hdfs_system)

cwd = os.getcwd()
print(cwd)


type(test)
test.take(3)


test.count()

emailSIC = test.select(test['XX'].alias('X'),
        testMDM['xx'].alias('x'))\
.filter("xx != ''")\
.filter("xx != ''")\
.filter('length(x)>4')

x = x.filter(lambda x: 'x' in x).map(loads).map(lambda x: (logutils.get(x, ['d', 't', '*', 'n'])[0],
    logutils.get(x, ['t']))).distinct().countByKey()
x

x = x.filter(lambda x: 'x' in x).map(loads).    map(lambda x: (logutils.get(x, ['data', 't', '*', 'name'])[0],                   datetime.datetime.fromtimestamp(
                        float(logutils.get(x, ['ts']))/1000
                    ).strftime('%Y-%m-%d %H:%M'),\
                   logutils.get(x, ['x']),logutils.get(x, ['x']))) \
    .filter(lambda x: x[0] is not None and x[1] is not None and x[2] is not None and x[3] is not None and \
           x[3] is not None)

schema = StructType([    StructField("t", StringType(), True),    StructField("ts", StringType(), True),    StructField("id", StringType(), True),    StructField("sud", StringType(), True)])

# Apply the schema to the RDD.
dataForModelDF = sqlContext.createDataFrame(dataForModel, schema)

# save intermediary file
dataForModelDF.write.save(savePath+projectName+"dataForModelDF.Full.parquet", format="parquet")

# read the parquet intermediary file 
dataForModelDF = sqlContext.read.load(savePath+projectName+"dataForModelDF.Full.parquet")
print(dataForModelDF.take(5))

#----------------------------------
# define MID and Right functions as it seems they are not available
#----------------------------------
#first we create a Python function:
def LEFT(string, amount):
    return string[:amount]

def RIGHT(string, amount):
    return string[-amount:]

def MID(string, offset, end):
    # as indx starts from 0 in python
    return string[(offset-1):(end)]

def NoneToZero(string):
    # as indx starts from 0 in python
    if str(string)=='None':
        return 0
    else:
        return string

#now we can register the function for use in SQL
sqlContext.registerFunction("LEFT", LEFT)
sqlContext.registerFunction("RIGHT", RIGHT)
sqlContext.registerFunction("MID", MID)
sqlContext.registerFunction("NoneToZero", NoneToZero)

#----------------------------------

query = """
select
    RIGHT(t,11) as t, 
    MID(ts,6,7) as m,
    MID(ts,9,10) as d,
    MID(ts,12,13) as h,
    i, 
    sessionID
from
    RawData RW
"""
#     NoneToZero(r) as r
#     RIGHT(TimeStamp,2) as Minute,
preProcessedDT = sqlContext.sql(query)

#-----------------------------
# saving results into intermediary files
#---------------------------
preProcessedDT.write.save(savePath+projectName+"preProcessedDT.Full.parquet", format="parquet", mode='overwrite')


HDFS = cc.hdfs_system
source = [HDFS + 'x/2016/10/2[7-9]/']        + [HDFS + 'x/2016/10/3[0-1]/']        + [HDFS + 'x/2016/11/0[1-9]/']         + [HDFS + 'x/2016/11/1[0-7]/'] 
source_df = sqlContext.read.parquet(*source)


e.write.mode('overwrite')    .save(savePath+projectName+"e.Full.parquet", format="parquet")


# key part to use in Dataframe
mappingTable={}
baseCase = {}
for feature in catFeature:
    labelEncoder = preprocessing.LabelEncoder()
    #to convert into numbers
    DataPD['%sDummy'%feature] = labelEncoder.fit_transform(DataPD[feature])
    # create the mapping table
    mappingTable[feature]=DataPD[[feature,'%sDummy'%feature]].drop_duplicates().reset_index(drop=True)
    #to convert back
    #train.t = labelEncoder.inverse_transform(DataPD.tDummy)
    # print mapping table to make sure it is alright
    print(mappingTable[feature])
    # set the base case to be ignored in estimation to avoid multi-collinearity
    if feature=='t':
        curMappingTable = mappingTable[feature]
        baseCase[feature] = int(curMappingTable[curMappingTable[feature]==baset]['%sDummy'%feature])
    else:
        baseCase[feature] = 0
    # print the base case
    print('the base case for %s feature is: %s'%(feature,baseCase[feature]))

def replaceInteractionBaseCASE(tn, actualString):
    if tn in actualString: 
        return ('BaseCASE')
    else:
        return (actualString)


for feature in interactionVariables:
    variable = feature.split(" ")[0]
    labelEncoder = preprocessing.LabelEncoder()
    # create the interaction term string first
    DataPD[feature] = DataPD[variable]+'*'+DataPD['t']
    # replace items with base t in them
    DataPD[feature] = DataPD[feature].map(lambda x: replaceInteractionBaseCASE(baset,x))
    #to convert into numbers
    DataPD['%sDummy'%feature] = labelEncoder.fit_transform(DataPD[feature])
    # create the mapping table
    mappingTable[feature]=DataPD[[feature,'%sDummy'%feature]].drop_duplicates().reset_index(drop=True)
    #to convert back
    #train.t = labelEncoder.inverse_transform(DataPD.tDummy)
    # print mapping table to make sure it is alright
    print(mappingTable[feature])
    # set the base case to be ignored in estimation to avoid multi-collinearity
    curMappingTable = mappingTable[feature]
    baseCase[feature] = int(curMappingTable[curMappingTable[feature]=='BaseCASE']['%sDummy'%feature])
    # print the base case
    print('the base case for %s feature is: %s'%(feature,baseCase[feature]))

# save the mapping tables and the base cases
variableList = mappingTable.keys()
baseCaseIndex = []
for variable in variableList:
    mappingTable[variable].to_csv('%s.csv'%variable)
    #print('current variable is: %s'%variable)
    #print('base case is: %s'%baseCase[variable])
    baseCaseIndex.append(baseCase[variable])
VariableBaseCase = {'Variable' : pd.Series(variableList, index=range(0,len(variableList))),      'BaseCase' : pd.Series(baseCaseIndex, index=range(0,len(variableList)))}
VariableBaseCaseDF = pd.DataFrame(VariableBaseCase)
VariableBaseCaseDF.to_csv('VariableBaseCaseDF.Full.csv')
print(VariableBaseCaseDF)

import os
os.getcwd()

variablesOfIntrest = ["Intercept", "numSessions"] 
DummyVariableList = ['{}{}'.format(b, 'Dummy') for b in variableList]
variablesOfIntrest = variablesOfIntrest + DummyVariableList
# add the interaction b/w number of sessions and t
variablesOfIntrest = variablesOfIntrest + itn
print('variables of Interest vector includes:')
print(variablesOfIntrest)

typeOfVOI = ['Dummy','Quant']+['Dummy']*len(DummyVariableList)+['Quant']*len(itn)
lenOfVOI = [1,1]
for variable in DummyVariableList:
    lenOfVOI = lenOfVOI + [DummyVarSize[variable]]
lenOfVOI = lenOfVOI + [1]*len(itn)
print(variablesOfIntrest)
print(typeOfVOI)
print('length of VOI is:%s'%len(variablesOfIntrest))
print('length of type of VOI is: %s'%len(typeOfVOI))
print('the size of each of the variables are:')
print(lenOfVOI)

lenOfVOIHash = {}
typeOfVOIHash = {}
baseCaseHash = {}
# put size and type of each variable per hash table
for i in range(0,len(typeOfVOI)):
    curVOI = variablesOfIntrest[i] 
    lenOfVOIHash[curVOI] =  lenOfVOI[i]
    typeOfVOIHash[curVOI] = typeOfVOI[i]
    if curVOI in  baseCase.keys():
        baseCaseHash[curVOI] = baseCase[curVOI]
    else:
        baseCaseHash[curVOI] = -1
print(lenOfVOIHash)
print(typeOfVOIHash)
print(baseCaseHash)


# function: Develop the estimation function based on Maximum-A-Posteriori (Random effect)> Logit portions for conversion
# ----------
# 1. in time effect
# 2. in indiv. effect
# 3. in the interactions
# 
# 
# - Reuse my code for the MAP estimationf for logit, but make it batch mode and map-reduce
# - The estimation considers prior on the parameters (separate estimation from inference)
# - M-step estimate random effects (coordinate ascent)
# - E-step use close form solution for the regression given the random effects
# - The inference uses the close form solution (use my Excel file of choice seminar) => no, for now I can use my derivative of the MAP

# first create vector of parameters 
#---------------------------
# a function to create random parameter vector
def createRandomParamVec(size):
    return np.random.uniform(-1, 1,size)
# for ease of use, use hash table to create the sub parameter vector which later on can be used
#      for easier multiplication
# parameter vector initialization which will be used for each update
paramVector={}
# also create the mean and variance vector for prior (except for Intercept for the rest)
meanPrior = {}
varPrior = {}
for variable in variablesOfIntrest:
    paramVector[variable] = createRandomParamVec(lenOfVOIHash[variable])
    print('the variable name is: %s and the size of vector is: %s'%(variable,lenOfVOIHash[variable]))
    varPrior[variable] = np.random.uniform(0, 40) 
    meanPrior[variable] = np.random.uniform(-1, 1)
	
# Response variables: r, Purchased
print ("the mean of the prior initial is: %s"%meanPrior)
print ("the variance of the prior initially is: %s"%varPrior)
print("the vector of the parameters initial is: %s"%paramVector)
# test by multiplying to encoded.take(1) ... Done above

# compute likelihood
# do vector multiplication (map)
# create the sum (reduce) across all
# consider whether the variable is categorical or quantitative(i.e. interval) 
#     so that if it is categorical only the index be used
import math
def logExp(designMatRow,paramVector, typeOfVOIHash, baseCaseHash, Neg):
    # for base cases multiply to zero as well (as this should have no effect)
    # Utility (Uit) is defined as beta(cT)*x(i)
    Uit = float(paramVector['Intercept'])
    #print('beginning Uit is: %s'%Uit)
    # print('intercept is: %s'%paramVector['Intercept'])
    for var in paramVector.keys():
        # print('variable is: %s and the type is: %s'%(var, typeOfVOIHash[var]))
        if var == 'Intercept':
            pass
        else:
            # if it is categorical variable then use it as index
            if (typeOfVOIHash[var]== 'Dummy'):
                # if it is not base then just use it as index
                curDummyIndex = designMatRow[var]
                # print('current index is: %s and the base index is: %s'%(curDummyIndex, baseCaseHash[var]))
                if (baseCaseHash[var]!=curDummyIndex):
                    Uit += float(paramVector[var][curDummyIndex]) #b/c this is indicator variable (i.e. eq. to 1)
                    # print ('the non base param value is: %s'%paramVector[var][curDummyIndex])
                else: # if it is base then multiply it to zero (i.e. pass)
                    pass
            else: # i.e. when the variable is quantitative
                # if it is not categorical then use multiplication
                # print('quantitative param value is: %s'%float(paramVector[var]))
                # print('the design Matrix value is: %s'%float(designMatRow[var]))
                Uit += float(paramVector[var])*float(designMatRow[var])
    #print('Uit is: %s'%Uit)
    if (Neg==1):
        # take care of the range
        if Uit>30:
            Uit = 30
        if Uit<-30:
            Uit = -30
        return math.log(1+math.exp(-Uit))
    else:
        if Uit>30:
            Uit = 30
        if Uit<-30:
            Uit = -30
        return math.log(1+math.exp(Uit))
		

# test the log(1+exp) function
print('Design Matrix is:')
print(DataPD.ix[1])
print('the positive logExpon Func is: %s'%logExp(DataPD.ix[1],paramVector, typeOfVOIHash, baseCaseHash, 0))
print('the negative logExpon Func is: %s'%logExp(DataPD.ix[1],paramVector, typeOfVOIHash, baseCaseHash, 1))

# define log-likelihood function
def logLike(designMatRow,paramVector, typeOfVOIHash, baseCaseHash):
    #y(i)*logExpNeg - (1-y(i))*logExpPos
    logExpNeg = logExp(designMatRow,paramVector, typeOfVOIHash, baseCaseHash, 1)
    logExpPos = logExp(designMatRow,paramVector, typeOfVOIHash, baseCaseHash, 0)
    return pd.Series(dict(logLik =                           -designMatRow['Purchased'] * logExpNeg - (1- designMatRow['Purchased'] ) * logExpPos))

def prior(paramVector,lenOfVOIHash, meanPrior,varPrior):
    prior = 0.0
    pi = math.pi
    for var in paramVector.keys():
        # print('variable is: %s and the type is: %s'%(var, typeOfVOIHash[var]))
        sizeOfCurVar = lenOfVOIHash[var]
        curVarMean =  meanPrior[var]
        curVarVariance = varPrior[var]
        for i in range(0,sizeOfCurVar):
            curVarValue = paramVector[var][i]
            prior += (math.log(math.sqrt(curVarVariance))+math.log(2*pi)/2.0+                     float(curVarValue-curVarMean)*float(curVarValue-curVarMean)/(2.0*curVarVariance))
    return -prior
# unit test the prior function
print('prior computed is: %s'%prior(paramVector,lenOfVOIHash, meanPrior,varPrior))

def prob(designMatRow,paramVector, typeOfVOIHash, baseCaseHash):
    logExpNeg = logExp(designMatRow,paramVector, typeOfVOIHash, baseCaseHash, 1)
    return pd.Series(dict(prob = math.exp(-logExpNeg)))
	
# first gradient function
def GradHess(curVar, paramVector, designMat, typeOfVOIHash, baseCaseHash, lenOfVOIHash, meanPrior, varPrior): 
    # for base cases multiply to zero as well (as this should have no effect)
    var = curVar
    sizeOfCurVar = lenOfVOIHash[var]
    curVarMean =  meanPrior[var]
    curVarVariance = varPrior[var]
    if var == 'Intercept': # every vector has an intercept
        curGrad =  (1.0*(designMat['Purchased']- designMat['prob'])).sum() -                 float(paramVector[var]-curVarMean)/curVarVariance
        curHess = ((1.0**2)*(designMat['prob']**2)).sum() -                 1.0/curVarVariance
        return [curGrad, curHess]
    else:
        # if it is categorical variable then use it as index
        if (typeOfVOIHash[var]== 'Dummy'):
            # if it is not base then just use it as index
            curGradVec = [0.0]* lenOfVOIHash[var]
            curHessVec = [0.0]* lenOfVOIHash[var]
            # to make  the following process more efficient, I will only pass through the whole
            #    pandas data frame once
            if float(sizeOfCurVar)/designMat.shape[0]>0.5:
                for i in range(0,designMat.shape[0]):
                    curDummyIndex = designMat.ix[i][var]
                    if (baseCaseHash[var]!=curDummyIndex):
                        curGradVec[curDummyIndex] += (1.0*(designMat.ix[i]['Purchased']- designMat.ix[i]['prob']))
                        curHessVec[curDummyIndex] += ((1.0**2)*(designMat.ix[i]['prob']*(1-designMat.ix[i]['prob'])))
                    else:
                        pass
                # finally add back the prior portion
                for curDummyIndex in range(0,sizeOfCurVar):
                    if (baseCaseHash[var]!=curDummyIndex):
                        curGradVec[curDummyIndex]-= float(paramVector[var][curDummyIndex]-curVarMean)/curVarVariance
                        curHessVec[curDummyIndex] -= 1.0/curVarVariance
                    else:
                        pass
            else: # i.e. when the size is smaller
                for curDummyIndex in range(0,sizeOfCurVar):
                    # print('current index is: %s and the base index is: %s'%(curDummyIndex, baseCaseHash[var]))
                    if (baseCaseHash[var]!=curDummyIndex):
                        # first extract the rows with the current index
                        subDesignMat = designMat[designMat[var]==curDummyIndex]
                        # for this sub-design matrix we know that all dummy variables are one
                        curGradVec[curDummyIndex] = (1.0*(subDesignMat['Purchased']- subDesignMat['prob'])).sum() -                                 float(paramVector[var][curDummyIndex]-curVarMean)/curVarVariance
                        curHessVec[curDummyIndex] = ((1.0**2)*(subDesignMat['prob']*(1-subDesignMat['prob']))).sum() -                                 1.0/curVarVariance
                    else: # if it is base then multiply it to zero (i.e. pass)
                        pass
            return [curGradVec, curHessVec]
        else: # i.e. when the variable is quantitative
            # if it is not categorical then use multiplication
            # print('quantitative param value is: %s'%float(paramVector[var]))
            # print('the design Matrix value is: %s'%float(designMatRow[var]))
            curGrad = (designMat[var]*(designMat['Purchased']- designMat['prob'])).sum() -                 float(paramVector[var]-curVarMean)/curVarVariance
            curHess = ((designMat[var]**2)*(designMat['prob']*(1-designMat['prob']))).sum() -1.0/curVarVariance
            return [curGrad, curHess]


# Next: write the E- step (i.e. mean and variance of prior)
# output will be two vectors in a list:
# [meanPrior,varPrior]
def ExpectedHierPrior(paramVector,lenOfVOIHash, meanPrior, varPrior):
    priorMeanOutput = {}
    priorVarOutput = {}
    for var in paramVector.keys():
        if (lenOfVOIHash[var]>2):
            # this is an improvement, as the best estimate is median and not mean to not be driven by outliers
            priorMeanOutput[var] = np.median(paramVector[var])
            # make sure we smooth and say we always have uncertaint, even though the data might have missed it
            priorVarOutput[var] = np.std(paramVector[var])+1e-10 
        else:
            priorMeanOutput[var] = meanPrior[var]
            priorVarOutput[var] = varPrior[var]
    return [priorMeanOutput,priorVarOutput]
print('the E-step will generate the following updated hierarchical prior:')
ExpectedHierPrior(paramVector,lenOfVOIHash, meanPrior, varPrior)

def RegPredItem(designMatRow,paramVector, typeOfVOIHash, baseCaseHash):
    # for base cases multiply to zero as well (as this should have no effect)
    # regPred [yHat(it)] is defined as beta(cT)*x(i)
    regPred = float(paramVector['Intercept'])
    #print('beginning Uit is: %s'%Uit)
    # print('intercept is: %s'%paramVector['Intercept'])
    for var in paramVector.keys():
        # print('variable is: %s and the type is: %s'%(var, typeOfVOIHash[var]))
        if var == 'Intercept':
            pass
        else:
            # if it is categorical variable then use it as index
            if (typeOfVOIHash[var]== 'Dummy'):
                # if it is not base then just use it as index
                curDummyIndex = designMatRow[var]
                # print('current index is: %s and the base index is: %s'%(curDummyIndex, baseCaseHash[var]))
                if (baseCaseHash[var]!=curDummyIndex):
                    regPred += float(paramVector[var][curDummyIndex]) #b/c this is indicator variable (i.e. eq. to 1)
                    # print ('the non base param value is: %s'%paramVector[var][curDummyIndex])
                else: # if it is base then multiply it to zero (i.e. pass)
                    pass
            else: # i.e. when the variable is quantitative
                # if it is not categorical then use multiplication
                # print('quantitative param value is: %s'%float(paramVector[var]))
                # print('the design Matrix value is: %s'%float(designMatRow[var]))
                regPred += float(paramVector[var])*float(designMatRow[var])
    #print('yHat(it) is: %s'%regPred)
    return regPred
	
# function to create regression prediction in as a Pandas Series
def RegPred(designMatRow,paramVector, typeOfVOIHash, baseCaseHash):
    regPred = RegPredItem(designMatRow,paramVector, typeOfVOIHash, baseCaseHash)
    return pd.Series(dict(RegPred = regPred))
	
def logLikeGaussrv(designMatRow, VarError): 
    # this function shall be called after Errors have been created
    pi = math.pi
    return pd.Series(dict(logLikrv = -(math.log(math.sqrt(VarError))+math.log(2*pi)/2.0+                     float(designMatRow['rvError']**2)/(2.0*VarError))))
	
# test behavior of this likelihood function with respect to variance of error
tmp = np.array([0,1,2,3,4,5])
print(np.mean(tmp))
print(np.std(tmp))
import numpy as np
def f(x):
    #print ve
    return -(math.log(math.sqrt(ve))+math.log(2*math.pi)/2.0+                     float(x**2)/(2.0*ve))
f = np.vectorize(f)  # or use a different name if you want to keep the original f
def varEffLog(x):
    return -(math.log(math.sqrt(ve)))
varEffLog = np.vectorize(varEffLog)
def squareErrorVarEffect(x):
    return -float(x**2)/(2.0*ve)
squareErrorVarEffect = np.vectorize(squareErrorVarEffect)
#result_array = f(tmp)  # if A is your Numpy array
ve = 0.01
print np.sum(f(tmp)), np.sum(varEffLog(tmp)), np.sum(squareErrorVarEffect(tmp))
ve = 1
print np.sum(f(tmp)), np.sum(varEffLog(tmp)), np.sum(squareErrorVarEffect(tmp))
ve = 2
print np.sum(f(tmp)), np.sum(varEffLog(tmp)), np.sum(squareErrorVarEffect(tmp))
ve = 3
print np.sum(f(tmp)), np.sum(varEffLog(tmp)), np.sum(squareErrorVarEffect(tmp))
ve = 500
print np.sum(f(tmp)), np.sum(varEffLog(tmp)), np.sum(squareErrorVarEffect(tmp))

# at first look it seems for regression I don't need the gradient decent as it has closed form,
#    but the Matrix multiplication requires a rvisit, as my Matrixes are sparse Matrix
# But the problem is that we have penalty term, so this way the closed form is not available anymore
# this way I have to use gradient decend as well
# As a result my old code is only good for inference portion and not the estimation portion
#-------------------------------------
def GradHessHRegrv(curVar, paramVector, designMat, typeOfVOIHash, baseCaseHash, lenOfVOIHash,                  meanPrior, varPrior, VarError, discountPriorOrder): 
    # discountPriorOrder is new parameter I added to increase the weight of likelihood with respect to the prior
    # for base cases multiply to zero as well (as this should have no effect)
    var = curVar
    sizeOfCurVar = lenOfVOIHash[var]
    curVarMean =  meanPrior[var]
    curVarVariance = varPrior[var]
    if var == 'Intercept': # every vector has an intercept
        curGrad =  (1.0*(designMat['rvError'].astype(float))/VarError).sum() -                 float(paramVector[var]-curVarMean)/curVarVariance
        curHess = (-(1.0**2)/VarError).sum() -                 1.0/curVarVariance
        return [curGrad, curHess]
    else:
        # if it is categorical variable then use it as index
        if (typeOfVOIHash[var]== 'Dummy'):
            # if it is not base then just use it as index
            curGradVec = [0.0]* lenOfVOIHash[var]
            curHessVec = [0.0]* lenOfVOIHash[var]
            # to make  the following process more efficient, I will only pass through the whole
            #    pandas data frame once
            if float(sizeOfCurVar)/designMat.shape[0]>0.5:
                for i in range(0,designMat.shape[0]):
                    curDummyIndex = designMat.ix[i][var]
                    if (baseCaseHash[var]!=curDummyIndex):
                        curGradVec[curDummyIndex] += (1.0* float(designMat.ix[i]['rvError'])/VarError)
                        curHessVec[curDummyIndex] += (-(1.0**2)/VarError)
                    else:
                        pass
                # finally add back the prior portion
                # new feature for discounting
                for curDummyIndex in range(0,sizeOfCurVar):
                    if (baseCaseHash[var]!=curDummyIndex):
                        curGradVec[curDummyIndex]-= float(paramVector[var][curDummyIndex]-curVarMean)/curVarVariance* discountPriorOrder
                        curHessVec[curDummyIndex] -= 1.0/curVarVariance* discountPriorOrder
                    else:
                        pass
            else: # i.e. when the size is smaller
                for curDummyIndex in range(0,sizeOfCurVar):
                    # print('current index is: %s and the base index is: %s'%(curDummyIndex, baseCaseHash[var]))
                    if (baseCaseHash[var]!=curDummyIndex):
                        # first extract the rows with the current index
                        subDesignMat = designMat[designMat[var]==curDummyIndex]
                        # for this sub-design matrix we know that all dummy variables are one
                        curGradVec[curDummyIndex] = (1.0*(subDesignMat['rvError'].astype(float))/VarError).sum() -                                 float(paramVector[var][curDummyIndex]-curVarMean)/curVarVariance* discountPriorOrder
                        curHessVec[curDummyIndex] = (-(1.0**2)/VarError).sum() -                                 1.0/curVarVariance* discountPriorOrder
                    else: # if it is base then multiply it to zero (i.e. pass)
                        pass
            return [curGradVec, curHessVec]
        else: # i.e. when the variable is quantitative
            # if it is not categorical then use multiplication
            # print('quantitative param value is: %s'%float(paramVector[var]))
            # print('the design Matrix value is: %s'%float(designMatRow[var]))
            curGrad = (designMat[var]*(designMat['rvError'].astype(float))/VarError).sum() -                 float(paramVector[var]-curVarMean)/curVarVariance* discountPriorOrder
            curHess = (-(designMat[var]**2)/VarError).sum() -1.0/curVarVariance* discountPriorOrder
            return [curGrad, curHess]

			
# I need a neat mapping table between each variable in the dictionary and its location in the Matrix
# this way I can just use this mapping table to traverse the whole Matrix and take out elements at the end as well
# first build the full hessian Matrix with all off diagonal elements
# the challange is that I need to create the whole Matrix from the dictionary, then inverse it, get the diagonal
# and finally put back into the dictionary
lenOfVarCnt = -1
mappingParamMatrix = {}
#estimatedParamVecLogit,meanPriorLogitEst, varPriorLogitEst, DataPD,lenOfVOIHash,typeOfVOIHash, baseCaseHash
for variable in variablesOfIntrest:
    curLenOfVar = lenOfVOIHash[variable]
    print('creating the mapping for %s variable with size %s...'%(variable, curLenOfVar))
    mappingParamMatrix[variable] = [0]*curLenOfVar
    for i in range(0,curLenOfVar):
        if (typeOfVOIHash[variable]=='Dummy') and (baseCaseHash[variable]==i):
            pass
        else:
            lenOfVarCnt += 1
            mappingParamMatrix[variable][i] = lenOfVarCnt
			
			
def LogLikPosteriorHierarchLogit(estimatedParamVecLogit,meanPriorLogitEst, varPriorLogitEst, DataPD,                                 lenOfVOIHash,typeOfVOIHash, baseCaseHash):
    
    DataPD['logLikLogit'] = (DataPD.apply(lambda x:                                               logLike(x,estimatedParamVecLogit, typeOfVOIHash, baseCaseHash), axis=1))['logLik']
    # the posterior as a result is computed as follows:
    priorLogit =  prior(estimatedParamVecLogit,lenOfVOIHash, meanPriorLogitEst, varPriorLogitEst)
    logLikLogit = DataPD['logLikLogit'].sum()
    posterior = logLikLogit + priorLogit
    print('the likelihood was: %s'%logLikLogit)
    print('the prior was: %s'%priorLogit)
    print('the posterior is: %s'%posterior)
    return [priorLogit,logLikLogit,posterior]

# first write everything and run and then put into a function and run the function only
# this way tracking of errors might be easier
def HierarchLogit(DataPD,variablesOfIntrest,lenOfVOIHash,baseCaseHash,typeOfVOIHash,funcTol,maxIter):
    #----------------------
    # 1. First initialize the parameters
    #----------------------
    # parameter vector initialization which will be used for each update
    paramVectorLogit={}
    # also create the mean and variance vector for prior (except for Intercept for the rest)
    meanPriorLogit = {}
    varPriorLogit = {}
    print('Initializing the values')
    for variable in variablesOfIntrest:
        paramVectorLogit[variable] = createRandomParamVec(lenOfVOIHash[variable])
        print('Initializing variable %s with the size of vector of %s'%(variable,lenOfVOIHash[variable]))
        varPriorLogit[variable] = np.random.uniform(0, 40) 
        meanPriorLogit[variable] = np.random.uniform(-1, 1)
    print('the E-step will generate the following updated hierarchical prior:')
    updatePriorLogit = ExpectedHierPrior(paramVectorLogit,lenOfVOIHash, meanPriorLogit, varPriorLogit)
    meanPriorLogit   = copy.deepcopy(updatePriorLogit[0])
    varPriorLogit    = copy.deepcopy(updatePriorLogit[1])
    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    # 2. Iterate until convergence the following
    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    #for iter in range(1,maxIter):
    curChange = 1000
    # start with defining the log likelihood, prior and MAP
    modelSelectionLogit = LogLikPosteriorHierarchLogit(paramVectorLogit,meanPriorLogit, varPriorLogit,                                                    DataPD,lenOfVOIHash,typeOfVOIHash, baseCaseHash)
    logitPrior = modelSelectionLogit[0]
    logitLikelihood = modelSelectionLogit[1]
    logitPosterior = modelSelectionLogit[2]
    logitPosteriorOld = logitPosterior
    winnerVec = copy.deepcopy([paramVectorLogit,meanPriorLogit,varPriorLogit,logitPrior,logitLikelihood,logitPosterior])
    curIter = 0
    while curChange>funcTol and curIter<maxIter :
        curIter+=1
        print('iteration %s is started ...' %curIter)
        #-----------------------------------------------------
        #      2.0 Find the first prediction which will be used in Hessian and Gradient computation
        #-----------------------------------------------------
        print('computing the probabilities ...')
        DataPD['prob'] = (DataPD.apply(lambda x: prob(x,paramVectorLogit, typeOfVOIHash, baseCaseHash), axis=1))['prob']
        print('computing the probabilities ......... done')
        #-----------------------------------------------------
        #      2.1. Find the hessian and gradient vector
        #-----------------------------------------------------
        # first create the gradient and hessian vector like vector of parameters but initialize with zero
        gradVectorLogit={}
        hessVectorLogit = {}
        for variable in variablesOfIntrest:
            print('current variable under process for hessian and gradient is: %s'%variable)
            GradHessOutputLogit =                 GradHess(variable, paramVectorLogit, DataPD, typeOfVOIHash, baseCaseHash,                          lenOfVOIHash, meanPriorLogit, varPriorLogit)
            gradVectorLogit[variable] = GradHessOutputLogit[0]
            #[0.0]* lenOfVOIHash[variable]
            hessVectorLogit[variable] = GradHessOutputLogit[1]
            #[0.0]* lenOfVOIHash[variable]
        # print(gradVectorLogit)
        # print(hessVectorLogit)
        #-----------------------------------------------------
        #      2.2. Update the parameters based on hessian and gradient
        #-----------------------------------------------------
        # note: an alternative way is to use co-ordinate ascent so compute probability, hessian and gradient 
        #     after each update, but given that computing probability, gradient, and hessian are computationally intensive
        #     for now I will not use that structure
#         for variable in variablesOfIntrest:
            curLenOfVar = lenOfVOIHash[variable]
            for i in range(0, curLenOfVar):
                try:
                    paramVectorLogit[variable][i]+=float(lamdaLogit)/(maxIter-curIter+1)*                                                float(gradVectorLogit[variable][i])#\
                                   # /(math.fabs(hessVectorLogit[variable][i])+lamdaLogit)
                except: #when it is scalar
                    paramVectorLogit[variable][i]+=float(lamdaLogit)/(maxIter-curIter+1)*                                    float(gradVectorLogit[variable])#\
                                    #/(math.fabs(hessVectorLogit[variable])+lamdaLogit)
        #-----------------------------------------------------
        #      2.3. Run the Expectation to update the prior
        #-----------------------------------------------------
        # ***Note: Make sure I use a correct parameter vector
        print('the E-step will generate the following updated hierarchical prior:')
        updatePriorLogit = ExpectedHierPrior(paramVectorLogit,lenOfVOIHash, meanPriorLogit, varPriorLogit)
        meanPriorLogit   = copy.deepcopy(updatePriorLogit[0])
        varPriorLogit    = copy.deepcopy(updatePriorLogit[1])
        print('computing the E-step ................... done')
        # print the Maxium A Posteriori until this point
        print('computing the logLikelihood and posterior..')
        modelSelectionLogit = LogLikPosteriorHierarchLogit(paramVectorLogit,meanPriorLogit, varPriorLogit,                                                    DataPD,lenOfVOIHash,typeOfVOIHash, baseCaseHash)
        logitPrior = modelSelectionLogit[0]
        logitLikelihood = modelSelectionLogit[1]
        logitPosterior = modelSelectionLogit[2]
        curChange = math.fabs(logitPosterior - logitPosteriorOld)
        logitPosteriorOld = logitPosterior
        print('the current change in posterior is:%s'%curChange)
        if winnerVec[5]<logitPosterior:
            winnerVec = copy.deepcopy(                            [paramVectorLogit,meanPriorLogit,varPriorLogit,logitPrior,logitLikelihood,logitPosterior])
    print ('----------------------------------------------------------')
    print ('the winner summary is:')
    print ('----------------------------------------------------------')
    print('the likelihood at the end of this iteration is: %s'%winnerVec[4])
    print('the prior at the end of this iteration is: %s'%winnerVec[3])
    print('the posterior is: %s'%winnerVec[5])
    return winnerVec

def approxHessianComputationHierLogit(DataPD,variablesOfIntrest,lenOfVOIHash,baseCaseHash,typeOfVOIHash,                                     varPriorLogitEst):
    # full HessianLL and HessianLL-HessPrior computation
    #lenOfVarCnt, mappingParamMatrix
    numVars = lenOfVarCnt+1
    print('the number of variables is: %s'%numVars)
    approxFullHessianLogit = np.zeros((numVars,numVars))
    approxFullHessianLogitWPrior = np.zeros((numVars,numVars))
    # loop over var and var, and create full hessian Matrix
    for variable1 in variablesOfIntrest:
        typeOfVar1 = typeOfVOIHash[variable1]
        #lenOfVOIHash,baseCaseHash
        lenOfVar1 = lenOfVOIHash[variable1]
        print('the first variable for hessian computation is: %s'%(variable1))
        for Index1 in range(0,lenOfVar1):
            print '.',
            if typeOfVar1=="Dummy" and Index1==baseCaseHash[variable1]: # base is not in the Matrix
                pass
            else:
                firstIndex = mappingParamMatrix[variable1][Index1]  
                for variable2 in variablesOfIntrest:
                    #print('the second variable is: %s'%variable2)
                    typeOfVar2 = typeOfVOIHash[variable2]
                    lenOfVar2 = lenOfVOIHash[variable2]
                    for Index2 in range(0,lenOfVar2):
                        if typeOfVar2=="Dummy" and Index2==baseCaseHash[variable2]: # base is not in the Matrix
                            pass
                        else:
                            secondIndex = mappingParamMatrix[variable2][Index2]  
                            # compute the average (expectation) of hessian across all the observations
                            # use the 'prob' row for computation
                            # I need to create the x(ij)*x(ik) for items that this become non zero and then weight by the probability
                            # the division by N or number of samples can be done at the end
                            # if one of the variable1 or variable2 is dummy then check and if it is not equal to the base then use it
                            # as a subVector (so it is just condition to be checked for both variables and get sub-Matrix)
                            # I know that this value is one always if it is not zero for the dummy variables
                            # print('variable1 is: %s and variable2 is: %s'%(variable1, variable2))
                            # print('type of variable 1 is: %s and type of variable2 is: %s'%(typeOfVar1, typeOfVar2))
                            if variable1 == 'Intercept' or variable2 == 'Intercept':
                                #print('I am here')
                                if variable1 == 'Intercept' and variable2 == 'Intercept': 
                                    subMatrix = DataPD
                                    approxFullHessianLogit[firstIndex, secondIndex] =                                            (subMatrix['prob']*(1-subMatrix['prob'])).sum()
                                elif variable1 == 'Intercept':
                                    if typeOfVar2 == 'Dummy': # take submatrix with secondIndex
                                        subMatrix = DataPD[DataPD[variable2]==Index1]
                                        approxFullHessianLogit[firstIndex, secondIndex] =                                            (subMatrix['prob']*(1-subMatrix['prob'])).sum()
                                    else: # when the second variable is not dummy
                                        subMatrix = DataPD[DataPD[variable2]==Index1]
                                        approxFullHessianLogit[firstIndex, secondIndex] =                                             (subMatrix['prob']*(1-subMatrix['prob'])*subMatrix[variable2]).sum()
                                elif variable2 == 'Intercept':
                                    if typeOfVar1 == 'Dummy':
                                        subMatrix = DataPD[DataPD[variable1]==Index1]
                                        approxFullHessianLogit[firstIndex, secondIndex] =                                             (subMatrix['prob']*(1-subMatrix['prob'])).sum()
                                    else: # when the first variable is not dummy
                                        approxFullHessianLogit[firstIndex, secondIndex] =                                             (DataPD['prob']*(1-DataPD['prob'])*DataPD[variable1]).sum()
                                else: # we will never be here
                                    pass
                            else:#i.e. when it is not intercept
                                if typeOfVar1 == 'Dummy' and typeOfVar2 == 'Dummy':
                                        subMatrix = DataPD[(DataPD[variable1]==Index1) &                                                            (DataPD[variable2]==Index2)]
                                        approxFullHessianLogit[firstIndex, secondIndex] =(subMatrix['prob']*                                                                                          (1-subMatrix['prob'])).sum()
                                elif typeOfVar1 == 'Dummy': # it means the second one is not dummy variable
                                    subMatrix = DataPD[DataPD[variable1]==Index1]
                                    approxFullHessianLogit[firstIndex, secondIndex] =                                                 (subMatrix['prob']*(1-subMatrix['prob'])*subMatrix[variable2]).sum()
                                elif typeOfVar2 == 'Dummy': # it means the first variable is not dummy
                                    subMatrix = DataPD[DataPD[variable2]==Index2]
                                    approxFullHessianLogit[firstIndex, secondIndex] =                                                 (subMatrix['prob']*(1-subMatrix['prob'])*subMatrix[variable1]).sum()
                                else: # when both variables are not dummy
                                    approxFullHessianLogit[firstIndex, secondIndex] = (DataPD['prob']*                                                (1-DataPD['prob'])*DataPD[variable1]*DataPD[variable2]).sum()
                            # now create the withPrior value for the MAP SE computation
                            if firstIndex == secondIndex:
                                approxFullHessianLogitWPrior[firstIndex, secondIndex] =                                    approxFullHessianLogit[firstIndex, secondIndex]+1.0/varPriorLogitEst[variable2]
                            else: 
                                # only if firstIndex and second index are equal b/c there is no interactive prior
                                # given the mean and var of the prior
                                approxFullHessianLogitWPrior[firstIndex, secondIndex] =                                            approxFullHessianLogit[firstIndex, secondIndex]
    return [approxFullHessianLogit,approxFullHessianLogitWPrior]


def inferenceHierLogit(approxFullHessianLogit,estimatedParamVecLogit,DataPD,variablesOfIntrest,lenOfVOIHash,baseCaseHash,typeOfVOIHash,                       varPriorLogitEst): # update to use varPriorRegEst for 
    from numpy.linalg import pinv
    print('not dividing by sample size anymore')
    # prvious case for LL only
    #STELogit = np.sqrt(np.diag(pinv(approxFullHessianLogit)))* (1.0/np.sqrt(approxFullHessianLogit.shape[0]))
    # for MAP based on Psychometrica paper
    print('starting to compute the STE of logit')
    #(1.0/np.sqrt(approxFullHessianLogit[0].shape[0]))*\
    STELogit = np.sqrt(np.fabs(np.diag(approxFullHessianLogit[0])))*                np.fabs(np.diag(pinv(approxFullHessianLogit[1])))
    #print('standard error is: %s'%STELogit)
    # the t-stat is:
    #  t-stat = param./STE
    tStatLogit = {}
    print('starting to compute the the t-stat of logit')
    for variable in variablesOfIntrest:
        print('current variable for t-stat computation is %s'%variable)
        curLenOfVar = lenOfVOIHash[variable]
        tStatLogit[variable] = [0]*curLenOfVar
        for i in range(0,curLenOfVar):
            print '.',
            if i==baseCaseHash[variable]:
                pass
            else:
                curVarMatrixIndex = mappingParamMatrix[variable][i]
                curSTE = STELogit[curVarMatrixIndex]
                tStatLogit[variable][i] = float(estimatedParamVecLogit[variable][i])/(curSTE+1e-15)
    return [estimatedParamVecLogit,approxFullHessianLogit,STELogit,tStatLogit]
	

lamdaLogit = 0.001
nIterLogit = 100

estimatedParamVecLogit = estimatedParamLogit[0]
meanPriorLogitEst = estimatedParamLogit[1]
varPriorLogitEst = estimatedParamLogit[2]
logitPriorOptEst = estimatedParamLogit[3]
logitLikelihoodOptEst = estimatedParamLogit[4]
logitPosteriorOptEst = estimatedParamLogit[5]

# test the health of result (not immutable object but deep copy)
modelSelectionLogit = LogLikPosteriorHierarchLogit(estimatedParamVecLogit,meanPriorLogitEst, varPriorLogitEst,                                                    samplePD,lenOfVOIHash,typeOfVOIHash, baseCaseHash)
logitPrior = modelSelectionLogit[0]
logitLikelihood = modelSelectionLogit[1]
logitPosterior = modelSelectionLogit[2]
print(modelSelectionLogit)
print([logitPriorOptEst,logitLikelihoodOptEst,logitPosteriorOptEst])

# estimate predicted  probabilities based on the estimated parameters to be used later on for hessian and grad comp.
samplePD['prob'] = (samplePD.apply(lambda x: prob(x,estimatedParamVecLogit, typeOfVOIHash, baseCaseHash), axis=1))['prob']


# compute the t-stat of Logit
logitInferenceResult = inferenceHierLogit(approxFullHessianLogit,estimatedParamVecLogit,                                          samplePD,variablesOfIntrest,lenOfVOIHash,baseCaseHash,typeOfVOIHash,                                         varPriorLogitEst)
#estimatedParamVecLogit = logitInferenceResult[0]
approxFullHessianLogit = logitInferenceResult[1]
STELogit = logitInferenceResult[2]
tStatLogit  = logitInferenceResult[3] 


# compute Hessian of Logit
approxFullHessianLogit = approxHessianComputationHierLogit(samplePD,                                                    variablesOfIntrest,lenOfVOIHash,baseCaseHash,typeOfVOIHash,                                                              varPriorLogitEst)

# compute the t-stat of Logit
logitInferenceResult = inferenceHierLogit(approxFullHessianLogit,estimatedParamVecLogit,                                          samplePD,variablesOfIntrest,lenOfVOIHash,baseCaseHash,typeOfVOIHash,                                         varPriorLogitEst)
#estimatedParamVecLogit = logitInferenceResult[0]
approxFullHessianLogit = logitInferenceResult[1]
STELogit = logitInferenceResult[2]
tStatLogit  = logitInferenceResult[3] 

import copy
def LogLikPosteriorHierarchReg(estimatedParamVecReg,meanPriorRegEst, varPriorRegEst, DataPDRegInput,                               lenOfVOIHash,typeOfVOIHash, baseCaseHash, VarError):
    # first compute the prediction and the error
    DataPDRegInput['RegPred'] = (DataPDRegInput.apply(lambda x: RegPred(x,estimatedParamVecReg, typeOfVOIHash, baseCaseHash), axis=1))['RegPred']
    # write a function to compute the variance of error in the regression
    # first compute the error per item, and then compute the standard deviation of the error and square it
    DataPDRegInput['rvError'] = DataPDRegInput['r'] - DataPDRegInput['RegPred']
    DataPDRegInput['logLikReg'] = (DataPDRegInput.apply(lambda x: logLikeGaussrv(x,VarError), axis=1))['logLikrv']
    # the posterior as a result is computed as follows:
    priorReg = prior(estimatedParamVecReg,lenOfVOIHash, meanPriorRegEst, varPriorRegEst)
    logLikReg = DataPDRegInput['logLikReg'].sum()
    posteriorReg = logLikReg + priorReg
    print('the likelihood was: %s'%logLikReg)
    print('the prior was: %s'%priorReg)
    print('the posterior is: %s'%posteriorReg)
    return [priorReg,logLikReg,posteriorReg]

# first write everything and run and then put into a function and run the function only
# this way tracking of errors might be easier
def HierarchReg(DataPDRegInput,variablesOfIntrest,lenOfVOIHash,baseCaseHash,typeOfVOIHash,funcTol,maxIter):
    #----------------------
    # 1. First initialize the parameters
    #----------------------
    # parameter vector initialization which will be used for each update
    paramVectorReg={}
    # also create the mean and variance vector for prior (except for Intercept for the rest)
    meanPriorReg = {}
    varPriorReg = {}
    print('Initializing the values ...')
    for variable in variablesOfIntrest:
        paramVectorReg[variable] = createRandomParamVec(lenOfVOIHash[variable])
        print('Initializing variable %s with the size of vector of %s'%(variable,lenOfVOIHash[variable]))
        varPriorReg[variable] = np.random.uniform(0, 40) 
        meanPriorReg[variable] = np.random.uniform(-1, 1)
    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    # 2. Iterate until convergence the following
    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    print('the E-step will generate the following updated hierarchical prior:')
    updatePriorReg = ExpectedHierPrior(paramVectorReg,lenOfVOIHash, meanPriorReg, varPriorReg)
    meanPriorReg   = copy.deepcopy(updatePriorReg[0])
    varPriorReg    = copy.deepcopy(updatePriorReg[1])
    print('computing the E-step ................... done')
    #for iter in range(1,maxIter):
    curChange = 1000
    # start with defining the log likelihood, prior and MAP
    DataPDRegInput['RegPred'] = (DataPDRegInput.apply(lambda x: RegPred(x,paramVectorReg, typeOfVOIHash, baseCaseHash), axis=1))['RegPred']
    # write a function to compute the variance of error in the regression
    # first compute the error per item, and then compute the standard deviation of the error and square it
    DataPDRegInput['rvError'] = DataPDRegInput['r'] - DataPDRegInput['RegPred']
    # compute the standard deviation of the error and square for an estimation to SigmaSquare of Error
    VarError = np.mean(DataPDRegInput['rvError']**2)
    modelSelectionReg = LogLikPosteriorHierarchReg(paramVectorReg,meanPriorReg, varPriorReg, DataPDRegInput,                               lenOfVOIHash,typeOfVOIHash, baseCaseHash, VarError)
    RegPrior = modelSelectionReg[0]
    RegLikelihood = modelSelectionReg[1]
    RegPosterior = modelSelectionReg[2]
    RegPosteriorOld = RegPosterior
#     print('var prior vector was:')
#     print(varPriorReg)
    print ('Initialization phase ............................. done')
    curIter = 0
    winnerVec = copy.deepcopy([paramVectorReg,meanPriorReg,varPriorReg,RegPrior,RegLikelihood,RegPosterior])
    while curChange>funcTol and curIter<maxIter :
        curIter+=1
        print('iteration %s is started ...' %curIter)
        # # new feature to not allow the prior to weigh more than 1/10 of likelihood
        # priorOrder = math.log(math.fabs(RegPrior),10)
        # RegLikelihoodOrder = math.log(math.fabs(RegLikelihood),10)
        # if priorOrder>(RegLikelihoodOrder -1):
        #     discountPriorOrder =10**(RegLikelihoodOrder-1-priorOrder)
        # else:
        #     discountPriorOrder = 1
        # print('prior will be discounted by %s'%discountPriorOrder)
        # the approach didn't work so it is bypassed
        discountPriorOrder = 1.0
        #-----------------------------------------------------
        #      2.0 Find the first prediction which will be used in Hessian and Gradient computation
        #-----------------------------------------------------
        print('computing the regression prediction ...')
        # find the prediction for the Regression
        DataPDRegInput['RegPred'] = (DataPDRegInput.apply(lambda x: RegPred(x,paramVectorReg, typeOfVOIHash, baseCaseHash), axis=1))['RegPred']
        # write a function to compute the variance of error in the regression
        # first compute the error per item, and then compute the standard deviation of the error and square it
        DataPDRegInput['rvError'] = DataPDRegInput['r'] - DataPDRegInput['RegPred']
        # compute the standard deviation of the error and square for an estimation to SigmaSquare of Error
        # new update, to be robust to the outlier, use the median rather than mean
        # http://www.robots.ox.ac.uk/~fwood/teaching/W4315_Fall2011/Lectures/lecture_3/lecture_3.pdf
        n = float(DataPDRegInput.shape[0])
        VarError = np.mean(DataPDRegInput['rvError']**2)*(n/(n-2))
        print('computing the regression prediction ......... done')
        print('the variance of the error estimated was: %s'%VarError)
        #-----------------------------------------------------
        #      2.1. Find the hessian and gradient vector
        #-----------------------------------------------------
        # first create the gradient and hessian vector like vector of parameters but initialize with zero
        # for r and regression
        gradVectorrvReg={}
        hessVectorrvReg = {}
        for variable in variablesOfIntrest:
            print('current variable under process for grad and hessian rv Reg is: %s'%variable)
            GradHessOutputRegrv =                 GradHessHRegrv(variable, paramVectorReg, DataPDRegInput, typeOfVOIHash, baseCaseHash, lenOfVOIHash,                                 meanPriorReg, varPriorReg, VarError, discountPriorOrder)
            gradVectorrvReg[variable] = GradHessOutputRegrv[0]
            #[0.0]* lenOfVOIHash[variable]
            hessVectorrvReg[variable] = GradHessOutputRegrv[1]
            #[0.0]* lenOfVOIHash[variable]
        # print(gradVectorrvReg)
        # print(hessVectorrvReg)
        #-----------------------------------------------------
        #      2.2. Update the parameters based on hessian and gradient
        #-----------------------------------------------------
        # note: an alternative way is to use co-ordinate ascent so compute probability, hessian and gradient 
        #     after each update, but given that computing probability, gradient, and hessian are computationally intensive
        #     for now I will not use that structure
#        for variable in variablesOfIntrest:
            curLenOfVar = lenOfVOIHash[variable]
            for i in range(0, curLenOfVar):
                try:
                    paramVectorReg[variable][i]+=float(lamdaReg)/(maxIter-curIter+1)* float(gradVectorrvReg[variable][i]) #\
                                        #/(math.fabs(hessVectorrvReg[variable][i])+lamdaReg*1.0/(maxIter-curIter))
                except: #when it is scalar
                    paramVectorReg[variable][i]+= float(lamdaReg)/(maxIter-curIter+1)* float(gradVectorrvReg[variable]) #\
                                   # /(math.fabs(hessVectorrvReg[variable])+lamdaReg*1.0/(maxIter-curIter))
        #-----------------------------------------------------
        #      2.3. Run the Expectation to update the prior
        #-----------------------------------------------------
        # ***Note: Make sure I use a correct parameter vector
        print('the E-step will generate the following updated hierarchical prior:')
        updatePriorReg = ExpectedHierPrior(paramVectorReg,lenOfVOIHash, meanPriorReg, varPriorReg)
        meanPriorReg   = copy.deepcopy(updatePriorReg[0])
        varPriorReg    = copy.deepcopy(updatePriorReg[1])
        print('computing the E-step ................... done')
        # print the Maxium A Posteriori until this point
        print('computing the logLikelihood and posterior..')
        print('computing the regression prediction ...')
        # find the prediction for the Regression
        DataPDRegInput['RegPred'] = (DataPDRegInput.apply(lambda x: RegPred(x,paramVectorReg, typeOfVOIHash, baseCaseHash), axis=1))['RegPred']
        # write a function to compute the variance of error in the regression
        # first compute the error per item, and then compute the standard deviation of the error and square it
        DataPDRegInput['rvError'] = DataPDRegInput['r'] - DataPDRegInput['RegPred']
        # compute the standard deviation of the error and square for an estimation to SigmaSquare of Error
        VarError = np.mean(DataPDRegInput['rvError']**2)
        print('computing the regression prediction ......... done')
        modelSelectionReg = LogLikPosteriorHierarchReg(paramVectorReg,meanPriorReg, varPriorReg, DataPDRegInput,                               lenOfVOIHash,typeOfVOIHash, baseCaseHash, VarError)
        RegPrior = modelSelectionReg[0]
        RegLikelihood = modelSelectionReg[1]
        RegPosterior = modelSelectionReg[2]
        curChange = math.fabs(RegPosterior - RegPosteriorOld)
        print('the change in the posterior is: %s'%curChange)
        RegPosteriorOld = RegPosterior
        if winnerVec[5]<RegPosterior:
            winnerVec = copy.deepcopy([paramVectorReg,meanPriorReg,varPriorReg,RegPrior,RegLikelihood,RegPosterior])
#             print('var prior vector was:')
#             print(varPriorReg)
    print ('----------------------------------------------------------')
    print ('the winner summary is:')
    print ('----------------------------------------------------------')
    print('the likelihood at the end of this iteration is: %s'%winnerVec[4])
    print('the prior at the end of this iteration is: %s'%winnerVec[3])
    print('the posterior is: %s'%winnerVec[5])
#     print('the mean prior vector is:')
#     print(winnerVec[1])
    return winnerVec
	
	
def approxHessianComputationHierReg(DataPD,variablesOfIntrest,lenOfVOIHash,baseCaseHash,typeOfVOIHash,                                   varPriorRegEst, VarError):
    numVars = lenOfVarCnt+1
    print('the number of variables is: %s'%numVars)
    approxFullHessianReg = np.zeros((numVars,numVars))
    approxFullHessianRegWPrior = np.zeros((numVars,numVars))
    # loop over var and var, and create full hessian Matrix
    for variable1 in variablesOfIntrest:
        typeOfVar1 = typeOfVOIHash[variable1]
        #lenOfVOIHash,baseCaseHash
        lenOfVar1 = lenOfVOIHash[variable1]
        print('the first variable for hessian computation is: %s'%(variable1))
        for Index1 in range(0,lenOfVar1):
            print '.',
            if typeOfVar1=="Dummy" and Index1==baseCaseHash[variable1]: # base is not in the Matrix
                pass
            else:
                firstIndex = mappingParamMatrix[variable1][Index1]  
                for variable2 in variablesOfIntrest:
                    #print('the second variable is: %s'%variable2)
                    typeOfVar2 = typeOfVOIHash[variable2]
                    lenOfVar2 = lenOfVOIHash[variable2]
                    for Index2 in range(0,lenOfVar2):
                        if typeOfVar2=="Dummy" and Index2==baseCaseHash[variable2]: # base is not in the Matrix
                            pass
                        else:
                            secondIndex = mappingParamMatrix[variable2][Index2]  
                            if variable1 == 'Intercept' or variable2 == 'Intercept':
                                #print('I am here')
                                if variable1 == 'Intercept' and variable2 == 'Intercept': 
                                    subMatrix = DataPD
                                    approxFullHessianReg[firstIndex, secondIndex] =                                            subMatrix.shape[0]/VarError # as it is sum of square divided by VarError
                                elif variable1 == 'Intercept':
                                    if typeOfVar2 == 'Dummy': # take submatrix with secondIndex
                                        subMatrix = DataPD[DataPD[variable2]==Index1]
                                        approxFullHessianReg[firstIndex, secondIndex] =                                            subMatrix.shape[0]/VarError
                                    else: # when the second variable is not dummy
                                        subMatrix = DataPD[DataPD[variable2]==Index1]
                                        approxFullHessianReg[firstIndex, secondIndex] =                                             (subMatrix[variable2]).sum()/VarError
                                elif variable2 == 'Intercept':
                                    if typeOfVar1 == 'Dummy':
                                        subMatrix = DataPD[DataPD[variable1]==Index1]
                                        approxFullHessianReg[firstIndex, secondIndex] =                                             subMatrix.shape[0]/VarError
                                    else: # when the first variable is not dummy
                                        approxFullHessianReg[firstIndex, secondIndex] =                                             (DataPD[variable1]).sum()/VarError
                                else: # we will never be here
                                    pass
                            else:#i.e. when it is not intercept
                                if typeOfVar1 == 'Dummy' and typeOfVar2 == 'Dummy':
                                        subMatrix = DataPD[(DataPD[variable1]==Index1) &                                                            (DataPD[variable2]==Index2)]
                                        approxFullHessianReg[firstIndex, secondIndex] =subMatrix.shape[0]/VarError
                                elif typeOfVar1 == 'Dummy': # it means the second one is not dummy variable
                                    subMatrix = DataPD[DataPD[variable1]==Index1]
                                    approxFullHessianReg[firstIndex, secondIndex] =                                                 (subMatrix[variable2]).sum()/VarError
                                elif typeOfVar2 == 'Dummy': # it means the first variable is not dummy
                                    subMatrix = DataPD[DataPD[variable2]==Index2]
                                    approxFullHessianReg[firstIndex, secondIndex] =                                                 (subMatrix[variable1]).sum()/VarError
                                else: # when both variables are not dummy
                                    approxFullHessianReg[firstIndex, secondIndex] = (                                                            DataPD[variable1]*DataPD[variable2]).sum()/VarError
                            # now create the withPrior value for the MAP SE computation
                            if firstIndex == secondIndex:
                                approxFullHessianRegWPrior[firstIndex, secondIndex] =                                    approxFullHessianReg[firstIndex, secondIndex]+1.0/varPriorLogitEst[variable2]
                            else: 
                                # only if firstIndex and second index are equal b/c there is no interactive prior
                                # given the mean and var of the prior
                                approxFullHessianRegWPrior[firstIndex, secondIndex] =                                            approxFullHessianReg[firstIndex, secondIndex]
    return [approxFullHessianReg,approxFullHessianRegWPrior]

	
	
def inferenceHierReg(estimatedParamVecReg,DataPD,variablesOfIntrest,lenOfVOIHash,baseCaseHash,typeOfVOIHash,                                   varPriorRegEst, VarError): # update to use varPriorRegEst for random effects greater than one
    print('not dividing by sample size anymore')
    print('starting to compute the STE of Regression')
    approxFullHessianReg = approxHessianComputationHierReg(DataPD,              variablesOfIntrest,lenOfVOIHash,baseCaseHash,typeOfVOIHash,                                                           varPriorRegEst, VarError)
    from numpy.linalg import pinv
    # for MAP based on Psychometrica paper
    print('starting to compute the STE of Regression')
#     STEReg = np.sqrt(np.diag((DataPD['rvError']**2).sum()*pinv(approxFullHessianReg)))\
#                                     * (1.0/np.sqrt(approxFullHessianReg.shape[0]))
    STEReg = np.sqrt(np.fabs(np.diag(approxFullHessianReg[0])))*                np.fabs(np.diag(pinv(approxFullHessianReg[1])))
    #print('standard error is: %s'%STE)
    # the t-stat is:
    #  t-stat = param./STE
    tStatReg = {}
    print('starting to compute the the t-stat of Regression')
    for variable in variablesOfIntrest:
        print('current variable for t-stat computation is %s'%variable)
        curLenOfVar = lenOfVOIHash[variable]
        tStatReg[variable] = [0]*curLenOfVar
        for i in range(0,curLenOfVar):
            print '.',
            if i==baseCaseHash[variable]:
                pass
            else:
                curVarMatrixIndex = mappingParamMatrix[variable][i]
                curSTE = STEReg[curVarMatrixIndex]
                tStatReg[variable][i] = float(estimatedParamVecReg[variable][i])/(curSTE+1e-15)
    return [estimatedParamVecReg,approxFullHessianReg,STEReg,tStatReg]

	
# estimate predicted  probabilities based on the estimated parameters to be used later on for hessian and grad comp.
estimatedParamVecReg = estimatedParamReg[0]
meanPriorRegEst = estimatedParamReg[1]
varPriorRegEst = estimatedParamReg[2]
RegPriorOptEst = estimatedParamReg[3]
RegLikelihoodOptEst = estimatedParamReg[4]
RegPosteriorOptEst = estimatedParamReg[5]
#estimatedParamReg
samplePDReg['RegPred'] = (samplePDReg.apply(lambda x: RegPred(x,estimatedParamVecReg, typeOfVOIHash, baseCaseHash), axis=1))['RegPred']
# write a function to compute the variance of error in the regression
# first compute the error per item, and then compute the standard deviation of the error and square it
samplePDReg['rvError'] = samplePDReg['r'] - samplePDReg['RegPred']
# compute the standard deviation of the error and square for an estimation to SigmaSquare of Error
VarError = np.mean(samplePDReg['rvError']**2)*(n/(n-2))
modelSelectionReg = LogLikPosteriorHierarchReg(estimatedParamVecReg,meanPriorRegEst, varPriorRegEst, samplePDReg,                               lenOfVOIHash,typeOfVOIHash, baseCaseHash, VarError)
RegPrior = modelSelectionReg[0]
RegLikelihood = modelSelectionReg[1]
RegPosterior = modelSelectionReg[2]
print(modelSelectionReg)
print([RegPriorOptEst,RegLikelihoodOptEst,RegPosteriorOptEst])

# check gradient and hessian range to adjust the correct lambda
# for r and regression
# write a function to compute the variance of error in the regression
# first compute the error per item, and then compute the standard deviation of the error and square it
samplePDReg['rvError'] = samplePDReg['r'] - samplePDReg['RegPred']
VarError = np.mean(samplePDReg['rvError']**2)
gradVectorrvReg={}
hessVectorrvReg = {}
for variable in variablesOfIntrest:
    print('current variable under process for grad and hessian rv Reg is: %s'%variable)
    GradHessOutputRegrv =         GradHessHRegrv(variable, paramVector, samplePDReg, typeOfVOIHash, baseCaseHash, lenOfVOIHash,                         meanPrior, varPrior, VarError,1)
    gradVectorrvReg[variable] = GradHessOutputRegrv[0]
    #[0.0]* lenOfVOIHash[variable]
    hessVectorrvReg[variable] = GradHessOutputRegrv[1]
    #[0.0]* lenOfVOIHash[variable]
	
	
# estimate predicted  probabilities based on the estimated parameters to be used later on for hessian and grad comp.
estimatedParamVecReg = estimatedParamReg[0]
meanPriorRegEst = estimatedParamReg[1]
varPriorRegEst = estimatedParamReg[2]
RegPriorOptEst = estimatedParamReg[3]
RegLikelihoodOptEst = estimatedParamReg[4]
RegPosteriorOptEst = estimatedParamReg[5]

print('computing the regression prediction ...')
# find the prediction for the Regression
samplePDReg['RegPred'] = (samplePDReg.apply(lambda x: RegPred(x,estimatedParamVecReg,                                                     typeOfVOIHash, baseCaseHash), axis=1))['RegPred']
# write a function to compute the variance of error in the regression
# first compute the error per item, and then compute the standard deviation of the error and square it
samplePDReg['rvError'] = samplePDReg['r'] - samplePDReg['RegPred']
# compute the standard deviation of the error and square for an estimation to SigmaSquare of Error
#http://www.robots.ox.ac.uk/~fwood/teaching/W4315_Fall2011/Lectures/lecture_3/lecture_3.pdf
n = samplePDReg.shape[0]
VarError = np.mean(samplePDReg['rvError']**2)*float(n)/(n-2)
print('computing the regression prediction ......... done')

RegInferenceResult = inferenceHierReg(estimatedParamVecReg,samplePDReg,variablesOfIntrest,                                        lenOfVOIHash,baseCaseHash,typeOfVOIHash, varPriorRegEst, VarError)
#estimatedParamVecReg = RegInferenceResult[0]
approxFullHessianReg = RegInferenceResult[1]
STEReg = RegInferenceResult[2]
tStatReg  = RegInferenceResult[3] 

def tStatInfNintyFive(ConvTStat, rvTStat):
    if ConvTStat>1.96:
        curSig95PCTConversion = 1
    elif ConvTStat<-1.96:
        curSig95PCTConversion = -1
    else:
        curSig95PCTConversion = 0
    if rvTStat>1.96:
        curSig95PCTAOR = 1
    elif rvTStat<-1.96:
        curSig95PCTAOR = -1
    else:
        curSig95PCTAOR = 0
    # using the logic above
    if curSig95PCTConversion==1 and curSig95PCTConversion==1:
        tStatSig95r = 1
    elif curSig95PCTConversion==0 and curSig95PCTConversion==1:
        tStatSig95r = 1
    elif curSig95PCTConversion==1 and curSig95PCTConversion==0:
        tStatSig95r = 1
    elif curSig95PCTConversion==-1 and curSig95PCTConversion==-1:
        tStatSig95r = -1
    elif curSig95PCTConversion==0 and curSig95PCTConversion==-1:
        tStatSig95r = -1
    elif curSig95PCTConversion==-1 and curSig95PCTConversion==0:
        tStatSig95r = -1
    else:
        tStatSig95r = 0
    return [curSig95PCTConversion,curSig95PCTAOR,tStatSig95r]
	
"""
Box plot: a convenient way to display series as box with whiskers and outliers
Different types are available throught the box_mode option
"""

from __future__ import division

from bisect import bisect_left, bisect_right

from pygal.graph.graph import Graph
from pygal.util import alter, decorate


class BoxExtended(pygal.Box):
    @staticmethod
    def _box_points(values, mode='extremes'):
        """
        Default mode: (mode='extremes' or unset)
            Return a 7-tuple of 2x minimum, Q1, Median, Q3,
        and 2x maximum for a list of numeric values.
        1.5IQR mode: (mode='1.5IQR')
            Return a 7-tuple of min, Q1 - 1.5 * IQR, Q1, Median, Q3,
        Q3 + 1.5 * IQR and max for a list of numeric values.
        Tukey mode: (mode='tukey')
            Return a 7-tuple of min, q[0..4], max and a list of outliers
        Outliers are considered values x: x < q1 - IQR or x > q3 + IQR
        SD mode: (mode='stdev')
            Return a 7-tuple of min, q[0..4], max and a list of outliers
        Outliers are considered values x: x < q2 - SD or x > q2 + SD
        SDp mode: (mode='pstdev')
            Return a 7-tuple of min, q[0..4], max and a list of outliers
        Outliers are considered values x: x < q2 - SDp or x > q2 + SDp

        The iterator values may include None values.

        Uses quartile definition from  Mendenhall, W. and
        Sincich, T. L. Statistics for Engineering and the
        Sciences, 4th ed. Prentice-Hall, 1995.
        """
        def median(seq):
            n = len(seq)
            if n % 2 == 0:  # seq has an even length
                return (seq[n // 2] + seq[n // 2 - 1]) / 2
            else:  # seq has an odd length
                return seq[n // 2]

        def mean(seq):
            return sum(seq) / len(seq)

        def stdev(seq):
            m = mean(seq)
            l = len(seq)
            v = sum((n - m)**2 for n in seq) / (l - 1)  # variance
            return v**0.5  # sqrt

        def pstdev(seq):
            m = mean(seq)
            l = len(seq)
            v = sum((n - m)**2 for n in seq) / l  # variance
            return v**0.5  # sqrt

        outliers = []
        # sort the copy in case the originals must stay in original order
        s = sorted([x for x in values if x is not None])
        n = len(s)
        if not n:
            return (0, 0, 0, 0, 0, 0, 0), []
        elif n == 1:
            return (s[0], s[0], s[0], s[0], s[0], s[0], s[0]), []
        else:
            q2 = median(s)
            # See 'Method 3' in http://en.wikipedia.org/wiki/Quartile
            if n % 2 == 0:  # even
                q0 = np.percentile(s, 2.5)
                q1 = median(s[:n // 2])
                q3 = median(s[n // 2:])
                q4 = np.percentile(s, 97.5)
            else:  # odd
                if n == 1:  # special case
                    q0 = s[0]
                    q1 = s[0]
                    q3 = s[0]
                    q4 = s[0]
                elif n % 4 == 1:  # n is of form 4n + 1 where n >= 1
                    m = (n - 1) // 4
                    q0 = np.percentile(s, 2.5)
                    q1 = 0.25 * s[m - 1] + 0.75 * s[m]
                    q3 = 0.75 * s[3 * m] + 0.25 * s[3 * m + 1]
                    q4 = np.percentile(s, 97.5)
                else:  # n is of form 4n + 3 where n >= 1
                    m = (n - 3) // 4
                    q0 = np.percentile(s, 2.5)
                    q1 = 0.75 * s[m] + 0.25 * s[m + 1]
                    q3 = 0.25 * s[3 * m + 1] + 0.75 * s[3 * m + 2]
                    q4 = np.percentile(s, 97.5)

            iqr = q3 - q1
            min_s = np.percentile(s, 2.5)#s[0]
            max_s = np.percentile(s, 97.5)#s[-1]
#             if mode == 'extremes':
#                 q0 = min_s
#                 q4 = max_s
#             elif mode == 'tukey':
#                 # the lowest datum still within 1.5 IQR of the lower quartile,
#                 # and the highest datum still within 1.5 IQR of the upper
#                 # quartile [Tukey box plot, Wikipedia ]
#                 b0 = bisect_left(s, q1 - 1.5 * iqr)
#                 b4 = bisect_right(s, q3 + 1.5 * iqr)
#                 q0 = s[b0]
#                 q4 = s[b4 - 1]
#                 outliers = s[:b0] + s[b4:]
#             elif mode == 'stdev':
#                 # one standard deviation above and below the mean of the data
#                 sd = stdev(s)
#                 b0 = bisect_left(s, q2 - sd)
#                 b4 = bisect_right(s, q2 + sd)
#                 q0 = s[b0]
#                 q4 = s[b4 - 1]
#                 outliers = s[:b0] + s[b4:]
#             elif mode == 'pstdev':
#                 # one population standard deviation above and below
#                 # the mean of the data
#                 sdp = pstdev(s)
#                 b0 = bisect_left(s, q2 - sdp)
#                 b4 = bisect_right(s, q2 + sdp)
#                 q0 = s[b0]
#                 q4 = s[b4 - 1]
#                 outliers = s[:b0] + s[b4:]
#             elif mode == '1.5IQR':
#                 # 1.5IQR mode
#                 q0 = q1 - 1.5 * iqr
#                 q4 = q3 + 1.5 * iqr
            return (min_s, q0, q1, q2, q3, q4, max_s), outliers

def save_obj(obj, name, experimName ):
    with open('obj/%s/'%experimName+ name + '.pkl', 'wb') as f:
        pickle.dump(obj, f, pickle.HIGHEST_PROTOCOL)

def load_obj(name, experimName ):
    with open('obj/%s/'%experimName + name + '.pkl', 'rb') as f:
        return pickle.load(f)

# importing the libraries
from dateutil import parser
import numpy as np
import pandas as pd
import inspect
# all the required imports in this notebook
#-----------------------------
import os
import datetime
from json import loads
import os
import logutils
import matplotlib.pyplot as plt
#import seaborn as sns
# import pandas as pd
# from ggplot import *
# import pandas as pd
import numpy as np
import datetime
from scipy.sparse import csc_matrix

# define the model parameters vectors actual and prior [Think in generative mode rather than estimation mode]
# define the prior portion of the model as well
#----------------------------------------
from edward.models import Normal
from edward.models import Gamma
from edward.models import InverseGamma
TFVarsLogitParam = {}
TFVarsLogitParamPriorMean = {}
TFVarsLogitParamPriorVar = {}
# prior for the error of the hierarchical model is taken from the following paper as vague prior
#http://www.stat.columbia.edu/~gelman/research/published/taumain.pdf
# consistent with the following:
# https://fisher.osu.edu/~schroeder.9/AMIS900/ech6.pdf
# https://www.stat.auckland.ac.nz/~millar/Bayesian/Handouts/Ch7WinBUGS
for variable1 in variablesOfIntrest:
    # removed the following portion b/c I have to think generative not estimation (i.e. forward not backward)
    #curmean, curvar = tf.nn.moments(TFVarsLogitParam[variable1],axes=[1])
    # prior on the variance of the parameters (hyper parameters)
    # define the prior of the model
    #--------------------------------
    alpha = 0.001
    beta = 0.001
    varPrior = 5 # for individual specific parameters, this is pretty vague (wide) prior
    #alpha/beta is the mean of the gamma distribution
    # I have to generate from gamma distribution, then invert to get inverse gamma
    TFVarsLogitParamPriorVar[variable1] = InverseGamma(alpha=tf.ones(1)*alpha,beta=tf.ones(1)*beta)
    # the variance here should be the sum of prior precision and the data precision
    TFVarsLogitParamPriorMean[variable1] = Normal(mu=tf.zeros(1),                                              sigma=tf.ones(1)*varPrior)
    # the individual specific parameters
    #-----------------------------------------
    variable1Size = lenOfVOIHash[variable1]
#     if 'Dummy' in variable1: # removing the base category (also in final output make sure I consider this)
#         variable1Size -=1
    curMean = TFVarsLogitParamPriorMean[variable1]
    curVar = TFVarsLogitParamPriorVar[variable1]
    TFVarsLogitParam[variable1] =        Normal(mu = tf.mul(tf.ones(variable1Size),curMean),               sigma = tf.mul(tf.ones(variable1Size),curVar))


# In[28]:

# define the model itself (the final conversion) and the priors
#--------------------------------------
# define the conversion portion of the model
#--------------------------------------
from edward.models import Bernoulli
import edward as ed
# to initialize the model compute the Intercept portion outside the loop
variable1 = 'Intercept'
logits = ed.dot(TFVarsLogit_data[variable1],TFVarsLogitParam[variable1])
for variable1 in variablesOfIntrest:
    print('current variable is: %s'%variable1)
    if variable1 == 'Intercept':
        # kept the variable definition but commented for the purpose of tractability only
        #TFVarsLogit[variable1] = tf.cast(np.ones((nObsLogit,1)),dtype=tf.float32)
        pass
    elif 'Dummy' in variable1: # if the variable is dummy
        # kept the variable definition but commented for the purpose of tractability only
        # remove the base category
#         subMat = samplePD[['ObsID',variable1]]
#         subMat = subMat[subMat[variable1]!=baseCaseHash[variable1]]
#         indices = subMat.values
#         values = np.ones(subMat.shape[0])
#         TFVarsLogit[variable1] = tf.SparseTensor(indices=indices.tolist(),\
#                            values=values.tolist(), shape=[nObsLogit,lenOfVOIHash[variable1]-1])#.eval()
        # sparse Matrix multiplication
        # http://stackoverflow.com/questions/34030140/is-sparse-tensor-multiplication-implemented-in-tensorflow
#         print('type of data is:%s'%type(TFVarsLogit_data[variable1]))
#         print('type of the variable is:%s'%type(TFVarsLogit[variable1]))
        logits +=  ed.dot(TFVarsLogit_data[variable1],                         TFVarsLogitParam[variable1])
        pass
    else: # when it is quantitative variable
        # kept the variable definition but commented for the purpose of tractability only
        #TFVarsLogit[variable1] = tf.cast((samplePD[variable1].values).reshape((nObsLogit,1)),dtype=tf.float32)
        logits +=  ed.dot(TFVarsLogit_data[variable1],TFVarsLogitParam[variable1])
        #print type(TFVarsLogit[variable1])
logits = (logits)
y = Bernoulli(logits=logits)


# In[29]:

# defint the variational parameters and distributions
q_TFVarsLogitParam = {}
q_TFVarsLogitParamPriorMean = {}
q_TFVarsLogitParamPriorVar = {}
# prior for the error of the hierarchical model is taken from the following paper as vague prior
#http://www.stat.columbia.edu/~gelman/research/published/taumain.pdf
# consistent with the following:
# https://fisher.osu.edu/~schroeder.9/AMIS900/ech6.pdf
# https://www.stat.auckland.ac.nz/~millar/Bayesian/Handouts/Ch7WinBUGS
for variable1 in variablesOfIntrest:
    print(variable1)
    # removed the following portion b/c I have to think generative not estimation (i.e. forward not backward)
    #curmean, curvar = tf.nn.moments(TFVarsLogitParam[variable1],axes=[1])
    # prior on the variance of the parameters (hyper parameters)
    # define the prior of the model
    #--------------------------------
    alpha = 0.001
    beta = 0.001
    varPrior = 5 # for individual specific parameters, this is pretty vague (wide) prior
    #alpha/beta is the mean of the gamma distribution
    # I have to generate from gamma distribution, then invert to get inverse gamma
    q_TFVarsLogitParamPriorVar[variable1] =InverseGamma(alpha=tf.nn.softplus(tf.Variable(tf.random_normal([1]))),                                                         beta=tf.nn.softplus(tf.Variable(tf.random_normal([1]))))
    # the variance here should be the sum of prior precision and the data precision
    q_TFVarsLogitParamPriorMean[variable1] = Normal(mu=tf.Variable(tf.random_normal([1])),                                              sigma=tf.nn.softplus(tf.Variable(tf.random_normal([1]))))
    # the individual specific parameters
    #-----------------------------------------
    variable1Size = lenOfVOIHash[variable1]
#     if 'Dummy' in variable1: # removing the base category (also in final output make sure I consider this)
#         variable1Size -=1
    curMean = TFVarsLogitParamPriorMean[variable1]
    curVar = TFVarsLogitParamPriorVar[variable1]
    q_TFVarsLogitParam[variable1] =        Normal(mu = tf.Variable(tf.random_normal([variable1Size])),                sigma = tf.nn.softplus(tf.Variable(tf.random_normal([variable1Size]))))


# In[30]:

# test
# tmp1 = 0
# tmp2 = 5
# {tmp1:tmp2}


# In[31]:

# test
type(Normal(mu=tf.zeros(1), sigma=tf.zeros(1)))


# In[32]:

modelDef = {}
for variable1 in variablesOfIntrest:
    print (variable1)
#     print('Actual Variable type of variable1 parameter is: %s, and latent variable is: %s'%(\
#                                         type(TFVarsLogitParam[variable1]),type(q_TFVarsLogitParam[variable1])))
    modelDef[TFVarsLogitParam[variable1]]=q_TFVarsLogitParam[variable1]
#     print('Prior Mean type of variable1 parameter is: %s, and latent variable is: %s'%(\
#                                         type(TFVarsLogitParamPriorMean[variable1]),\
#                                         type(q_TFVarsLogitParamPriorMean[variable1])))
    modelDef[TFVarsLogitParamPriorMean[variable1]]=q_TFVarsLogitParamPriorMean[variable1]
#     print('Prior Var variable type of variable1 parameter is: %s, and latent variable is: %s'%(\
#                                         type(TFVarsLogitParamPriorVar[variable1]),\
#                                         type(q_TFVarsLogitParamPriorVar[variable1])))
    modelDef[TFVarsLogitParamPriorVar[variable1]]=q_TFVarsLogitParamPriorVar[variable1]


# In[33]:

# test the shape
print(Conv.shape)
#print(y.shape)
y.value().get_shape()


# In[34]:

#data ={y: Conv}
data ={}
# for variable1 in variablesOfIntrest:
#     print (variable1)
#     data[TFVarsLogit[variable1]] = TFVarsLogit_data[variable1]
data[y]=Conv


# In[35]:

# run inference method first directly, and then run with e-m and compare
# e-m algorithm
#import theano
inference = ed.KLqp(modelDef, data=data)

# run the inference
# run multiple times as there is possibility of local optima
# also there is problem with edwards that it does not capture nan cases, so it needs to be handled this way
import math
currentLoss = float('nan')
while math.isnan(currentLoss):
    print currentLoss
    inference.run(n_iter=100,n_print=50)
    currentLoss = inference.loss.eval()

	
# check the loss of the winner to make sure it is kept correctly
inference.loss.eval()


# In[38]:

# check the results: mean of treatment effect
q_TFVarsLogitParam['td'].mean().eval()


# In[39]:

# check the results: variance of the treatment effect
q_TFVarsLogitParam['td'].std().eval()

# computing the logit posterior probability
variable1 = 'Intercept'
logit_post = ed.dot(TFVarsLogit_data[variable1],q_TFVarsLogitParam[variable1].mean())
# print(q_TFVarsLogitParam[variable1].mean().eval())
for variable1 in variablesOfIntrest:
    print('current variable is: %s'%variable1)
    if variable1 == 'Intercept':
        # kept the variable definition but commented for the purpose of tractability only
        #TFVarsLogit[variable1] = tf.cast(np.ones((nObsLogit,1)),dtype=tf.float32)
        pass
    elif 'Dummy' in variable1: # if the variable is dummy
        logit_post +=  ed.dot(TFVarsLogit_data[variable1],                         q_TFVarsLogitParam[variable1].mean())
        #print(q_TFVarsLogitParam[variable1].mean().eval())
        #print(TFVarsLogit_data[variable1].eval())
        pass
    else: # when it is quantitative variable
        # kept the variable definition but commented for the purpose of tractability only
        #TFVarsLogit[variable1] = tf.cast((samplePD[variable1].values).reshape((nObsLogit,1)),dtype=tf.float32)
        logit_post +=  ed.dot(TFVarsLogit_data[variable1],q_TFVarsLogitParam[variable1].mean())
#         print(q_TFVarsLogitParam[variable1].mean().eval())
#         print(TFVarsLogit_data[variable1].eval())
        #print type(TFVarsLogit[variable1])
y_post = tf.sigmoid(logit_post)

# posterior probability prediction in logit
y_post.eval().shape

# Design Matrix Creation
#---------------------------------------
# now that I am using tensor flow, I am thinking that I don't need to have a sparse Matrix
# b/c one of the examples they are talking about is the NLP n-gram prediction, and word space is much larger
# so how can I turn it back
# second thought: 
# or as I already have the mapping or can take it from pandas, why not using sparse vector, loading it and then go back
#    and interpret the findings
nObsReg = samplePDReg.shape[0]
TFVarsReg = {}
# first create a column to make sure that index for the dummy variables is preserved correctly
# for the multicollinearity remove the base category for dummy variables
samplePDReg['ObsID']=samplePDReg.index
for variable1 in variablesOfIntrest:
    print('current variable is: %s'%variable1)
    if variable1 == 'Intercept':
        TFVarsReg[variable1] = tf.cast(np.ones((nObsReg,1)),dtype=tf.float32)
    elif 'Dummy' in variable1: # if the variable is dummy
        # remove the base category
        subMat = samplePDReg[['ObsID',variable1]]
        subMat = subMat[subMat[variable1]!=baseCaseHash[variable1]]
        indices = subMat.values
        values = np.ones(subMat.shape[0])
        TFVarsReg[variable1] = tf.sparse_tensor_to_dense(tf.SparseTensor(indices=indices.tolist(),                           values=values.tolist(), shape=[nObsReg,lenOfVOIHash[variable1]]),0.0)#.eval()
    else: # when it is quantitative variable
        TFVarsReg[variable1] = tf.cast((samplePDReg[variable1].values).reshape((nObsReg,1)),dtype=tf.float32)

# define the model parameters vectors actual and prior [Think in generative mode rather than estimation mode]
# define the prior portion of the model as well
#----------------------------------------
TFVarsRegParam = {}
TFVarsRegParamPriorMean = {}
TFVarsRegParamPriorVar = {}
# prior for the error of the hierarchical model is taken from the following paper as vague prior
#http://www.stat.columbia.edu/~gelman/research/published/taumain.pdf
# consistent with the following:
# https://fisher.osu.edu/~schroeder.9/AMIS900/ech6.pdf
# https://www.stat.auckland.ac.nz/~millar/Bayesian/Handouts/Ch7WinBUGS
for variable1 in variablesOfIntrest:
    # removed the following portion b/c I have to think generative not estimation (i.e. forward not backward)
    #curmean, curvar = tf.nn.moments(TFVarsLogitParam[variable1],axes=[1])
    # prior on the variance of the parameters (hyper parameters)
    # define the prior of the model
    #--------------------------------
    alpha = 0.001
    beta = 0.001
    varPrior = 5 # for individual specific parameters, this is pretty vague (wide) prior
    #alpha/beta is the mean of the gamma distribution
    # I have to generate from gamma distribution, then invert to get inverse gamma
    TFVarsRegParamPriorVar[variable1] = InverseGamma(alpha=tf.ones(1)*alpha,beta=tf.ones(1)*beta)
    # the variance here should be the sum of prior precision and the data precision
    TFVarsRegParamPriorMean[variable1] = Normal(mu=tf.zeros(1),                                              sigma=tf.ones(1)*varPrior)
    # the individual specific parameters
    #-----------------------------------------
    variable1Size = lenOfVOIHash[variable1]
#     if 'Dummy' in variable1: # removing the base category (also in final output make sure I consider this)
#         variable1Size -=1
    curMean = TFVarsRegParamPriorMean[variable1]
    curVar = TFVarsRegParamPriorVar[variable1]
    TFVarsRegParam[variable1] =        Normal(mu = tf.mul(tf.ones(variable1Size),curMean),               sigma = tf.mul(tf.ones(variable1Size),curVar))

# define the model itself (the final conversion) and the priors
#--------------------------------------
# define the log r portion of the model
#--------------------------------------
from edward.models import Bernoulli
import edward as ed
# to initialize the model compute the Intercept portion outside the loop
variable1 = 'Intercept'
logrv = ed.dot(TFVarsReg[variable1],TFVarsRegParam[variable1])
for variable1 in variablesOfIntrest:
    print('current variable is: %s'%variable1)
    if variable1 == 'Intercept':
        # kept the variable definition but commented for the purpose of tractability only
        #TFVarsLogit[variable1] = tf.cast(np.ones((nObsLogit,1)),dtype=tf.float32)
        pass
    elif 'Dummy' in variable1: # if the variable is dummy
        # kept the variable definition but commented for the purpose of tractability only
        # remove the base category
#         subMat = samplePD[['ObsID',variable1]]
#         subMat = subMat[subMat[variable1]!=baseCaseHash[variable1]]
#         indices = subMat.values
#         values = np.ones(subMat.shape[0])
#         TFVarsLogit[variable1] = tf.SparseTensor(indices=indices.tolist(),\
#                            values=values.tolist(), shape=[nObsLogit,lenOfVOIHash[variable1]-1])#.eval()
        # sparse Matrix multiplication
        # http://stackoverflow.com/questions/34030140/is-sparse-tensor-multiplication-implemented-in-tensorflow
        logrv = logrv + ed.dot(TFVarsReg[variable1],                         TFVarsRegParam[variable1])
        pass
    else: # when it is quantitative variable
        # kept the variable definition but commented for the purpose of tractability only
        #TFVarsLogit[variable1] = tf.cast((samplePD[variable1].values).reshape((nObsLogit,1)),dtype=tf.float32)
        logrv = logrv +  ed.dot(TFVarsReg[variable1],TFVarsRegParam[variable1])
        #print type(TFVarsLogit[variable1])
logrv = (logrv)
RegError = InverseGamma(alpha=tf.ones(1)*alpha,beta=tf.ones(1)*beta)
yReg = Normal(mu = logrv, sigma = RegError)

# defint the variational parameters and distributions
q_TFVarsRegParam = {}
q_TFVarsRegParamPriorMean = {}
q_TFVarsRegParamPriorVar = {}
q_RegError = InverseGamma(alpha=tf.nn.softplus(tf.Variable(tf.random_normal([1]))),                                                         beta=tf.nn.softplus(tf.Variable(tf.random_normal([1]))))
# prior for the error of the hierarchical model is taken from the following paper as vague prior
#http://www.stat.columbia.edu/~gelman/research/published/taumain.pdf
# consistent with the following:
# https://fisher.osu.edu/~schroeder.9/AMIS900/ech6.pdf
# https://www.stat.auckland.ac.nz/~millar/Bayesian/Handouts/Ch7WinBUGS
for variable1 in variablesOfIntrest:
    print(variable1)
    # removed the following portion b/c I have to think generative not estimation (i.e. forward not backward)
    #curmean, curvar = tf.nn.moments(TFVarsLogitParam[variable1],axes=[1])
    # prior on the variance of the parameters (hyper parameters)
    # define the prior of the model
    #--------------------------------
    alpha = 0.001
    beta = 0.001
    varPrior = 5 # for individual specific parameters, this is pretty vague (wide) prior
    #alpha/beta is the mean of the gamma distribution
    # I have to generate from gamma distribution, then invert to get inverse gamma
    q_TFVarsRegParamPriorVar[variable1] =InverseGamma(alpha=tf.nn.softplus(tf.Variable(tf.random_normal([1]))),                                                         beta=tf.nn.softplus(tf.Variable(tf.random_normal([1]))))
    # the variance here should be the sum of prior precision and the data precision
    q_TFVarsRegParamPriorMean[variable1] = Normal(mu=tf.Variable(tf.random_normal([1])),                                              sigma=tf.nn.softplus(tf.Variable(tf.random_normal([1]))))
    # the individual specific parameters
    #-----------------------------------------
    variable1Size = lenOfVOIHash[variable1]
#     if 'Dummy' in variable1: # removing the base category (also in final output make sure I consider this)
#         variable1Size -=1
    curMean = TFVarsRegParamPriorMean[variable1]
    curVar = TFVarsRegParamPriorVar[variable1]
    q_TFVarsRegParam[variable1] =        Normal(mu = tf.Variable(tf.random_normal([variable1Size])),                sigma = tf.nn.softplus(tf.Variable(tf.random_normal([variable1Size]))))

# define model parameters
modelDefReg = {RegError: q_RegError}
for variable1 in variablesOfIntrest:
    print (variable1)
    modelDefReg[TFVarsRegParam[variable1]]=q_TFVarsRegParam[variable1]
    modelDefReg[TFVarsRegParamPriorMean[variable1]]=q_TFVarsRegParamPriorMean[variable1]
    modelDefReg[TFVarsRegParamPriorVar[variable1]]=q_TFVarsRegParamPriorVar[variable1]

# run inference method 
inferenceReg = ed.KLqp(modelDefReg, data={yReg: Logrv})


# In[50]:

# run the inference
# run multiple times as there is possibility of local optima
# also there is problem with edwards that it does not capture nan cases, so it needs to be handled this way
currentLossReg = float('nan')
while math.isnan(currentLossReg):
    print currentLossReg
    inferenceReg.run(n_iter=100,n_print=50)
    currentLossReg = inferenceReg.loss.eval()

# check the loss of the winner to make sure it is kept correctly
inferenceReg.loss.eval()

# check the results: mean of treatment effect
q_TFVarsRegParam['td'].mean().eval()

# check the results: variance of the treatment effect
q_TFVarsRegParam['td'].std().eval()

# test
q_TFVarsRegParam['id'].mean().eval()[0]

# posterior log-rv prediction
#--------------------------------------
# to initialize the model compute the Intercept portion outside the loop
variable1 = 'Intercept'
logrv_post = ed.dot(TFVarsReg[variable1],q_TFVarsRegParam[variable1].mean())
for variable1 in variablesOfIntrest:
    print('current variable is: %s'%variable1)
    if variable1 == 'Intercept':
        pass
    elif 'Dummy' in variable1: # if the variable is dummy
        # kept the variable definition but commented for the purpose of tractability only
        # remove the base category
        logrv_post+= ed.dot(TFVarsReg[variable1],                         q_TFVarsRegParam[variable1].mean())
        pass
    else: # when it is quantitative variable
        # kept the variable definition but commented for the purpose of tractability only
        #TFVarsLogit[variable1] = tf.cast((samplePD[variable1].values).reshape((nObsLogit,1)),dtype=tf.float32)
        logrv_post += ed.dot(TFVarsReg[variable1],q_TFVarsRegParam[variable1].mean())
        #print type(TFVarsLogit[variable1])

logrv_post.eval().shape
