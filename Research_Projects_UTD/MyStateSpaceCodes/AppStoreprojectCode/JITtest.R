#=======================================================================
# JIT: compile the functions to speed up
#========================================================================
require(compiler)
library(compiler)
enableJIT(3)

slow_func_compiled <- cmpfun(StateSpaceJoshiVanDenBulte12282014func)

##### Functions #####

is.compile <- function(func)
{
  # this function lets us know if a function has been byte-coded or not
  #If you have a better idea for how to do this - please let me know...
  if(class(func) != "function") stop("You need to enter a function")
  last_2_lines <- tail(capture.output(func),2)
  any(grepl("bytecode:", last_2_lines)) # returns TRUE if it finds the text "bytecode:" in any of the last two lines of the function's print
}

is.compile(slow_func_compiled)



#==========================================================
# Running the program in just in time mode to speed up (it will only print every 5 transactions on 
# the screen, and the rest are printed in the file)
#===========================================================

logfilename = paste ('C:/Users/MeisamHe/Desktop/Desktop/BackupToRestoreComputerApril15/MyProjectSummary/MyStateSpaceCodes/AppStoreprojectCode/LogExecution/',
                     'logfileDec28.log')
categoryDiffData=read.csv("C:/Users/MeisamHe/Desktop/Desktop/Projects/MTNAppStore/SummarizeData/GlobalCategoryDiffusion.csv",header=T)
CategoryHBData=read.csv("C:/Users/MeisamHe/Desktop/Desktop/Projects/MTNAppStore/SummarizeData/CategoryHB.csv",header=T)


resultOfFiltering = slow_func_compiled(logfilename,categoryDiffData,CategoryHBData)

# result list contains: thetacatjdraw,ccat_,Y1cat_,categoryDiffWeekly,Deltadrawthetacatj,
#bcat_,probdrawthetacatj,llcat_,MADcat_,MSEcat_, ,compdrawthetacatj in order

#=============================================================================
# running octav from R
#=============================================================================
#install.packages("RcppOctave")
#install.packages("Rcpp")
#install.packages("pkgmaker")
path_to_file = "C:\\Users\\MeisamHe\\Desktop\\Desktop\\Projects\\RegretInAuction\\VariationalBayesian\\vdpgm\\RcppOctave_0.14.5.tar.gz"
install.packages(path_to_file, repos = NULL, type="source")
library("RcppOctave")

#============================================================================
# Do the analysis and plot the results
#============================================================================

#Check convergance plots
plot(alphaidraw[1,4,])
plot(gammaIndvdraw[2,1,])
plot(thetacatjdraw[2,2,])

# test confidence interval
#thetacatj
apply(thetacatjdraw,c(2,1),quantile,probs=c(0.05,0.95))
apply(thetacatjdraw,c(1,2),mean)
apply(thetacatjdraw,c(1,2),sd)

#variances
apply(ccat_,1,quantile,probs=c(0.05,0.95))
apply(ccat_,1,mean)
apply(ccat_,1,sd)

#Check Forecast
ForecastCatMean= apply(Y1cat_,c(1,2),mean)
plot(ForecastCatMean[3,])
plot(categoryDiffWeekly[3,])

#Deltadrawthetacatj
apply(Deltadrawthetacatj,2,quantile,probs=c(0.05,0.95))
apply(Deltadrawthetacatj,2,mean)
apply(Deltadrawthetacatj,2,sd)

#bcat_ 
apply(bcat_,1,quantile,probs=c(0.05,0.95))
apply(bcat_,1,mean)
apply(bcat_,1,sd)


nmix=list(probdraw=probdrawthetacatj ,zdraw=NULL,compdraw=compdrawthetacatj         )
attributes(nmix)$class="bayesm.nmix"
png(filename="C:/Users/mxh109420/Desktop/MobileAppProject/heterogeneityLocalDiff.png")
plot(nmix)
dev.off()

# Test convergance one by one
iindx = 3
jindx = 1
quantile(thetacatjdraw[iindx,jindx,],probs=c(0.05,0.95))
mean(thetacatjdraw[iindx,jindx,])
