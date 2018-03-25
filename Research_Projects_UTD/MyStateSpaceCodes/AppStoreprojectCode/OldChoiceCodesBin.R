
# cl=makeCluster(7)
# registerDoSNOW(cl)
# set.seed(66)
# par(mfrow=c(3,1))


#======================================
# Old code of factor analysis
#======================================
#sum(is.nan(as.matrix(FactorModelData)))
#fit <- factanal(as.matrix(FactorModelData), 3, rotation="varimax")
#fit <- princomp(FactorModelData, cor=TRUE)
# summary(fit) # print variance accounted for 
# loadings(fit) # pc loadings 
# plot(fit,type="lines") # scree plot 
# fit$scores # the principal components
# biplot(fit)
#fit <- princomp(mydata, cor=TRUE) #cannot be used when p>n
#fit <- factanal(correctData, 3, rotation="varimax") #systm is computationally singular, reciprocal condition number = 0
# outputFilePath = "C:/Users/MeisamHe/Desktop/Desktop/Projects/MTNAppStore/SummarizeData/FactorModelData.csv"
# write.csv(FactorModelData, file = outputFilePath, fileEncoding = "UTF-16LE")


#------------------------------------------------------------------------
# Diffusion 
#------------------------------------------------------------------------
ncat = 10
T    = 258
categoryDiffData=read.csv("C:/Users/MeisamHe/Desktop/Projects/MTNAppStore/SummarizeData/GlobalCategoryDiffusion.csv",header=T)
# T=191
# categoryDiffData=read.csv("C:/Users/MeisamHe/Desktop/Projects/MTNAppStore/SummarizeData/CategoryDiffusion.csv",header=T)
categoryDiff= matrix(rep(0,ncat*T),ncol=ncat)
for (i in 1:ncat){
  categoryDiff[,i]=categoryDiffData[[i+1]]
}
categoryDiff=t(categoryDiff)
plot(categoryDiff[1,])

# seperate the total innovator and immitator
catlatent = categoryDiff
totalForce = t(apply(catlatent,1,diff))
plot(totalForce[1,])

# run NLLS on one
currentCat = 10
currentSales = totalForce[currentCat,]
currentSalesTemp = t(matrix(currentSales[1:(T-(T%%7))],nrow=7))
currentSales=rowSums(currentSalesTemp)
t(t(currentSales))
t = 1:length(currentSales)
result = nls(currentSales ~ m*(((1-exp(-(p+q)*t))/(1+q/p*exp(-(p+q)*t)))-((1-exp(-(p+q)*(t-1)))/(1+q/p*exp(-(p+q)*(t-1))))),
             data=list(currentSales=currentSales),
             start=list(p=0.002,q=0.2,m=500))
coef(summary(result))

#---------------------------------------------
#read the local and global diffusion level
#---------------------------------------------
#start with local level diffusion
#LocalDiffusionDecom=read.csv("C:/Users/MeisamHe/Desktop/Projects/MTNAppStore/SummarizeData/LocalDiffusionDecom.csv",header=T)
LocalDiffusionDecom=read.csv("C:/Users/MeisamHe/Desktop/Projects/MTNAppStore/SummarizeData/GlobalDiffusionDecomLatent.csv",header=T)
Tw = dim(LocalDiffusionDecom)[1]
LocalImitInovForce= array(rep(0,2*Tw*ncat),dim=c(Tw,ncat,2))
for (i in 1:ncat){
  LocalImitInovForce[1:Tw,i,1:2]=as.matrix(as.vector(LocalDiffusionDecom[,((2*(i-1))+2):((2*i)+1)]),ncol=2)
}

#negate to assume that it is about breath of the category
categoryChoicCharTemp= -matrix(categoryChoicCharData[[3]],ncol=1)

# create all U-shaped and normal variables
nDataChoiceChar = 5               # to account for u-shaped relationships
categoryChoicChar= matrix(rep(0,nDataChoiceChar*Tchoice*ncat),ncol=nDataChoiceChar)

# U shaped relationships
# paid apps
categoryChoicChar[,1] = categoryChoicCharTemp[,1] - mean(categoryChoicCharTemp[,1])
categoryChoicChar[,2] = categoryChoicCharTemp[,1]**2 - mean(categoryChoicCharTemp[,1]**2)

#Fremumness of the category
categoryChoicCharTemp= matrix(categoryChoicCharData[[4]],ncol=1)

# U shaped relationships
# paid apps
categoryChoicChar[,3] = categoryChoicCharTemp[,1] - mean(categoryChoicCharTemp[,1])
categoryChoicChar[,4] = categoryChoicCharTemp[,1]**2 - mean(categoryChoicCharTemp[,1]**2)

#Infancy of the category
categoryChoicCharTemp= matrix(categoryChoicCharData[[5]],ncol=1)
categoryChoicChar[,5] = categoryChoicCharTemp[,1] - mean(categoryChoicCharTemp[,1])

# to make sure I have corresponding weeks
# for local: 1220
# for global 1180
#lengthChoiceChar = 1220
#lengthChoiceChar = 1180

#---------------------------------------------------------------------------
# Read CategoryHB data
#===========================================================================
nzcat = 1
CategoryHBData=read.csv("C:/Users/MeisamHe/Desktop/Projects/MTNAppStore/SummarizeData/CategoryHB.csv",header=T)
CategoryHB= matrix(rep(0,ncat*nzcat),ncol=nzcat)
CategoryHB[,1]=CategoryHBData[[3]]


#-----------------------------------------------------------------------------------------------
# Old Codes
#-----------------------------------------------------------------------------------------------

# run NLLS on one (Jain and Rao 1990)
currentCat = 4
currentSales = totalForce[currentCat,]
t = 1:length(currentSales)
result = nls(currentSales ~ (m-categoryDiff[currentCat,])*
               (((1-exp(-(p+q)*t))/(1+(q/p)*exp(-(p+q)*t)))-((1-exp(-(p+q)*(t-1)))/(1+(q/p)*exp(-(p+q)*(t-1)))))/(1-((1-exp(-(p+q)*(t-1)))/(1+(q/p)*exp(-(p+q)*(t-1))))),
             data=list(currentSales=currentSales),
             start=list(p=0.002,q=0.2,m=5000))
coef(summary(result))