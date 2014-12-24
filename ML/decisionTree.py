__author__ = 'MeisamHe'

import csv
import sys
import math
import random
import os
#----------------------------------------------------------------------

def csv_dict_reader(file_obj):
    """
    Read a CSV file using csv.DictReader
    """
    reader = csv.DictReader(file_obj, delimiter=',')
    """
    for line in reader:
        print(line["XB"]),
        print(line["XJ"])
    """
    return reader

def split(T,cn):
    """
    Gets a table(list) T, a column(string)  cn, and a value v (which we find out within the procedure) and return sub table that includes these value
    """
    i = 0
    subTables = {}
    for line in T:
         if (not subTables.has_key(line[cn])):
            subTables[line[cn]] = []
         i = len(subTables[line[cn]])+1
         subTables[line[cn]].insert(i,line)
    return  subTables

def freq(T,cn):
    """
    Gets table(list) T and column name(string) cn and returns frequency of classes
    """
    frequencyTable = {}
    for line in T:
         #print (cn)
         if (frequencyTable.has_key(line[cn])):
            frequencyTable[line[cn]] = frequencyTable[line[cn]] + 1
         else:
            frequencyTable[line[cn]] = 1
    return frequencyTable

def entropy(T,cn):
    """
    Gets table(list) T and column name(string) cn and returns the entropy
    """
    freqT = freq(T,cn)
    Tsize = len(T)
    keys = freqT.keys()
    entropyHv = 0
    prob = {}
    for key in keys:
        prob[key]= float(freqT[key])/float(Tsize)
        #print(prob[key])
        # when it is pure, means the probability is zero, then entropy is zero per definition
        if (not prob[key]==0):
            entropyHv = float(entropyHv) -float(prob[key])*math.log(float(prob[key]))
    return float(entropyHv)

def varianceimpurity(T,cn):
    """
    Gets table(list) T and column name(string) of results cn and returns the entropy
    """
    freqT = freq(T,cn)
    Tsize = len(T)
    keys = freqT.keys()
    varimp = float(1)
    prob = {}
    for key in keys:
        prob[key]= float(freqT[key])/float(Tsize)
        varimp = float(varimp)*prob[key]
    return varimp

def infoGain(T,rt,cn):
    """
    Gets table(list) T and column name(string) of results rt and the new columns to split on name cn and returns the gain from split
    """
    gain = float(entropy(T,rt))
    freqT = freq(T,cn)
    keys = freqT.keys()
    Tsize = len(T)
    splitted = split(T,cn)
    for key in keys:
        gain= float(gain) - (float(freqT[key])/float(Tsize))*float(entropy(splitted[key],rt))
    return  float(gain)

def varimpGain(T,rt,cn):
    """
    Gets table(list) T and column name(string) of results rt and the new columns to split on name cn and returns the gain from split
    """
    gain = varianceimpurity(T,rt)
    freqT = freq(T,cn)
    keys = freqT.keys()
    Tsize = len(T)
    splitted = split(T,cn)
    for key in keys:
        gain= gain - freqT[key]/Tsize*varianceimpurity(splitted[key],rt)
    return  gain

def GrowTree(T,rt,cond,gaintype,columnNames):
    """
    Gets table(list) T and column name(string) of results rt, the values already conditioned upon cond, gaintype for different gains (info,var) and create the tree (forward approach)
    """
    freqT= freq(T,rt)
    keys = freqT.keys()
    universe= []
    gain = -1
    splitItem = []
    middleNode=["DecNode"]
    if (len(keys)==1):
        return [0,['leaf',keys,cond,T]]
    elif (len(cond)==len(T[1])-1):
        # use majority rule
        curvotelist = 0
        for key in keys:
            if (freqT[key]>curvotelist):
                curvotelist = freqT[key]
                winnerkey = key
        return [0,['leaf',[winnerkey],cond,T]]
    else:
        universe[0:(len(T[1])-2)]=[1]*(len(T[1])-1)
        if (len(cond)>0):
            for i in cond:
                universe[i]=0
        universe=[i for i, e in enumerate(universe) if e != 0]
        # universe is now index of all non zero elements of the array
        #print(universe)
        for cn in universe:
            currentindx=columnNames[cn]
            if (gaintype == 'infoGain'):
                gaintemp = infoGain(T,rt,currentindx)
            elif (gaintype == 'varimpGain'):
                gaintemp = varimpGain(T,rt,currentindx)
            if (gain < gaintemp):
                gain = gaintemp
                splitItem = currentindx
        #print("conditions are:")
        #print(cond)
        #print("universe is:")
        #print(universe)
        #print("splitItem is:")
        #print(splitItem)
        splitted = split(T,splitItem)
        freqT = freq(T,splitItem)
        keys = freqT.keys()
        #if (currentindx=="XR"):
         #   print("the result of investigation is:")
         #   print(keys)
        if (len(keys)==1):
            # use majority rule
            curvotelist = 0
            for key in keys:
                if (freqT[key]>curvotelist):
                    curvotelist = freqT[key]
                    winnerkey = key
            return [0,['leaf',[winnerkey],cond,T]]
        middleNode.insert(1,splitItem)
        i = 2
        subtreesize = 1
        cond.insert(len(cond),columnNames.index(splitItem))
        #print("New condition is: \n")
        #print(cond)
        for key in keys:
            middleNode.insert(i,key)
            tempsubtree = GrowTree(splitted[key],rt,cond,gaintype,columnNames)
            #print("tempsubtree")
            #print(tempsubtree)
            subtreesize = subtreesize + tempsubtree[0]
            middleNode.insert(i+1,tempsubtree[1])
            i = i+2
        middleNode.insert(len(middleNode),subtreesize)
    return  [subtreesize,middleNode]

def countLeaf (tree):
    """
     recives a tree and counts number of leaf nodes, simple recursive function
    """
    if (tree[0]=='leaf'):
        return len(tree[4])
    else:
        return (countLeaf(tree[3])+countLeaf(tree[5]))

def countNonLeaf (tree):
    """
     recives a tree and counts number of non-leaf nodes, simple recursive function
    """
    #printtree(tree,0)
    #print("current tree is:")
    #print(tree)
    if (tree[0]=='leaf'):
        return 0
    else:
        return (1+countNonLeaf(tree[3])+countNonLeaf(tree[5]))

def findReplaceNonLeaf (tree,P,rt):
    """
     recives a tree and it finds the P'th non-leaf node, rt the response column name and it replaces it with leaf node
    """
    if (P==1 or P<0):
        return [0,replace(tree,rt)]
    else:
        P = P-1
        i = 2
        # find the correct subtree and replace it with the new one
        #print ('current tree is:')
        #print (tree)
        #print('current P is:')
        #print(P)
        #print("intermediate tree")
        #printtree(tree[i+1],0)
        #print('initial value is:')
        #print (tree[i+1][len(tree[i+1])-1])
        if (tree[i+1][0]=='leaf'):
            i=i+2
        else:
            while (tree[i+1][len(tree[i+1])-1]<P):
                #print('current value is:')
                #print (tree[i+1][len(tree[i+1])-1])
                P = P - tree[i+1][len(tree[i+1])-1]
                i = i+2
        # simply replace subtree tree with the new one
        returnedResult = findReplaceNonLeaf(tree[i+1],P,rt)
        if (tree[i+1]=='DecNode'):
            oldsize = tree[i+1][len(tree[i+1])-1]-returnedResult[0]-1
        else:
            oldsize = 0
        tree[i+1]= returnedResult[1]
        #print('old size is:')
        #print(oldsize)
        tree[len(tree)-1] = tree[len(tree)-1]-(oldsize)
    return [tree[len(tree)-1],tree]

def replace (tree,rt):
    """
     recives a tree and replaces it with a leaf node
    """
    leaveslist = leaves (tree)
    votelist = freq(leaveslist,rt)
    votekey = votelist.keys()
    curvotelist = 0
    winnerkey   = 0
    for key in votekey:
        if (votelist[key]>curvotelist):
            curvotelist = votelist[key]
            winnerkey = key
    return ['leaf',winnerkey,[],leaveslist]

def leaves (tree):
    """
     recives a tree and returns all its leaves
    """
    i = 2
    if (tree[0]=='leaf'):
        return (tree[3])
    else:
        leaveslist = []
        #return the
        while (i<(len(tree)-2)):
            leaveslist=leaveslist+leaves(tree[i+1])
            i = i+2
    return leaveslist

def accuracy(tree,validation,rt):
    """
    Validation set is the set for model checking
    """
    accuracyfreq = 0
    totalsize = len(validation)
    for item in validation:
        currentNode = tree
        while (not currentNode[0]=="leaf"):
            i=2
            while (not currentNode[i]==item[currentNode[1]]):
                i=i+2
            currentNode = currentNode[i+1]
        if(currentNode[1]== item[rt]):
            accuracyfreq = accuracyfreq + 1
    return float(accuracyfreq)/totalsize

def postpruning(L,K,tree,rt,validation,total):
    """
    Gets L and K as tunning parameters, tree as the tree, rt as the column number of the results,  validation for model checking and prunes the tree
    """
    bestTree = tree
    for i in range(1,L+1,1):
        Dprime = tree
        M =  random.randrange(1, K+1, 1)  # one integer from 1 to K
        for j in range(1,M+1,1):
            #print ("Dprime is:")
            #print (Dprime)
            #Nleaf = countNonLeaf(Dprime)
            P = random.randrange(1, countNonLeaf (tree)+1, 1)  # one integer from 1 to Nleaf
            replacedTree = findReplaceNonLeaf (Dprime,P,rt)
            Dprime= replacedTree[1]
        if (len(Dprime)>7): # to make sure that it does not return empty tree
            if (accuracy(Dprime,validation,rt)>accuracy(bestTree,validation,rt)):
                    bestTree = Dprime
    return bestTree

def printtree(tree,branchdebth):
    """
    Get tree and the branchdebth and draw the tree
    """
    treelen = len(tree)-1
    branchname = tree[1]
   # for i in range(1,branchdebth+2,1):
   #     print('|'),
    #print ((treelen-2)/2),
    #print ","
    #print len(tree)
    sw = True
    for i in range (1,(treelen)/2,1): #range is always +1
        if (sw==True):
            for j in range(1,branchdebth+1,1):
                print('|'),
        print branchname,
        print ' = ',
        print tree[i*2],
        if (tree[i*2+1][0]=='leaf'):
            sw = True
            print " : ",
            print tree[i*2+1][1][0]
        else:
            print "(",
            print tree[6],
            print ")",
            print '\n',
            printtree(tree[i*2+1],branchdebth+1)


#----------------------------------------------------------------------
#                            Main
#----------------------------------------------------------------------
if __name__ == "__main__":
    linetemp = []
    i = 0
    #arg1 = sys.argv[1]
    #arg2 = sys.argv[2]
    #arg3 = sys.argv[3]
    #arg4 = sys.argv[4]
    #arg5 = sys.argv[5]
    #arg6 = sys.argv[6]
    #------------------------------------------------------------------------------------------
    #                               Results on information gain heuristics
    #------------------------------------------------------------------------------------------
    arg3 = "training_set.csv"
    with open(arg3) as f_obj:
         for line in csv_dict_reader(f_obj):
            linetemp.insert(i,line)
            i = i+1
    #print(linetemp)
    #print (len(linetemp))
    T = linetemp
    rt = "Class"
    cond = []
    gaintype = "infoGain"
    import csv
    f = open(arg3, 'rb')
    reader = csv.reader(f)
    headers = reader.next()
    columNames = headers
    resultedTree=GrowTree(T,rt,cond,gaintype,columNames)
    #print("resulted tree is:\n")
    #print(resultedTree[1])
    #print("length of the tree is:\n")
    #print(len(resultedTree[1]))


    #inputs
    L = 10 # times to prune
    K = 10 # prune in each round
    arg4 = "validation_set.csv"
    with open(arg4) as f_obj:
         for line in csv_dict_reader(f_obj):
            linetemp.insert(i,line)
            i = i+1
    #print(linetemp)
    #print (len(linetemp))
    validation = linetemp
    postproned = postpruning(L,K,resultedTree[1],rt,validation,total=resultedTree[0])


    #test precision on the test data
    arg5 = "test_set.csv"
    with open(arg3) as f_obj:
         for line in csv_dict_reader(f_obj):
            linetemp.insert(i,line)
            i = i+1
    testset = linetemp
    #test unpruned tree


    arg6 = 'Yes'

    print("------------------result of information gain heuristic-----------------------")
    print("K and L are:"),
    print(K),
    print(L)

    if (arg6=='Yes'):
        print("original tree is:")
        printtree(resultedTree[1],0)

        print("resulted tree is:")
        printtree(postproned,0)

    print("Accuracies (pre-prunnning) for information gain heuristic")
    print(accuracy(resultedTree[1],testset,rt))

    #test pruned tree
    print("Accuracies (post-prunning) for information gain heuristic")
    print(accuracy(postproned,testset,rt))


    #------------------------------------------------------------------------------------------
    #                               Results on Variance Impurity heuristics
    #------------------------------------------------------------------------------------------
    arg3 = "training_set.csv"
    with open(arg3) as f_obj:
         for line in csv_dict_reader(f_obj):
            linetemp.insert(i,line)
            i = i+1
    #print(linetemp)
    #print (len(linetemp))
    T = linetemp
    rt = "Class"
    cond = []
    gaintype = "varimpGain"
    import csv
    f = open(arg3, 'rb')
    reader = csv.reader(f)
    headers = reader.next()
    columNames = headers
    resultedTree=GrowTree(T,rt,cond,gaintype,columNames)
    #print("resulted tree is:\n")
    #print(resultedTree[1])
    #print("length of the tree is:\n")
    #print(len(resultedTree[1]))


    #inputss
    arg4 = "validation_set.csv"
    with open(arg4) as f_obj:
         for line in csv_dict_reader(f_obj):
            linetemp.insert(i,line)
            i = i+1
    #print(linetemp)
    #print (len(linetemp))
    validation = linetemp
    postproned = postpruning(L,K,resultedTree[1],rt,validation,total=resultedTree[0])


    #test precision on the test data
    arg5 = "test_set.csv"
    with open(arg3) as f_obj:
         for line in csv_dict_reader(f_obj):
            linetemp.insert(i,line)
            i = i+1
    testset = linetemp
    #test unpruned tree


    arg6 = 'Yes'

    print("------------------result of information gain heuristic-----------------------")
    print("K and L are:"),
    print(K),
    print(L)

    if (arg6=='Yes'):
        print("original tree is:")
        printtree(resultedTree[1],0)

        print("resulted tree is:")
        printtree(postproned,0)

    print("Accuracies (pre-prunnning) for information gain heuristic")
    print(accuracy(resultedTree[1],testset,rt))

    #test pruned tree
    print("Accuracies (post-prunning) for information gain heuristic")
    print(accuracy(postproned,testset,rt))

    #run on the first set

    # run on the second set

    #tune on the first set

    #tune on the second set