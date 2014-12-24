# written by: Meisam Hejazinia
# Date: 12/02/2014
library(stats)
# Pricipal Components Analysis
# entering raw data and extracting PCs 
# from the correlation matrix 
mydata=read.csv("C:/Users/MeisamHe/Desktop/Desktop/BackupToRestoreComputerApril15/MachineLearning/Project/combinedARFF/combinedARFF.csv",header=T)
eigenWeka=read.csv("C:/Users/MeisamHe/Desktop/Desktop/BackupToRestoreComputerApril15/MachineLearning/Project/combinedARFF/eigenVectorPCAWeka.csv",header=T)

onlyImageData =read.csv("C:/Users/MeisamHe/Desktop/Desktop/BackupToRestoreComputerApril15/MachineLearning/Project/combinedARFF/onlyImageARFF.csv",header=T)
onlyImage =data.matrix(onlyImageData[,1:12], rownames.force = NA) #1-9 gives only histogram and mean
onlyImage = scale(onlyImage, center=FALSE, scale=colSums(onlyImage))

# cleaned data
cleanedTxtImg =read.csv("C:/Users/MeisamHe/Desktop/Desktop/BackupToRestoreComputerApril15/MachineLearning/Project/combinedARFF/cleanedImgTxtData.csv",header=T)
TxtImage =data.matrix(cleanedTxtImg, rownames.force = NA) #1-9 gives only histogram and mean
TxtImage = scale(TxtImage, center=FALSE, scale=colSums(TxtImage))



realData=data.matrix(mydata, rownames.force = NA)
eigenWekaMatrix=data.matrix(eigenWeka[,2:dim(eigenWeka)[2]], rownames.force = NA)
correctData = realData[,eigenWeka[,1]]

projectedData = correctData%*%eigenWekaMatrix

#using realData is not possible, possible because the matrix is singular, so I use only features
# that are used in the output of EM algorithm
nonZeroData = matrix(realData[colSums(realData)>0],nrow=355)
temp = scale(nonZeroData, center=FALSE, scale=colSums(nonZeroData))
unModifiedData = temp
scaledProjectedData = as.integer(1e4*scale(projectedData, center=FALSE, scale=colSums(projectedData)))


# to make sure like frequency matrix it is positive and integer matrix
# I multiplied to 100 to make sure that 
docTermMatrix = array(scaledProjectedData,
                      dim=c(dim(projectedData)[1],dim(projectedData)[2]))
docVisTermMatirx = array(as.integer(1e4*onlyImage),
                         dim=c(dim(onlyImage)[1],dim(onlyImage)[2]))

docTermMatrixFactored = array(as.integer((abs(min(projectedData))+projectedData)/sqrt(var(as.integer(projectedData)))),
                      dim=c(dim(projectedData)[1],dim(projectedData)[2]))
library(slam)
temp = as.simple_triplet_matrix(docTermMatrix)
# convert to doc term matrix object
library(tm)
#myDocumentTermMatrix = DocumentTermMatrix(TermDocumentMatrix(docTermMatrix),control=list())

#attempts to do factor Analysis that did not work here
#fit <- princomp(mydata, cor=TRUE) #cannot be used when p>n
#fit <- factanal(correctData, 3, rotation="varimax") #systm is computationally singular, reciprocal condition number = 0

#library(psych)
#fit <- principal(mydata, nfactors=5, rotate="varimax") #error of standard Deviation = 0
#fit <- factor.pa(mydata, nfactors=3, rotation="varimax") #infinite or missing value x

# running LDA
library(topicmodels)

#====================================================================================
# Latend Dirichlet Allocation (LDA), the EM version
#====================================================================================

# k is the number of topics which needs to be fixed a priori
k = 6
control_LDA_VEM <- list(estimate.alpha = TRUE, alpha = 50/k, estimate.beta = TRUE,
           verbose = 1, prefix = tempfile(), save = 0, keep = 0,
           seed = as.integer(Sys.time()), nstart = 1, best = TRUE,
           var = list(iter.max = 500, tol = 10^-6),
           em = list(iter.max = 1000, tol = 10^-4),
           initialize = "random")
#lda = LDA(x = docTermMatrix, k, method = "VEM", control = control_LDA_VEM , model = NULL)
lda = LDA(x = docVisTermMatirx, k, method = "VEM", control = control_LDA_VEM , model = NULL)
sum(lda@loglikelihood)   # because it gives likelihood for each individual
#lda_inf <- posterior(lda, docTermMatrix)
lda_inf <- posterior(lda, docVisTermMatirx)
lda_inf$topics

#====================================================================================
# Latend Dirichlet Allocation (LDA), the gibbs version
#====================================================================================
k=12
control_LDA_Gibbs <-list(alpha = 50/k, estimate.beta = TRUE,verbose = 1, prefix = tempfile(), save = 0, keep = 0,
          seed = as.integer(Sys.time()), nstart = 1, best = TRUE,
          delta = 0.1,
          iter = 2000, burnin = 0, thin = 2000)

#ldagibbs=LDA(x = docTermMatrix, k, method = "Gibbs", control = control_LDA_Gibbs, model = NULL)
ldagibbs=LDA(x = docVisTermMatirx, k, method = "Gibbs", control = control_LDA_Gibbs, model = NULL)
ldagibbs@loglikelihood
#ldagibbs_inf <- posterior(ldagibbs, docTermMatrix)
ldagibbs_inf <- posterior(ldagibbs, docVisTermMatirx)
ldagibbs_inf$topics
#====================================================================================
# CTM: dependent topic modeld
#====================================================================================
k=7
control_CTM_VEM <-  list(estimate.beta = TRUE,
           verbose = 1, prefix = tempfile(), save = 0, keep = 0,
           seed = as.integer(Sys.time()), nstart = 1L, best = TRUE,
           var = list(iter.max = 500, tol = 10^-6),
           em = list(iter.max = 1000, tol = 10^-4),
           initialize = "random",
           cg = list(iter.max = 500, tol = 10^-5))
#ctm = CTM(x = docTermMatrix , k, method = "VEM", control = control_CTM_VEM, model = NULL)
ctm = CTM(x = docVisTermMatirx , k, method = "VEM", control = control_CTM_VEM, model = NULL)

sum(ctm@loglikelihood)

ctm_inf <- posterior(ctm, docVisTermMatirx)
ctm_inf$topics
#ctm_inf <- posterior(ctm, docTermMatrix)
#build_graph(ctm,0.1, and = TRUE)

#====================================================================================
# Check for cluster means
#====================================================================================
fit <- kmeans(docTermMatrix, 6) 
fit <- kmeans(onlyImage, 6)
summary(fit)
fit$cluster
cat(fit$cluster,sep="\n")
fit
#fit <- kmeans(unModifiedData,6)
# vary parameters for most readable graph
library(cluster) 
clusplot(docTermMatrix, fit$cluster, color=TRUE, shade=TRUE, 
         labels=3, lines=0)
fitresult= c(96.9,96.8,96.7,96.4,95.1,89.9,87.8,81.6)
fitresult=1-rev(fitresult)/100
plot(fitresult,type='l')

#====================================================================
hierarchical clustering
#=====================================================================
library(pvclust)
fit <- pvclust(mydata, method.hclust="ward",
               method.dist="euclidean")
plot(fit) # dendogram with p values

#====================================================================
# Model Based Clustering
#=====================================================================


library(mclust)           # load mclust library
# following only identifies one cluster
model <- Mclust(docTermMatrix) # estimate the number of cluster (BIC), initialize (HC) and clusterize (EM)
model <- Mclust(onlyImage)
summary(model)
model$classification
model$uncertainty
model <- Mclust(TxtImage)
plot(model) # plot results 
# check the main data
#model <- Mclust(correctData)
#model <- Mclust(unModifiedData)
#model <- Mclust(docTermMatrix)
#data = correctData           # get the data set 
#plot(model, correctData)     # plot the clustering results

#running Expectation Maximization for comparison
library(EMCluster)
ret <- init.EM(docTermMatrix, nclass = 5)

#==============================================================
# Check for the histogram of CTM
#==============================================================
test.txt <- read.table("C:/Users/MeisamHe/Desktop/Desktop/BackupToRestoreComputerApril15/MachineLearning/Project/combinedARFF/CTMoutputMembership.txt", header=F)
temp = data.matrix(test.txt, rownames.force = NA)
hist(temp,breaks=50)