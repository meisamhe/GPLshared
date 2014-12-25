
#-------------------------------------------------------------------------------
# simulation of app-store project data to show identification
# By: Meisam Hejazi Nia
# Date July 7th
#-------------------------------------------------------------------------------
rm(list=ls(pattern="^tmp"))
rm(list=ls())
library(bayesm)
library(foreach)
library(doSNOW)
cl=makeCluster(6)
registerDoSNOW(cl)
set.seed(66)
par(mfrow=c(3,1))
#-------------------------------------------------------------------------------
# naming is important to have enough resemblance to writing
#================================================================================
T = 347 # total duration of our sample

#-------------------------------------------------------------------------------
# first: simulate state space of category in a for loop for j=1...J (HB)+ complementarity
# HB includes: popularity of category
#-------------------------------------------------------------------------------
nzcat=1         #category popularity as explanator (J)
ncat=17       # number of categories under study
Zcat=matrix(runif(nzcat*ncat),ncol=nzcat)
Zcat=t(t(Zcat)-apply(Zcat,2,mean))          # demean Zcat, popularity explanator of category
ncompcat= 3                                 # no of mixture components of category is consider 3
Deltacat=matrix(runif((ncat+2))*1e-20,ncol=1) # generate Delta for thetacat=Deltacat*Zcat+ujcat
Deltacat[1,]=0.0003 # set p's mean data
Deltacat[2,]=0.001 # set q's mean data
Deltacat[3,]=1000 # set Cj's mean data
compscat=NULL
compscat[[1]]=list(mu=runif(ncat+2)*1e-6,rooti=diag(rep(1,ncat+2)*1e6))
compscat[[2]]=list(mu=runif(ncat+2)*1e-7,rooti=diag(rep(1,ncat+2)*1e6))
compscat[[3]]=list(mu=runif(ncat+2)*1e-9,rooti=diag(rep(1,ncat+2)*1e6))
pveccat=c(.4,.2,.4)

# error of the state equationn for the diffusion of category
wcat = 0.5*diag(ncat)
ewcat = t(chol(wcat))%*%matrix(rnorm(ncat*T,mean=0,sd=1),ncol=T)

catlatent = matrix(5*runif(ncat*T),ncol=T);   # initialize state and allocate space
thetacatj = matrix(rep(1,ncat*(ncat+2)),ncol=ncat+2)
colnames(thetacatj) <- c("p","q","Cj",c(1:(ncat-1)))
for (t in 2:T){
   # treat first eelement differently
   i = 1
   if (t==2){   # only generate thetaj=(pj,qj,Cj,lambdakj) once
      thetacatj[i,]=Deltacat%*%Zcat[i,]+as.vector(rmixture(1,pveccat,compscat)$x)
      # make sure that market size (M), p and q are positive for the sake of simulation
      thetacatj[i,1]=abs(thetacatj[i,1]);
      thetacatj[i,2]=abs(thetacatj[i,2]);
      thetacatj[i,3]=abs(thetacatj[i,3]);
   }
   catlatent[i,t]=catlatent[i,t-1]+
      (thetacatj[i,"p"]+thetacatj[i,"q"]*(catlatent[i,t-1]/thetacatj[i,"Cj"])+
          thetacatj[i,(i+3):(ncat+2)]%*%catlatent[(i+1):ncat,t-1])*
      (thetacatj[i,"Cj"]-catlatent[i,t-1])+ewcat[i,t];
   # treat element in the middle
   for (i in 2:(ncat-1)){
      if (t==2){   # only generate thetaj=(pj,qj,Cj,lambdakj) once
         thetacatj[i,]=Deltacat%*%Zcat[i,]+as.vector(rmixture(1,pveccat,compscat)$x)
         # make sure that market size (M), p and q are positive for the sake of simulation
         thetacatj[i,1]=abs(thetacatj[i,1]);
         thetacatj[i,2]=abs(thetacatj[i,2]);
         thetacatj[i,3]=abs(thetacatj[i,3]);
      }
      catlatent[i,t]=catlatent[i,t-1]+
         (thetacatj[i,"p"]+thetacatj[i,"q"]*(catlatent[i,t-1]/thetacatj[i,"Cj"])+
             thetacatj[i,4:(i+2)]%*%catlatent[1:(i-1),t-1]+
             thetacatj[i,(i+3):(ncat+2)]%*%catlatent[(i+1):ncat,t-1])*
         (thetacatj[i,"Cj"]-catlatent[i,t-1])+ewcat[i,t];
   }
   # treat last element differently
   i = ncat;
   if (t==2){   # only generate thetaj=(pj,qj,Cj,lambdakj) once
      thetacatj[i,]=Deltacat%*%Zcat[i,]+as.vector(rmixture(1,pveccat,compscat)$x)
      # make sure that market size (M), p and q are positive for the sake of simulation
      thetacatj[i,1]=abs(thetacatj[i,1]);
      thetacatj[i,2]=abs(thetacatj[i,2]);
      thetacatj[i,3]=abs(thetacatj[i,3]);
   }
   catlatent[i,t]=catlatent[i,t-1]+
      (thetacatj[i,"p"]+thetacatj[i,"q"]*(catlatent[i,t-1]/thetacatj[i,"Cj"])+
          thetacatj[i,4:(i+2)]%*%catlatent[1:i-1,(t-1)])*
      (thetacatj[i,"Cj"]-catlatent[i,t-1])+ewcat[i,t];
}
# check the data generated
plot( catlatent[1,], type="l")
plot( catlatent[2,], type="l")
for (i in 1:ncat){
   plot( catlatent[i,],type="l")
   par(ask=TRUE)
}

#-------------------------------------------------------------------------------
# second: simulate state space of mobile app in a for loop for j=1...J (HB) + complementarity
# HB includes: continent decomposition of app (asia, europe, africa, US)
#-------------------------------------------------------------------------------
numappInCateg=c(3,6,5,7,3,4,3,5,3,2,2,6,2,7,6,2,2);   # number of app's in each category
maxappIncat   = max(numappInCateg)    # to balance the data on complement and substitute within the category
appCategoryIndex=c(0,cumsum(numappInCateg)) # for indexing in using latent
nzapps=4         #search continent decomposition (asia, europe, africa, US) (A)
napps=68       # number of apps under study
Zapp=matrix(runif(nzapps*napps),ncol=nzapps)
Zapp=t(t(Zapp)-apply(Zapp,2,mean))          # demean Zapp, popularity explanator of apps
ncompapp= ncat                                # no of mixture components of app is consider ncat
Deltaapp=matrix(runif((maxappIncat+2)*nzapps)*1e-20,ncol=nzapps) # generate Delta for thetacat=Deltacat*Zcat+ujcat
Deltaapp[1,]=0.0003 # set p's mean data
Deltaapp[2,]=0.001 # set q's mean data
Deltaapp[3,]=0.5# set alpha a's mean data
compsapp=NULL
for (i in 1:ncompapp){
      compsapp[[i]]=list(mu=runif(ncat+2)*(10**(-6-i)),rooti=diag(rep(1,ncat+2)*(10**(6+i))))
}
pvecapp=rep(1/ncompapp,ncompapp) # assume equal probability of mixture

# error of the state equationn for the diffusion of apps
# wapps = 0.5*diag(napps)
# ewapps = t(chol(wapps))%*%matrix(rnorm(napps*T,mean=0,sd=1),ncol=T)
ewapps = list();
appslatent = list();
for (j in 1:ncat) { #given category
   wapps = 0.5*diag(numappInCateg[j])
   ewapps[[j]]=t(chol(wapps))%*%matrix(5*runif(numappInCateg[j]*T),ncol=T);
   appslatent[[j]]=matrix(5*runif(numappInCateg[j]*T),ncol=T);
}

# addressing appslatent[[j]][a,t]
#appslatent = matrix(5*runif(napps*T),ncol=T);   # initialize state and allocate space
thetaappa = matrix(rep(1e-15,napps*(maxappIncat+2)),ncol=maxappIncat+2)
colnames(thetaappa) <- c("p","q","alphaj",c(1:(maxappIncat-1)))
for (t in 2:T){
  for (j in 1:ncat) { #given category
      # treat first eelement differently
      i = 1
      if (t==2){   # only generate thetaj=(pj,qj,Cj,lambdakj) once
         thetaappa[appCategoryIndex[j]+i,1:(appCategoryIndex[j+1]-appCategoryIndex[j]+2)]=Deltaapp[1:(appCategoryIndex[j+1]-appCategoryIndex[j]+2),]%*%Zapp[i,]+as.vector(rmixture(1,pvecapp,compsapp)$x)[1:(appCategoryIndex[j+1]-appCategoryIndex[j]+2)]
         # make sure that alpha, p and q are positive for the sake of simulation
         thetaappa[appCategoryIndex[j]+i,1]=abs(thetaappa[appCategoryIndex[j]+i,1]) # set p's mean data to positive number
         thetaappa[appCategoryIndex[j]+i,2]=abs(thetaappa[appCategoryIndex[j]+i,2]) # set q's mean data to positive number
         thetaappa[appCategoryIndex[j]+i,3]=abs(thetaappa[appCategoryIndex[j]+i,3]) # set alpha a's mean data to positive number
      }
#       appslatent[appCategoryIndex[j]+i,t]=appslatent[appCategoryIndex[j]+i,t-1]+
#          (thetaappa[i,"p"]+thetaappa[i,"q"]*(appslatent[appCategoryIndex[j]+i,t-1]/(thetaappa[i,"alphaj"]* catlatent[j,t]))+
#              thetaappa[i,(i+3):(appCategoryIndex[j+1]-appCategoryIndex[j]+2)]%*%appslatent[(appCategoryIndex[j]+i+1):appCategoryIndex[j+1],t-1])*
#          ((thetaappa[i,"alphaj"]* catlatent[j,t])-appslatent[appCategoryIndex[j]+i,t-1])+
#          ewapps[appCategoryIndex[j]+i,t]
         appslatent[[j]][i,t]=appslatent[[j]][i,t-1]+
            (thetaappa[i,"p"]+thetaappa[i,"q"]*(appslatent[[j]][i,t-1]/(thetaappa[i,"alphaj"]* catlatent[j,t]))+
                thetaappa[i,(i+3):(appCategoryIndex[j+1]-appCategoryIndex[j]+2)]%*%appslatent[[j]][(i+1):numappInCateg[j],t-1])*
            ((thetaappa[i,"alphaj"]* catlatent[j,t])-appslatent[[j]][i,t-1])+
            ewapps[[j]][i,t]
      
      #===================== treat element in the middle===================
      if ((numappInCateg[j]-1)>=2){
         for (i in 2:(numappInCateg[j]-1)){
            if (t==2){   # only generate thetaj=(pj,qj,Cj,lambdakj) once
               thetaappa[appCategoryIndex[j]+i,1:(appCategoryIndex[j+1]-appCategoryIndex[j]+2)]=Deltaapp[1:(appCategoryIndex[j+1]-appCategoryIndex[j]+2),]%*%Zapp[i,]+as.vector(rmixture(1,pvecapp,compsapp)$x)[1:(appCategoryIndex[j+1]-appCategoryIndex[j]+2)]
               # make sure that alpha, p and q are positive for the sake of simulation
               thetaappa[appCategoryIndex[j]+i,1]=abs(thetaappa[appCategoryIndex[j]+i,1]) # set p's mean data to positive number
               thetaappa[appCategoryIndex[j]+i,2]=abs(thetaappa[appCategoryIndex[j]+i,2]) # set q's mean data to positive number
               thetaappa[appCategoryIndex[j]+i,3]=abs(thetaappa[appCategoryIndex[j]+i,3]) # set alpha a's mean data to positive number
            }
#             appslatent[appCategoryIndex[j]+i,t]=appslatent[appCategoryIndex[j]+i,t-1]+
#                (thetaappa[i,"p"]+thetaappa[i,"q"]*(appslatent[appCategoryIndex[j]+i,t-1]/(thetaappa[i,"alphaj"]* catlatent[j,t]))+
#                    thetaappa[i,4:(i+2)]%*%appslatent[(appCategoryIndex[j]+1):(appCategoryIndex[j]+i-1),t-1]+
#                    thetaappa[i,(i+3):(appCategoryIndex[j+1]-appCategoryIndex[j]+2)]%*%appslatent[(appCategoryIndex[j]+i+1):appCategoryIndex[j+1],t-1])*
#                ((thetaappa[i,"alphaj"]* catlatent[j,t])-appslatent[appCategoryIndex[j]+i,t-1])+
#                ewapps[appCategoryIndex[j]+i,t]
               appslatent[[j]][i,t]=appslatent[[j]][i,t-1]+
                  (thetaappa[i,"p"]+thetaappa[i,"q"]*(appslatent[[j]][i,t-1]/(thetaappa[i,"alphaj"]* catlatent[j,t]))+
                      thetaappa[i,4:(i+2)]%*%appslatent[[j]][1:(i-1),t-1]+
                      thetaappa[i,(i+3):(appCategoryIndex[j+1]-appCategoryIndex[j]+2)]%*%appslatent[[j]][(i+1):numappInCateg[j],t-1])*
                  ((thetaappa[i,"alphaj"]* catlatent[j,t])-appslatent[[j]][i,t-1])+
                  ewapps[[j]][i,t]
         }
      }
      #=======================treat last element differently================
      i = numappInCateg[j];
      if (t==2){   # only generate thetaj=(pj,qj,Cj,lambdakj) once
         thetaappa[appCategoryIndex[j]+i,1:(appCategoryIndex[j+1]-appCategoryIndex[j]+2)]=Deltaapp[1:(appCategoryIndex[j+1]-appCategoryIndex[j]+2),]%*%Zapp[i,]+as.vector(rmixture(1,pvecapp,compsapp)$x)[1:(appCategoryIndex[j+1]-appCategoryIndex[j]+2)]
         # make sure that alpha, p and q are positive for the sake of simulation
         thetaappa[appCategoryIndex[j]+i,1]=abs(thetaappa[appCategoryIndex[j]+i,1]) # set p's mean data to positive number
         thetaappa[appCategoryIndex[j]+i,2]=abs(thetaappa[appCategoryIndex[j]+i,2]) # set q's mean data to positive number
         thetaappa[appCategoryIndex[j]+i,3]=abs(thetaappa[appCategoryIndex[j]+i,3]) # set alpha a's mean data to positive number
      }
#       appslatent[appCategoryIndex[j]+i,t]=appslatent[appCategoryIndex[j]+i,t-1]+
#          (thetaappa[i,"p"]+thetaappa[i,"q"]*(appslatent[appCategoryIndex[j]+i,t-1]/(thetaappa[i,"alphaj"]* catlatent[j,t]))+
#              thetaappa[i,4:(i+2)]%*%appslatent[(appCategoryIndex[j]+1):(appCategoryIndex[j]+i-1),t-1])*
#          ((thetaappa[i,"alphaj"]* catlatent[j,t])-appslatent[appCategoryIndex[j]+i,t-1])+
#          ewapps[appCategoryIndex[j]+i,t]
         appslatent[[j]][i,t]=appslatent[[j]][i,t-1]+
            (thetaappa[i,"p"]+thetaappa[i,"q"]*(appslatent[[j]][i,t-1]/(thetaappa[i,"alphaj"]* catlatent[j,t]))+
                thetaappa[i,4:(i+2)]%*%appslatent[[j]][1:(i-1),t-1])*
            ((thetaappa[i,"alphaj"]* catlatent[j,t])-appslatent[[j]][i,t-1])+
            ewapps[[j]][i,t]
  }
}
plot( appslatent[[1]][1,],type="l")
plot( appslatent[[2]][2,],type="l")
for (j in 1:ncat){
   for (i in 1:numappInCateg[j]){
       plot(appslatent[[j]][i,],type="l")
       par(ask=TRUE)
   }
}

#-------------------------------------------------------------------------------
# third: simulate locations latent of category with HB=1...L
# HB includes population of each location
#-------------------------------------------------------------------------------
nzloc=1         #location population as explanator (L)
nloc=27         # number of locations under study
Zloc=matrix(10*runif(nzloc*nloc),ncol=nzloc)
Zloc=t(t(Zloc)-apply(Zloc,2,mean))          # demean Zloc, population explanator of location
ncomploc= 4                                 # no of mixture components of location is consider 4, number of continents
Deltaloc=matrix(runif(1)*1e-1,ncol=1)      # generate Delta for catloclatent=Deltaloc*Zloc+ujloc
compsloc=NULL
compsloc[[1]]=list(mu=runif(1)*1e-6,rooti=diag(1)*1e9)
compsloc[[2]]=list(mu=runif(1)*1e-7,rooti=diag(1)*1e9)
compsloc[[3]]=list(mu=runif(1)*1e-8,rooti=diag(1)*1e9)
compsloc[[4]]=list(mu=runif(1)*1e-9,rooti=diag(1)*1e9)
pvecloc=c(.3,.2,.1,.4)

# error of the observation equationn for the diffusion of category across locations
evcat = list()
catloclatent = list()
for (l in 1:nloc){
   vloc = 0.01*diag(ncat)
   evcat[[l]] = t(chol(vloc))%*%matrix(rnorm(ncat*T,mean=0,sd=1),ncol=T)
   catloclatent[[l]] = matrix(5*runif(ncat*T),ncol=T);   # initialize state and allocate space
}
gammalocl = matrix(rep(1,nloc),ncol=1)
for (t in 1:T){
   for (l in 1:nloc){ # numerate across all categories
      if (t==1){   # only generate thetaj=(pj,qj,Cj,lambdakj) once
         gammalocl[l,]=Deltaloc%*%Zloc[l,]+as.vector(rmixture(1,pvecloc,compsloc)$x)
      }
      if (l==1){
         gammalocl[l,]=1; # normalization for identification
      }
         catloclatent[[l]][1:ncat,t]=gammalocl[l,]*catlatent[1:ncat,t]+evcat[[l]][1:ncat,t]
   }
}
# check the data generated
plot( catloclatent[[l]][1,], type="l")
plot( catloclatent[[2]][2,], type="l")
for (l in 1:nloc){
   for (j in 1:ncat){
      plot( catloclatent[[l]][j,], type="l")
      par(ask=TRUE)
   }   
}
#-------------------------------------------------------------------------------
# fourth: simulation location latent of mobile apps with HB=1...L
# HB includes population of each location
#-------------------------------------------------------------------------------
nzloc2=1         #location population as explanator (L)
nloc2=27         # number of locations under study
Zloc2=matrix(10*runif(nzloc2*nloc2),ncol=nzloc2)
Zloc2=t(t(Zloc2)-apply(Zloc2,2,mean))          # demean Zloc2, population explanator of location
ncomploc2= 4                                 # no of mixture components of location is consider 4, number of continents
Deltaloc2=matrix(runif(1)*1e-1,ncol=1)       # generate Delta for catloclatent=Deltaloc*Zloc+ujloc
compsloc2=NULL
compsloc2[[1]]=list(mu=runif(1)*1e-6,rooti=diag(1)*1e9)
compsloc2[[2]]=list(mu=runif(1)*1e-7,rooti=diag(1)*1e9)
compsloc2[[3]]=list(mu=runif(1)*1e-8,rooti=diag(1)*1e9)
compsloc2[[4]]=list(mu=runif(1)*1e-9,rooti=diag(1)*1e9)
pvecloc2=c(.2,.1,.3,.4)

# error of the observation equationn for the diffusion of category across locations
evcat2 = list()
evcat2temp = list()
apploclatent = list()
applatenttemp=list()
for (l in 1:nloc2){ # given location all apps inside
   applatenttemp=list()
   for (j in 1:ncat){
      vloc2 = 0.01*diag(numappInCateg[j])
      evcat2temp[[j]] = t(chol(vloc2))%*%matrix(rnorm(numappInCateg[j]*T,mean=0,sd=1),ncol=T)
      applatenttemp[[j]]=matrix(5*runif(numappInCateg[j]*T),ncol=T);
      
   }
   apploclatent[[l]] = applatenttemp   # initialize state and allocate space
   evcat2[[l]]=evcat2temp
}
etalocl = matrix(rep(1,nloc2),ncol=1)
for (t in 1:T){
   for (l in 1:nloc2){ # numerate across all categories
      if (t==1){   # only generate thetaj=(pj,qj,Cj,lambdakj) once
         etalocl[l,]=Deltaloc%*%Zloc2[l,]+as.vector(rmixture(1,pvecloc2,compsloc2)$x)
      }
      if (l==1){
         etalocl[l,]=1; # normalization for identification
      }
      for (j in 1:ncat){ # numerate across all locations         
         apploclatent[[l]][[j]][1:numappInCateg[j],t]=etalocl[l,]*appslatent[[j]][numappInCateg[j],t]+
            evcat2[[l]][[j]][1:numappInCateg[j],t]
      }
   }
}
# check the data generated
plot( apploclatent[[l]][[1]][1,], type="l")
plot( apploclatent[[2]][[2]][2,], type="l")
for (l in 1:nloc){
   for (j in 1:ncat){
      plot( apploclatent[[l]][[j]][1,], type="l")
      par(ask=TRUE)
   }   
}

#-------------------------------------------------------------------------------
# fifth: simulate individual perception of latent of category
#-------------------------------------------------------------------------------
locIndvDist=c(1532,2093,25,307,5,30,3145,82,453,336,1924,443,368,31,12,42,122,1326,19,77,1014,30,1186,2922,231,82,458)
locIndvDist=ceiling(locIndvDist/10)
locIndvDistIndex=c(0,cumsum(locIndvDist)) # for indexing in using latent
nzIndv=1         #individual's tenure as explanator (L)
nIndv=sum(locIndvDist)         # number of individuals under study
locIndv = c(rep(0,nIndv))
for (i in 1:nloc){
      locIndv[locIndvDistIndex[i]+1:locIndvDistIndex[i+1]]=i
}
ZIndv=matrix(10*runif(nzIndv*nIndv),ncol=nzIndv)
ZIndv=t(t(ZIndv)-apply(ZIndv,2,mean))      # demean ZIndv, population explanator of Individuals
ncompIndv= nloc                                # no of mixture components of Individuals is consider number of locations
DeltaIndv=matrix(runif(1)*1e-1,ncol=1)      # generate Delta for catloclatent=Deltaloc*Zloc+ujloc
compsIndv=NULL
for (i in 1:ncompIndv){
   compsIndv[[i]]=list(mu=runif(1)*1e-9,rooti=diag(1)*1e9)
}
pvecIndv=rep(1/ncompIndv,ncompIndv)    # equally likely

# error of the observation equationn for the diffusion of category, locations across individuals
# I can not use cholesky of big matrix so assume that they are independent
evIndv = array(rep(0,nIndv*ncat*T),dim=c(nIndv,ncat,T))
for (l in 1:nloc){  # category and location misperception
   for (j in 1:ncat){
      print(paste("location:",l,"category:",j))
      vIndv = 0.01*diag(locIndvDist[l])   # number of individuals in a given location
      evIndv[((locIndvDistIndex[l]+1):locIndvDistIndex[l+1]),,]=t(chol(vIndv))%*%matrix(rnorm(locIndvDist[l]*T,mean=0,sd=1),ncol=T)
      
   }
}
catlocIndvlatent= array(5*runif(ncat*nIndv*T),dim=c(nIndv,ncat,T))
gammaIndv = matrix(rep(1,nIndv),ncol=1)
# first set the coefficients
#foreach (j=1:ncat,.packages=c("bayesm"),.combine=cbind) %dopar%{
for (l in 1:nloc){ # numerate across all locations
   cat(paste("location:",l),fill=TRUE)
   #for (i in 1:locIndvDist[l]){  #all individuals within the location
   temp=foreach (i=1:locIndvDist[l],.packages=c("bayesm"),.combine=cbind) %dopar%{
      #cat(paste("time:",t,"category:",j,"location:",l,"individual:",i),fill=TRUE)
      if ( i!=1){   # only generate thetaj=(pj,qj,Cj,lambdakj) once
         #gammaIndv[locIndvDistIndex[l]+i,]= 
            DeltaIndv%*%ZIndv[locIndvDistIndex[l]+i,]+as.vector(rmixture(1,pvecIndv,compsIndv)$x)
      }else{
         1  # normalization for identification
      }
      #catlocIndvlatent[locIndvDistIndex[l]+i,t]=gammaIndv[locIndvDistIndex[l]+i,]*catloclatent[(j-1)*nloc+l,t]+
      #   evIndv[locIndvDistIndex[l]+i,t]
   }
   gammaIndv[(locIndvDistIndex[l]+1):(locIndvDistIndex[l]+locIndvDist[l]),]=temp
}


# second set the latent measure of misperception of individuals
for (t in 1:T){
   for (j in 1:ncat){ # numerate across all categories
      #foreach (j=1:ncat,.packages=c("bayesm"),.combine=cbind) %dopar%{
      for (l in 1:nloc){ # numerate across all locations
         cat(paste("time:",t,"category:",j,"location:",l),fill=TRUE)
         #for (i in 1:locIndvDist[l]){  #all individuals within the location
         catlocIndvlatent[((locIndvDistIndex[l]+1):locIndvDistIndex[l+1]),j,t]=
            gammaIndv[(locIndvDistIndex[l]+1):(locIndvDistIndex[l]+locIndvDist[l]),]*
         catloclatent[[l]][j,t]+evIndv[((locIndvDistIndex[l]+1):locIndvDistIndex[l+1]),j,t]
      }
   }
}

# check the data generated
plot( catlocIndvlatent[1,1,], type="l")
plot( catlocIndvlatent[2,2,], type="l")
for (i in 1:nIndv){
   for (j in 1:ncat){
      plot( catlocIndvlatent[i,j,],type="l")
      par(ask=TRUE)
   }
}

#-------------------------------------------------------------------------------
# sixth: simulate individual perception of latent of apps
#-------------------------------------------------------------------------------
nzIndv2=1                      #individual's tenure as explanator (L)
nIndv2=sum(locIndvDist)         # number of individuals under study
ZIndv2=matrix(10*runif(nzIndv2*nIndv2),ncol=nzIndv2)
ZIndv2=t(t(ZIndv2)-apply(ZIndv2,2,mean))       # demean ZIndv2, population explanator of Individuals
ncompIndv2= nloc2                                # no of mixture components of Individuals is consider number of locations
DeltaIndv2=matrix(runif(1)*1e-1,ncol=1)      # generate Delta for catloclatent=Deltaloc*Zloc+ujloc
compsIndv2=NULL
for (i in 1:ncompIndv2){
   compsIndv2[[i]]=list(mu=runif(1)*1e-9,rooti=diag(1)*1e9)
}
pvecIndv2=rep(1/ncompIndv2,ncompIndv2)    # equally likely

# error of the observation equationn for the diffusion of category, locations across individuals
# I can not use cholesky of big matrix so assume that they are independent
evIndv2 = list()
appslocIndvlatent = list()
for (j in 1:ncat){  # category and location misperception
   # create for all individuals in any location
   evIndv2[[j]]=array(rep(0,nIndv*numappInCateg[j]*T),dim=c(nIndv,numappInCateg[j],T))
   appslocIndvlatent[[j]]=array(5*runif(nIndv*numappInCateg[j]*T),dim=c(nIndv,numappInCateg[j],T)) # allocate space
   for (l in 1:nloc){
      # allocate space
      # initialize state and allocate space:
      for (a in 1:numappInCateg[j]){
         print(paste("location:",l,"category:",j, "app",a))
         vIndv2 = 0.01*diag(locIndvDist[l])   # number of individuals in a given location
         evIndv2[[j]][((locIndvDistIndex[l]+1):locIndvDistIndex[l+1]),a,]= t(chol(vIndv2))%*%matrix(rnorm(locIndvDist[l]*T,mean=0,sd=1),ncol=T)
      }
   }
}
  
etaIndv = matrix(rep(1,nIndv2),ncol=1)
# first set the coefficients
#foreach (j=1:ncat,.packages=c("bayesm"),.combine=cbind) %dopar%{
for (l in 1:nloc){ # numerate across all locations
   cat(paste("location:",l),fill=TRUE)
   #for (i in 1:locIndvDist[l]){  #all individuals within the location
   temp=foreach (i=1:locIndvDist[l],.packages=c("bayesm"),.combine=cbind) %dopar%{
      #cat(paste("time:",t,"category:",j,"location:",l,"individual:",i),fill=TRUE)
      if ( i!=1){   # only generate thetaj=(pj,qj,Cj,lambdakj) once
         #gammaIndv[locIndvDistIndex[l]+i,]= 
         DeltaIndv2%*%ZIndv2[locIndvDistIndex[l]+i,]+as.vector(rmixture(1,pvecIndv2,compsIndv2)$x)
      }else{
         1  # normalization for identification
      }
      #catlocIndvlatent[locIndvDistIndex[l]+i,t]=gammaIndv[locIndvDistIndex[l]+i,]*catloclatent[(j-1)*nloc+l,t]+
      #   evIndv[locIndvDistIndex[l]+i,t]
   }
   etaIndv[(locIndvDistIndex[l]+1):(locIndvDistIndex[l]+locIndvDist[l]),]=temp
}

# second set the latent measure of misperception of individuals
for (t in 1:T){
   for (j in 1:ncat){ # numerate across all categories
      for (a in 1:numappInCateg[j]){
         #foreach (j=1:ncat,.packages=c("bayesm"),.combine=cbind) %dopar%{
         for (l in 1:nloc){ # numerate across all locations
            cat(paste("time:",t,"app:",a,"location:",l),fill=TRUE)
            #for (i in 1:locIndvDist[l]){  #all individuals within the location
            appslocIndvlatent[[j]][((locIndvDistIndex[l]+1):locIndvDistIndex[l+1]),a,t]=
               etaIndv[(locIndvDistIndex[l]+1):(locIndvDistIndex[l]+locIndvDist[l]),]*
               apploclatent[[l]][[j]][a,t]+
               evIndv2[[j]][((locIndvDistIndex[l]+1):locIndvDistIndex[l+1]),a,t]
         }
      }
   }
}

# check the data generated
plot( appslocIndvlatent[[1]][1,1,], type="l")
plot( appslocIndvlatent[[2]][2,2,], type="l")
for (i in 1:nIndv){
   for (j in 1:ncat){
      plot( appslocIndvlatent[[j]][i,1,], type="l")
      par(ask=TRUE)
   }
}


#-------------------------------------------------------------------------------
# seventh: simulate app level data (tenure, feature, size)
#-------------------------------------------------------------------------------
appchar = list(); # characteristics of an app
for (j in 1:ncat) { #given category
   tenure=round(runif(numappInCateg[j])*347)
   dayincrement<-as.vector(sapply(1:T, function (x) rep(x,numappInCateg[j]))) # day increment of tenure
   appchar[[j]]= array(rep(1,T*numappInCateg[j]*3),dim=c(T,numappInCateg[j],3))
   appchar[[j]][,,1]=t(matrix(tenure+dayincrement,ncol=T))                #Tenure
   appchar[[j]][,,2]=t(matrix(round(runif(numappInCateg[j]*T)),ncol=T))    # Feature
   appchar[[j]][,,3]= t(matrix(runif(numappInCateg[j]*T)*80,ncol=T))      #Size                  
}

#-------------------------------------------------------------------------------
# eight: simulate category level parameters ( (1) Variance of price, 
#(2) mean of file size, (3) mean of tenure of apps inside, (4) total number of free apps 
# (5) total number of paid apps)
#-------------------------------------------------------------------------------
catchar = array(rep(1,T*ncat*5),dim=c(T,ncat,5)); # characteristics of an app
for (j in 1:ncat) { #given category
   catchar[,j,1]=t(matrix(runif(T)*39,ncol=T))    #Variance of price
   catchar[,j,2]=t(matrix(t(colSums(t(appchar[[j]][,,3])))+runif(T)*20,ncol=T))    #file size with pertubration
   catchar[,j,3]=t(matrix(t(colSums(t(appchar[[j]][,,1])))+runif(T)*80,ncol=T))    #tenure with pertubration
   catchar[,j,4]=t(matrix(round(runif(T)*100),ncol=T))    #total number of free apps
   catchar[,j,5]=t(matrix(round(runif(T)*20),ncol=T))    #total number of free apps                
}

#-------------------------------------------------------------------------------
# ninth: simulate individual with HB of tenure of each individual
# start at moment 1 and create choice and state space for individual
# state of individual for category includes: number of app's in each category
# state of individual for app includes downloads of app in each category [nc*na(c)]
#-------------------------------------------------------------------------------
dummyNoPurchaseCat=c(rep(0,T)); # for no cat download option
dummyNoPurchaseApp=c(rep(0,T)); # for no app download option
indvCatState = array(rep(0,T*nIndv*ncat),dim=c(T,nIndv,ncat))   # start with no prior download as it is starting point of this app store
indvAppState = list()
# add one element for apps within the category but other than these 
for (j in 1:ncat) { #given category
   indvAppState[[j]]= array(rep(0,T*nIndv*(numappInCateg[j]+1)),dim=c(T,nIndv,numappInCateg[j]+1))              
}

#---------------------------------------------------
#              HB for individual for category choice
#---------------------------------------------------
ncatcoefficients = 7            # for all 7 coefficients of utility
nzIndv3=1                       #individual's tenure as explanator (L)
nIndv3=sum(locIndvDist)         # number of individuals under study
ZIndv3=matrix(10*runif(nzIndv3*nIndv3),ncol=nzIndv3)
ZIndv3=t(t(ZIndv3)-apply(ZIndv3,2,mean))       # demean ZIndv3, population explanator of Individuals
ncompIndv3= nloc                                # no of mixture components of Individuals is consider number of locations
DeltaIndv3=matrix(runif(ncatcoefficients)*1e-1,ncol=1)         
compsIndv3=NULL
for (i in 1:ncompIndv3){
   compsIndv3[[i]]=list(mu=runif(ncatcoefficients)*1e-9,rooti=diag(ncatcoefficients)*1e9)
}
pvecIndv3=rep(1/ncompIndv3,ncompIndv3)    # equally likely
#---------------------------------------------------
#              HB for individual for app choice
#---------------------------------------------------
nappcoefficients = 5            # for all 5 coefficients of utility
nzIndv4=1                       #individual's tenure as explanator (L)
nIndv4=sum(locIndvDist)         # number of individuals under study
ZIndv4=matrix(10*runif(nzIndv4*nIndv4),ncol=nzIndv4)
ZIndv4=t(t(ZIndv4)-apply(ZIndv4,2,mean))       # demean ZIndv3, population explanator of Individuals
ncompIndv4= nloc                                # no of mixture components of Individuals is consider number of locations
DeltaIndv4=matrix(runif(nappcoefficients)*1e-1,ncol=1)         
compsIndv4=NULL
for (i in 1:ncompIndv4){
   compsIndv4[[i]]=list(mu=runif(nappcoefficients)*1e-9,rooti=diag(nappcoefficients)*1e9)
}
pvecIndv4=rep(1/ncompIndv4,ncompIndv4)    # equally likely

#-----------------------------------------------------
#                  Simulating Choice
#-----------------------------------------------------
# individual coefficients for category and app
alphai = matrix(rep(0,nIndv*ncatcoefficients),ncol=ncatcoefficients)
betai  = matrix(rep(0,nIndv*nappcoefficients),ncol=nappcoefficients)
simmnlwX= function(n,X,beta) {
   ##  simulate from MNL model conditional on X matrix
   k=length(beta)
   Xbeta=X%*%beta
   j=nrow(Xbeta)/n
   Xbeta=matrix(Xbeta,byrow=TRUE,ncol=j)
   Prob=exp(Xbeta)
   iota=c(rep(1,j))
   denom=Prob%*%iota
   Prob=Prob/as.vector(denom)
   y=vector("double",n)
   ind=1:j
   for (i in 1:n) 
   {yvec=rmultinom(1,1,Prob[i,]); y[i]=ind%*%yvec}
   return(list(y=y,X=X,beta=beta,prob=Prob))
}
simCatChoice=NULL
for (i in 1:nIndv3){       # given individual
   # create individual coefficients of utility for category and app choice
   alphai=DeltaIndv3%*%ZIndv3[i,]+as.vector(rmixture(1,pvecIndv3,compsIndv3)$x)
   betai =DeltaIndv4%*%ZIndv4[i,]+as.vector(rmixture(1,pvecIndv4,compsIndv4)$x) 
   simCatChoice[[i]]=c(rep(0,T))
   for (t in 1:T){         # given time
      Xa=as.vector(t(cbind(indvCatState[t,i,],indvCatState[t,i,],catchar[t,,])))
      X=createX(ncat,na=dim(alphai)[1],nd=NULL,Xa=Xa,Xd=NULL,base=1)
      outa=simmnlwX(1,X,betai)
      simCatChoice[[i]][t]=list(y=outa$y,X=X,beta=betai)
      for (j in 1:ncat){   # given category
         
      }
   }
}





#=====================================================================================
#                            End of Simulating the data
#=====================================================================================