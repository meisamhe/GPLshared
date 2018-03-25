#===========================================
# Read and write sparse matrix
#===========================================
library(Matrix)
M <- Matrix(0, 10000, 100)
M[1,1] <- M[2,3] <- 3.14
M  ## show(.) method suppresses printing of the majority of rows

## very simple export - in triplet format - to text file:
data(CAex)
s.CA <- summary(CAex)
message("writing to ", outf <- tempfile())
write.table(s.CA, file = outf, row.names=FALSE)
## and read it back -- showing off  sparseMatrix():
dd <- read.table(outf, header=TRUE)
mm <- do.call(sparseMatrix, dd)
dim(mm)
stopifnot(all.equal(mm, CAex, tol=1e-15))

#===========================================
# sample sparse matrix definition in Matrix library
# src: http://www.johnmyleswhite.com/notebook/2011/10/31/using-sparse-matrices-in-r/
#===========================================
library(Matrix)
library('Matrix')
 
m1 <- matrix(0, nrow = 1000, ncol = 1000)
m2 <- Matrix(0, nrow = 1000, ncol = 1000, sparse = TRUE)
 
object.size(m1)
# 8000200 bytes
object.size(m2)
# 5632 bytes

m1[500, 500] <- 1
m2[500, 500] <- 1
 
object.size(m1)
# 8000200 bytes
object.size(m2)
# 5648 bytes

#sparse matrix operations
#================
m2 %*% rnorm(1000)
m2 + m2
m2 - m2
t(m2)

#binding operations using the object class of Matrix
#====================
m3 <- cBind(m2, m2)
nrow(m3)
ncol(m3)
 
m4 <- rBind(m2, m2)
nrow(m4)
ncol(m4)

#===========================================
# sample sparse matrix definition in Matrix library, but with much less space
#===========================================
library('slam')
 
m1 <- matrix(0, nrow = 1000, ncol = 1000)
m2 <- simple_triplet_zero_matrix(nrow = 1000, ncol = 1000)
 
object.size(m1)
# 8000200 bytes
object.size(m2)
# 1032 bytes

# BUG HERE
m1[500, 500] <- 1
m2[500, 500] <- 1
 
object.size(m1)
object.size(m2)

m2 %*% rnorm(1000)
m2 + m2
m2 - m2
t(m2)

#=============================================
#  GLM on the sparse data => glmnet
# either linear or logistic regression — preferably with some sort of regularization
#============================================
library('Matrix')
library('glmnet')
 
n <- 10000
p <- 500
 
x <- matrix(rnorm(n * p), n, p)
iz <- sample(1:(n * p),
             size = n * p * 0.85,
             replace = FALSE)
x[iz] <- 0
 
object.size(x)
 
sx <- Matrix(x, sparse = TRUE)
 
object.size(sx)
 
beta <- rnorm(p)
 
y <- x %*% beta + rnorm(n)
 
glmnet.fit <- glmnet(x, y)

#=============================================
#  glmnet benchmark
#============================================
library('Matrix')
library('glmnet')
 
set.seed(1)
performance <- data.frame()
 
for (sim in 1:10)
{
  n <- 10000
  p <- 500
 
  nzc <- trunc(p / 10)
 
  x <- matrix(rnorm(n * p), n, p)
  iz <- sample(1:(n * p),
               size = n * p * 0.85,
               replace = FALSE)
  x[iz] <- 0
  sx <- Matrix(x, sparse = TRUE)
 
  beta <- rnorm(nzc)
  fx <- x[, seq(nzc)] %*% beta
 
  eps <- rnorm(n)
  y <- fx + eps
 
  sparse.times <- system.time(fit1 <- glmnet(sx, y))
  full.times <- system.time(fit2 <- glmnet(x, y))
  sparse.size <- as.numeric(object.size(sx))
  full.size <- as.numeric(object.size(x))
 
  performance <- rbind(performance, data.frame(Format = 'Sparse',
                                               UserTime = sparse.times[1],
                                               SystemTime = sparse.times[2],
                                               ElapsedTime = sparse.times[3],
                                               Size = sparse.size))
  performance <- rbind(performance, data.frame(Format = 'Full',
                                               UserTime = full.times[1],
                                               SystemTime = full.times[2],
                                               ElapsedTime = full.times[3],
                                               Size = full.size))
}
 
ggplot(performance, aes(x = Format, y = UserTime, fill = Format)) +
  stat_summary(fun.data = 'mean_cl_boot', geom = 'bar') +
  stat_summary(fun.data = 'mean_cl_boot', geom = 'errorbar') +
  ylab('User Time in Seconds') +
  opts(legend.position = 'none')
ggsave('sparse_vs_full_user_time.pdf')
 
ggplot(performance, aes(x = Format, y = SystemTime, fill = Format)) +
  stat_summary(fun.data = 'mean_cl_boot', geom = 'bar') +
  stat_summary(fun.data = 'mean_cl_boot', geom = 'errorbar') +
  ylab('System Time in Seconds') +
  opts(legend.position = 'none')
ggsave('sparse_vs_full_system_time.pdf')
 
ggplot(performance, aes(x = Format, y = ElapsedTime, fill = Format)) +
  stat_summary(fun.data = 'mean_cl_boot', geom = 'bar') +
  stat_summary(fun.data = 'mean_cl_boot', geom = 'errorbar') +
  ylab('Elapsed Time in Seconds') +
  opts(legend.position = 'none')
ggsave('sparse_vs_full_elapsed_time.pdf')
 
ggplot(performance, aes(x = Format, y = Size / 1000000, fill = Format)) +
  stat_summary(fun.data = 'mean_cl_boot', geom = 'bar') +
  stat_summary(fun.data = 'mean_cl_boot', geom = 'errorbar') +
  ylab('Matrix Size in MB') +
  opts(legend.position = 'none')
ggsave('sparse_vs_full_memory.pdf')

#=============================================
#  GLM sample
#============================================

glmnet(x, y, family=c("gaussian","binomial","poisson","multinomial","cox","mgaussian"),
weights, offset=NULL, alpha = 1, nlambda = 100,
lambda.min.ratio = ifelse(nobs<nvars,0.01,0.0001), lambda=NULL,
standardize = TRUE, intercept=TRUE, thresh = 1e-07, dfmax = nvars + 1,
pmax = min(dfmax * 2+20, nvars), exclude, penalty.factor = rep(1, nvars),
lower.limits=-Inf, upper.limits=Inf, maxit=100000,
type.gaussian=ifelse(nvars<500,"covariance","naive"),
type.logistic=c("Newton","modified.Newton"),
standardize.response=FALSE, type.multinomial=c("ungrouped","grouped"))

#======================================================================================================================
#  Read a sample training set
#======================================================================================================================
# start with simple regression (linear probability model) to speed up
#import related libraryies
library('Matrix')
library('glmnet')
library(doSNOW)
cl <- makeCluster(3, type = "SOCK")
registerDoSNOW(cl)


fileNumber = 2
inputPath = "C:\\Users\\mxh109420\\Desktop\\KaggleCometition\\train\\train"
inputPathTest = "C:\\Users\\mxh109420\\Desktop\\KaggleCometition\\test\\test"
inputFile = paste(inputPath , fileNumber ,".csv", sep="")#input File i
testFile  = paste(inputPathTest , fileNumber ,".csv", sep="")#test File i

# read into memory
inputData <- read.table(inputFile , header=TRUE)
sparseMatrixData <- do.call(sparseMatrix, inputData )
## worked with inputData  and cleanup
rm(inputData)
gc() # call garbage collection
dim(sparseMatrixData)

# prepare data
y = sparseMatrixData[,1]
x = sparseMatrixData[,2:ncol(sparseMatrixData)]
rm(sparseMatrixData)
gc() # call garbage collection
#class(x) #still sparse matrix
#class(y) # now numeric and not sparse matrix anymore

# test logistic regression: stackoverflow.com/questions/3169371/large-scale-regression-in-r-with-a-sparse-feature-matrix
#---------------
glmnet.fit <- glmnet(x, y,family = "binomial")
gc()

# to do cross validation we can use:
# cv.fit <- cv.glmnet(x, y, alpha = 1, nfolds=5,type.measure="mse")

#=======================
# test section
#=======================
# now that I have the model I can discard the training data to create a space for test data
rm(x)
rm(y)
gc()

# read test data into memory
inputData <- read.table(testFile, header=TRUE)
sparseMatrixData <- do.call(sparseMatrix, inputData )
## worked with inputData  and cleanup
rm(inputData)
gc() # call garbage collection
dim(sparseMatrixData)

# prepare data
IDs = sparseMatrixData[,1]
x = sparseMatrixData[,2:ncol(sparseMatrixData)]
rm(sparseMatrixData)
gc() # call garbage collection

# predict on the test set (dim x test is:  [4577463 x 16413] while dim of training x is: [40428963 x 16413])
bestlam=glmnet.fit$lambda.min
prediction = predict(glmnet.fit, x,s=0.001,type="response")
predict(glmnet.fit,x,s="lambda.1se") # make predictions

write.table(x, file = "foo.csv", sep = ",", col.names = NA,
            qmethod = "double")

# test glm
fit = glmnet(x, y, family=c("gaussian","binomial","poisson","multinomial","cox","mgaussian"),
weights, offset=NULL, alpha = 1, nlambda = 100,
lambda.min.ratio = ifelse(nobs<nvars,0.01,0.0001), lambda=NULL,
standardize = TRUE, intercept=TRUE, thresh = 1e-07, dfmax = nvars + 1,
pmax = min(dfmax * 2+20, nvars), exclude, penalty.factor = rep(1, nvars),
lower.limits=-Inf, upper.limits=Inf, maxit=100000,
type.gaussian=ifelse(nvars<500,"covariance","naive"),
type.logistic=c("Newton","modified.Newton"),
standardize.response=FALSE, type.multinomial=c("ungrouped","grouped"))
