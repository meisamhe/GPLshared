
#-----------------------------------------------------------------
# Descriptive Curves
#-----------------------------------------------------------------

#Local level forces
par(mfrow=c(3,1))
LocalDiffusionDecom=read.csv("C:/Users/MeisamHe/Desktop/Projects/MTNAppStore/SummarizeData/LocalDiffusionDecomLatent.csv",header=T)
#LocalDiffusionDecom=read.csv("C:/Users/MeisamHe/Desktop/Projects/MTNAppStore/SummarizeData/GlobalDiffusionDecomLatent.csv",header=T)

Tw = dim(LocalDiffusionDecom)[1]
LocalImitInovForce= array(rep(0,2*Tw*ncat),dim=c(Tw,ncat,2))
for (i in 1:ncat){
   LocalImitInovForce[1:Tw,i,1:2]=as.matrix(as.vector(LocalDiffusionDecom[,((2*(i-1))+2):((2*i)+1)]),ncol=2)
}

#Check Curves of STEP ahead Forecast
categorynumber=2
plot(1:Tw,LocalImitInovForce[,categorynumber,1],type="l",col="blue",xlab=" ",ylab="Force Level")
par(new=TRUE)
plot(1:Tw,LocalImitInovForce[,categorynumber,2],col="brown1",xlab="Week",ylab="Force Level",type="l")
title("Innovation/Immitation Force Evolution (eBooks)")

categorynumber=9
plot(1:Tw,LocalImitInovForce[,categorynumber,1],type="l",col="blue",xlab=" ",ylab="Force Level")
par(new=TRUE)
plot(1:Tw,LocalImitInovForce[,categorynumber,2],col="brown1",xlab="Week",ylab="Force Level",type="l")
title("Innovation/Immitation Force Evolution (Social NW)")

categorynumber=3
plot(1:Tw,LocalImitInovForce[,categorynumber,1],type="l",col="blue",xlab=" ",ylab="Force Level")
par(new=TRUE)
plot(1:Tw,LocalImitInovForce[,categorynumber,2],col="brown1",xlab="Week",ylab="Force Level",type="l")
title("Innovation/Immitation Force Evolution (Games)")


#Global level forces
par(mfrow=c(3,1))
LocalDiffusionDecom=read.csv("C:/Users/MeisamHe/Desktop/Projects/MTNAppStore/SummarizeData/GlobalDiffusionDecomLatent.csv",header=T)

Tw = dim(LocalDiffusionDecom)[1]
LocalImitInovForce= array(rep(0,2*Tw*ncat),dim=c(Tw,ncat,2))
for (i in 1:ncat){
   LocalImitInovForce[1:Tw,i,1:2]=as.matrix(as.vector(LocalDiffusionDecom[,((2*(i-1))+2):((2*i)+1)]),ncol=2)
}

#Check Curves of STEP ahead Forecast
categorynumber=2
plot(1:Tw,LocalImitInovForce[,categorynumber,1],type="l",col="blue",xlab=" ",ylab="Force Level")
par(new=TRUE)
plot(1:Tw,LocalImitInovForce[,categorynumber,2],col="brown1",xlab="Week",ylab="Force Level",type="l")
title("Innovation/Immitation Force Evolution (eBooks)")

categorynumber=9
plot(1:Tw,LocalImitInovForce[,categorynumber,1],type="l",col="blue",xlab=" ",ylab="Force Level")
par(new=TRUE)
plot(1:Tw,LocalImitInovForce[,categorynumber,2],col="brown1",xlab="Week",ylab="Force Level",type="l")
title("Innovation/Immitation Force Evolution (Social NW)")

categorynumber=3
plot(1:Tw,LocalImitInovForce[,categorynumber,1],type="l",col="blue",xlab=" ",ylab="Force Level")
par(new=TRUE)
plot(1:Tw,LocalImitInovForce[,categorynumber,2],col="brown1",xlab="Week",ylab="Force Level",type="l")
title("Innovation/Immitation Force Evolution (Games)")
