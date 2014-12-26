retailSales<-read.csv("d:/HW12TS.csv",header=T) # read whole data
# from Jan 1955 to Dec 1975 as a time series object
rsts <- ts(retailSales, start=c(1955, 1), end=c(1977, 12), frequency=12) 
#excluding last two years
rtsm <- window(rsts, start=c(1955,1), end=c(1975,12))
#plot time series
plot(rsts)
plot.ts(rtsm)
#convert to additive
lrtsm <- log(rtsm)
plot.ts(lrtsm)
# Decomposition
library("TTR")
lrtsm6 <- SMA(lrtsm,n=6)
plot.ts(lrtsm6)
lrtsm12 <- SMA(lrtsm,n=12)
plot.ts(lrtsm12)
#Decomposition
lrtsmcomp<- decompose(lrtsm)
# Holt winter exponential smoothing
lrtsmforecast<- HoltWinters(lrtsm, beta=FALSE, gamma=FALSE)
lrtsmforecast$SSE
# forecast without data
library("forecast")
hwfwd <- forecast.HoltWinters(lrtsmforecast, h=24)
plot(hwfwd)
accuracy(hwfwd ) # predictive accuracy
#plot predicted value versus real value
rtsmf <- window(rsts, start=c(1976,1), end=c(1977,12))
rtsmfl<-log(rtsmf)
confl95<-hwfwd$lower[,2]
plot(confl95, type="l" , col=2)
par(new=T)
confu95<-hwfwd$upper[,2]
plot(confu95, type="l" , col=2)
par(new=T)
plot(rtsmfl,type="b",axes=F,col=3)
par(new=F)
#check correlogram 
acf(hwfwd$residuals, lag.max=20)
#Ljung-Box test 
Box.test(hwfwd$residuals, lag=20, type="Ljung-Box")
plot.ts(hwfwd$residuals)
#Check normality of residuals
plotForecastErrors <- function(forecasterrors)
  {
     # make a histogram of the forecast errors:
     mybinsize <- IQR(forecasterrors)/4
     mysd   <- sd(forecasterrors)
     mymin  <- min(forecasterrors) - mysd*5
     mymax  <- max(forecasterrors) + mysd*3
     # generate normally distributed data with mean 0 and standard deviation mysd
     mynorm <- rnorm(10000, mean=0, sd=mysd)
     mymin2 <- min(mynorm)
     mymax2 <- max(mynorm)
     if (mymin2 < mymin) { mymin <- mymin2 }
     if (mymax2 > mymax) { mymax <- mymax2 }
     # make a red histogram of the forecast errors, with the normally distributed data overlaid:
     mybins <- seq(mymin, mymax, mybinsize)
     hist(forecasterrors, col="red", freq=FALSE, breaks=mybins)
     # freq=FALSE ensures the area under the histogram = 1
     # generate normally distributed data with mean 0 and standard deviation mysd
     myhist <- hist(mynorm, plot=FALSE, breaks=mybins)
     # plot the normal curve as a blue line on top of the histogram of forecast errors:
     points(myhist$mids, myhist$density, type="l", col="blue", lwd=2)
  }
plotForecastErrors(hwfwd$residuals)
qqnorm(hwfwd$residuals, ylab="Holt Winter Multiplicative", xlab="Normal Scores", main="Notmsl pp Holt Winter Multiplicative") 
qqline(hwfwd$residuals)
# ARIMA
lrtsm1 <- diff(lrtsm , differences=1)
plot.ts(lrtsm1)
lrtsm2 <- diff(lrtsm , differences=2)
plot.ts(lrtsm2)
# determine degree of ARIMA
acf(lrtsm1 , lag.max=20)    #11 
pacf(lrtsm1, lag.max=20) #19
# fit an ARIMA model of order P, D, Q
fit <- arima(lrtsm, order=c(0, 1, 11))
accuracy(fit) # predictive accuracy
forecast(fit, 24)
plot(forecast(fit, 24))
# Automated forecasting using an ARIMA model
fit <- auto.arima(lrtsm)
accuracy(fit) # predictive accuracy
forecast(fit, 24)
plot(forecast(fit, 24))

# Automated forecasting using an exponential model
fit <- ets(lrtsm)
accuracy(fit) # predictive accuracy
forecast(fit, 24)
plot(forecast(fit, 24))
spectrum(rsts)