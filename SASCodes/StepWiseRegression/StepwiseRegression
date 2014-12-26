crime<-read.csv("d:/eleventh.csv",header=T) # read whole data
cr=crime[,1] # crime rate
cov=crime[,2:14] # covariates
summary(cov)# check summary of data
cor(cov) #check the correlation
pairs(cov) # check plot of correlations
plot(cov[,1], cr, main="Age and crime rate", xlab="Age", ylab="Crime rate", pch=19)
plot(cov[,2], cr, main="Southern states and crime rate", xlab="Southern states", ylab="Crime rate", pch=19)
plot(cov[,3], cr, main="Schooling and crime rate", xlab="Schooling", ylab="Crime rate", pch=19)
plot(cov[,4], cr, main="1960 plice expenditure", xlab="1960 police expenditure", ylab="Crime rate", pch=19)
plot(cov[,5], cr, main="1959 plice expenditure", xlab="1959 police expenditure", ylab="Crime rate", pch=19)
plot(cov[,6], cr, main="Labor force participation", xlab="Labor force participation", ylab="Crime rate", pch=19)
plot(cov[,7], cr, main="Male/Female rate", xlab="male/female rate", ylab="Crime rate", pch=19)
plot(cov[,8], cr, main="State population", xlab="State population", ylab="Crime rate", pch=19)
plot(cov[,9], cr, main="Non white", xlab="non white", ylab="Crime rate", pch=19)
plot(cov[,10], cr, main="Unemployment rate 14-24", xlab="unemployment rate 14-24", ylab="Crime rate", pch=19)
plot(cov[,11], cr, main="Unemployment rate 25-35", xlab="unemployment rate 25-35", ylab="Crime rate", pch=19)
plot(cov[,12], cr, main="Transferable goods and assets", xlab="Transferable goods and assets", ylab="Crime rate", pch=19)
plot(cov[,13], cr, main="Below median income", xlab="Families Below median income", ylab="Crime rate", pch=19)
qqnorm(cr, ylab="Crime rate", xlab="Normal Scores", main="Normal probability plot of crime rate") 
qqline(cr)
names(cov)
crd = d=as.matrix(cr)
covd = d=as.matrix(cov)
cdata=cbind(cr,cov)
model1 = lm(cr~Age+S+Ed+Ex0+Ex1+LF+M+N+NW+U1+U2+W+X,data=cdata)
step(model1, direction="backward")
step(model1, direction="forward")
step(model1, direction="both",trace=TRUE)
par(mfrow=c(2,2))    # visualize four graphs at once
plot(model1)
par(mfrow=c(1,1))  # reset the graphics defaults


