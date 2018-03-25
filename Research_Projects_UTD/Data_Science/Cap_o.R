#' ![](http://www.flyreagan.com/sites/default/files/c_one_core_ng_rgb_r.png)
#-----------------------------------------------------
# c One Challange
# Meisam Hejazi Nia
# 07/24/2016
#-----------------------------------------------------

#' ---
#' title: "c One Data Science Challange"
#' output:
#'     html_document: 
#'      theme: cerulean
#'      toc: yes
#'      css: C:/Users/Meisam/Desktop/cOne/custom.css
#' ---


#+ echo=FALSE
rm(list = ls())
options(warn=-1)

#+ package_options, include=FALSE
library("knitr")
library("rmarkdown")
opts_knit$set(progress = TRUE, verbose = TRUE)

#+ global_options, include=FALSE
opts_chunk$set(dpi = 96, fig.width = 15, fig.height = 6,fig.fullwidth = TRUE, echo = FALSE)

#+ include=TRUE
suppressMessages({
  options(stringsAsFactors = FALSE)
  library(ggplot2)
  library(data.table)
  library(magrittr)
  library(dplyr)
  library(tidyr)
  library(readr)
  library(stringr)
  library(scales)
  library(lubridate)
  library(tidyr)
  library(cowplot)
  library(RCurl)
})

#' # Question 1
#' #### Programmatically download and load into your favorite analytical tool the trip data for September 2015.
#------------------------------------------------------
# Data link
# https://storage.googleapis.com/tlc-trip-data/2015/green_tripdata_2015-09.csv
# install.packages("curl")


# data from September 2015
#+ echo=TRUE
#SepDT <- fread('https://storage.googleapis.com/tlc-trip-data/2015/green_tripdata_2015-09.csv')
#+ echo=FALSE
#save(SepDT, file="September.GreenTaxi.Rdata")

load(file="C:/Users/Meisam/Documents/September.GreenTaxi.Rdata")
head(SepDT)%>% 
  kable
#-------------------------------------------------------------
#' #### Report how many rows and columns of data you have loaded.
#-------------------------------------------------------------
numberOfRows = paste('Number of Rows in the Data set are:', nrow(SepDT))
formatC(numberOfRows, format="d", big.mark=',')%>% kable

numberOfColumns = paste('Number of Columns in the Data set are:', ncol(SepDT))
formatC(numberOfColumns, format="d", big.mark=',')%>% kable

#---------------------------------------------------------
#' # Question 2
#---------------------------------------------------------
#' #### Plot a histogram of the number of the trip distance ("Trip Distance").
#------------------------------
ggplot(data=SepDT, aes(SepDT$Trip_distance)) + 
  geom_histogram(breaks=seq(min(SepDT$Trip_distance), quantile(SepDT$Trip_distance,0.99), by =0.5), 
                 col="red", 
                 aes(fill=..count..))+
  labs(title="Histogram for Trip Distance") +
  labs(x="Trip Distance", y="Count")

#' * For the sake of presentation, I cut the long tail.
#' * As expected the distribution of trip distances has long tail distribution. In other words, most of the trips have short distance, while there are a number of trips with very long distance.

#--------------------------
#' #### Report any structure you find and any hypotheses you have about that structure.
#' ##### Defining derived features
#---------------------------------
SepDT = setDT(SepDT)
#' * Duration of engagement of taxi meter
# convert dates 
#strptime(SepDT$Lpep_dropoff_datetime[1], "%Y-%m-%d %H:%M:%S")
SepDT[,Lpep_dropoff_datetimeCnvrt := as.POSIXct(strptime(Lpep_dropoff_datetime, "%Y-%m-%d %H:%M:%S"))]
SepDT[,lpep_pickup_datetimeCnvrt := as.POSIXct(strptime(lpep_pickup_datetime, "%Y-%m-%d %H:%M:%S"))]
SepDT[,TripDuration:=as.numeric(Lpep_dropoff_datetimeCnvrt - lpep_pickup_datetimeCnvrt,units = "mins")]

sampleSepDT = sample(1:nrow(SepDT),10000)

# take sample for the sake of tractability for visualization
sampleSepDT = SepDT[sampleSepDT,]

ggplot(sampleSepDT, aes(x=Trip_distance, y=TripDuration)) +
  geom_point(alpha=0.05, color="#c0392b") +
  scale_x_continuous(breaks=seq(0,50, by=5)) +
  scale_y_log10(labels=comma, breaks=10^(0:6)) +
  geom_hline(yintercept=1, size=0.4, color="black") +
  geom_smooth(alpha=0.25, color="black", fill="black") +
  labs(x="Trip Distance", y="Trip Duration", title="Correlation Between Trip Distance and Trip Duration")

#' * As expected short distnces might correspond to different Trip durations based on the traffic, but the effect of traffic will be removed as the distance increases.
#' * Other patterns is that there is no Unknown payment type, and there is no group ride, so it might be that these feature are not used at all.
#' * If I had more time I would use a factor model to find out the correlation between various variables, and how the factor loadings will indicate.
#' * If I had more time I would create coupld of new derived variables about time of day and day of week. Visualizing these variables would give a good pattern of peak and off-peak of traffic.
#' * If I had more time I would cluster the lattitude and longitudes to create variables that indicate various regions. I can imagine that these patterns or clusters of regions are correlated with fare time of travel, so they indicate different markets.
#' * If I had time I would also be interested to check whether trip types and type of payments are correlated, via a chi square test.

#---------------------------------------------------------
#' # Question 3
#---------------------------------------------------------
#' #### Report mean and median trip distance grouped by hour of day.
#------------------------------
SepDT[,Hour:=hour(lpep_pickup_datetimeCnvrt)]
hourlySummary = SepDT[,list(Mean.Distance =mean(Trip_distance), Median.Distance=median(Trip_distance)), by=Hour]

hourlySummaryMelted = melt(hourlySummary,id = 'Hour')

ggplot(hourlySummaryMelted, aes(Hour, value)) +   
  geom_bar(aes(fill = variable), position = "dodge", stat="identity")+
  labs(x="Hour", y="Distance", title="Mean and Median of Distance per Hour")

hourlySummary %>% kable

# ggplot(data=hourlySummaryMelted,
#        aes(x=Hour, y=value, colour=variable)) +
#   labs(x="Hour", y="Distance", title="Mean and Median of Distance per Hour")

#---------------------------------------------------------
#' #### We'd like to get a rough sense of identifying trips that originate or terminate at one of the NYC area airports. Can you provide a count of how many transactions fit this criteria, the average fair, and any other interesting characteristics of these trips.
#------------------------------

#identifying trips that originate or terminate at one of the NYC area airports. 
# count of how many transactions fit this criteria, 
# the average fair, and 
# any other interesting characteristics of these trips.

#' * it is possible to find the longitude and lattitude of the newyork Airports including LaGuardia, JFK and Newark, but I guessed this questions is chiefly concerned about identifying these through RateCodeID, so I followed this approach.

#2=JFK
#3=Newark

AirportTransactions = SepDT[RateCodeID %in% c(2,3),]
# dim(AirportTransactions)

paste0('Number of Transactions that are originated or terminated to NYC Airports are:',nrow(AirportTransactions),
       'Which are', format(round(nrow(AirportTransactions)/nrow(SepDT), 2), nsmall = 2), '% of the transactions.')%>% kable

#' * Other characteristics of trips that originate or terminate to NYC Airports are:
AirportTripSummary = rbind(
  AirportTransactions[,list(Item= 'Airport Trips', AverageFare= mean(Fare_amount),AverageExtera = mean(Extra),
                            AverageTax = mean(MTA_tax), AverageTipAmnt = mean(Tip_amount),
                            AverageTollAmnt = mean(Tolls_amount), AverageTotalAmnt = mean(Total_amount),
                            AverageHour = mean(Hour), TripDuration = mean(TripDuration), 
                            Trip_distance = mean(Trip_distance))],
  SepDT[,list(Item= 'All Trips', AverageFare= mean(Fare_amount),AverageExtera = mean(Extra),
              AverageTax = mean(MTA_tax), AverageTipAmnt = mean(Tip_amount),
              AverageTollAmnt = mean(Tolls_amount), AverageTotalAmnt = mean(Total_amount),
              AverageHour = mean(Hour), TripDuration = mean(TripDuration), 
              Trip_distance = mean(Trip_distance))]
)
  
AirportTripSummary %>% kable

#' * Airport trips on average have higher fare, as expected.
#' * Airport trips on average have less surcharges for rush hour and overnight.
#' * Airport trip on average pay more tolls than all the trips.
#' * Trip duration for airports on average is higher.
#' * Trip distances for airports are on average higher.

#---------------------------------------------------------
#' # Question 4
#---------------------------------------------------------
#' #### Build a derived variable for tip as a percentage of the total fare.
#------------------------------
#' * dropped items with Total Amount of zero as they are outliders
TipPCTDT = SepDT[Total_amount!=0,]
TipPCTDT[,TipPCT := Tip_amount/Total_amount]

# check the distribution of Trip Percentage
ggplot(data=TipPCTDT, aes(TipPCTDT$TipPCT)) + 
  geom_histogram(breaks=seq(min(TipPCTDT$TipPCT), max(TipPCTDT$TipPCT), by =0.01), 
                 col="red", 
                 aes(fill=..count..))+
  labs(title="Histogram for Tip Percentage") +
  labs(x="Tip PCT", y="Count")

#---------------------------------------------------------
#' #### Build a predictive model for tip as a percentage of the total fare. Use as much of the data as you like (or all of it). We will validate a sample.
#---------------------------------------------------------

#' * The tip percentage is a number between zero and one. Threfore logit transofmraiton can be used by defining $PCT = \frac{1}{1+e^{U}}$, where $U= X* \beta$, $\beta$ is the parameter, and $X$ are the varaibles
#' * To use the logit transformation, I invert the function so that $log(\frac{1-PCT}{PCT})=U=X \beta$, which is a linear model, given that we know log odds of PCT.

TipPCTDT[,LogOdds := log(1/(1-TipPCT))]

# nrow(TipPCTDT) #1490754
# nrow(TipPCTDT[LogOdds==0,]) #888137
# 888137/1490754 # 60% of items have infinite odds

#' * 60% of the log odds are zero, because of zero tips or cash tips, and we want to predict credit card tips. 
#' * The log odds technically has normal (Gaussian) distribution but with overloading number of zeros (which means the data is censored).
#' * Censored normal data can be modeled by Tobit model.
#' * There are variables such as Day of Week, Whether, Time of Day that can help to improve the prediction, but I did not have time to create them and explore more.
#' * I created dummy variable for each of the trip types: 1= Standard rate, 2=JFK,3=Newark,4=Nassau or Westchester,5=Negotiated fare,6=Group ride. Standard Rate is used as base, so dropped to avoid multicollinearity.
#' * I also created dummy variable for Payment type (as it is an important factor in censoring): 1= Credit card, 2= Cash, 3= No charge, 4= Dispute, 5= Unknown, 6= Voided trip. Voided Trip is used as base, so droped to avoid multicollinearity.
#' * Also if I had time I could have created a variable of whether a given fare is in high, medium or low fare relative to the fare of trips with the same distance and duration.
#' * If I had time, I would include the clustered location for origin and distination as each Origin-Distination might be represenative of a different market.
#take a sample
sampleTipPCTDT = sample(1:nrow(TipPCTDT),nrow(TipPCTDT))
sampleTipPCTDT = TipPCTDT[sampleTipPCTDT,]
sampleTipPCTDT = sampleTipPCTDT[!is.infinite(LogOdds),]

# dummy variable creation
sampleTipPCTDT[,Standard.rate:=ifelse(RateCodeID==1, 1, 0)]
sampleTipPCTDT[,JFK:=ifelse(RateCodeID==2, 1, 0)]
sampleTipPCTDT[,Newark:=ifelse(RateCodeID==3, 1, 0)]
sampleTipPCTDT[,NassauORWestchester:=ifelse(RateCodeID==4, 1, 0)]
sampleTipPCTDT[,RateCodeID:=ifelse(RateCodeID==5, 1, 0)]
sampleTipPCTDT[,GroupRide:=ifelse(RateCodeID==6, 1, 0)]
sampleTipPCTDT[,CreditCard:=ifelse(Payment_type==1, 1, 0)]
sampleTipPCTDT[,Cash:=ifelse(Payment_type==2, 1, 0)]
sampleTipPCTDT[,Nocharge:=ifelse(Payment_type==3, 1, 0)]
sampleTipPCTDT[,Dispute:=ifelse(Payment_type==4, 1, 0)]
sampleTipPCTDT[,Unknown:=ifelse(Payment_type==5, 1, 0)]
sampleTipPCTDT[,VoidedTrip:=ifelse(Payment_type==6, 1, 0)]

# there is no group ride so it has to be dropped
# there is no Unknown, so it has to be dropped
summary(lm(LogOdds ~ Trip_distance + TripDuration + JFK+
     Newark +    NassauORWestchester +   RateCodeID +
     CreditCard +   Cash +   Nocharge +
     Dispute  + Fare_amount + Extra + MTA_tax + improvement_surcharge + Tolls_amount +Total_amount, 
   data = sampleTipPCTDT))

#' * Running a linear model showed an R-square of 0.76, which suggests that these variables can explain the variation in tip very well.
#' * Although due to the large sample size, I expected that every variables effect would be significant, yet, Cash, No-Charge, and Dispute are not significant at all.
#' * Tobit model is a non-linear model so I need to take sample, otherwise it will not be computationally possible to use it

library(VGAM)
TobitSample = sample(1:nrow(TipPCTDT),40000)
sampleTipPCTDTTobit = sampleTipPCTDT[TobitSample,]

summary(m <- vglm(LogOdds ~ Trip_distance + TripDuration + JFK+
                  Newark +    NassauORWestchester +   RateCodeID +
                   CreditCard +   
                 #   Cash +   Nocharge + Dispute +  
                    Fare_amount + Extra + MTA_tax + improvement_surcharge + Tolls_amount +Total_amount, 
                  tobit(Lower = 0), data = sampleTipPCTDTTobit))

#' * I prefer Tobit model because first it captures the attribute of the data set, which is overloaded with zero
#' * Also tobit model is a form of Bayesian, and non-linear, so it does not overfit the data, unlike linear model
#' * The result of analysis of tobit model shows that tax and surcharge do not explain the tip, which is reasonable
#' * Newark trips have significantly more tips than other trips
#' * Total amount is positively correlated with tips
#' * As expected when the payment is credit card, there is a higher probability that the tip amount is not censored
#' * Paying toll will decrease the probability of getting tip (might be correlation and not causality) 
#' * If I had more time I would work more on the model selection, by fore example a step wise approach to find out which variables to include into the model. I would have used log likelihood or AIC/BIC as my model selection criteria.
#' * If I had more time I would use ensemble method over Tobit model for better prediction. Nowdays in Machine Learning litrature rather than using a single model they ensemble multiple models for better inference. In this case I would have taken multiple samples and get the estimated results. They I would use Mont Carlo estimation to generate the distribution from all the results, and then pull the simulated points to infer the actual distribution.

#---------------------------------------------------------
#' # Question 5
#---------------------------------------------------------
#' #### Choose only one of these options to answer for Question 5. There is no preference as to which one you choose. Please select the question that you feel your particular skills and/or expertise are best suited to. If you answer more than one, only the first will be scored.
#------------------------------

#---------------------------------------------------------
#' ### Option A: Distributions
#---------------------------------------------------------

#---------------------------------------------------------
#' ### Build a derived variable representing the average speed over the course of a trip.
#---------------------------------------------------------
# First remove items with Duration zero
SepDTDist = SepDT[TripDuration!=0,]
SepDTDist[,AverageSpeed:=Trip_distance/TripDuration]
# check the distribution of speed (it is large so take sample)
SepDTDistSample = sample(1:nrow(SepDTDist),10000)
SepDTDistSample = SepDTDist[SepDTDistSample,]
ggplot(data=SepDTDistSample, aes(SepDTDistSample$AverageSpeed)) + 
  geom_histogram(breaks=seq(min(SepDTDistSample$AverageSpeed), max(SepDTDistSample$AverageSpeed), by =1), 
                 col="red", 
                 aes(fill=..count..))+
  labs(title="Histogram for Average Speed") +
  labs(x="Average Speed", y="Count")

#quantile(SepDTDist$AverageSpeed,0.99) #0.5733114 
#' * As expected most of the trips have very low speed, most probably due to the traffic, but there are trips with very high speed.
  
#---------------------------------------------------------
#' ### Can you perform a test to determine if the average trip speeds are materially the same in all weeks of September? If you decide they are not the same, can you form a hypothesis regarding why they differ?
#---------------------------------------------------------
# t-test
# First Week: 2015-09-01 00:00:00 to 2015-09-06 00:00:00
FirstWeekStart = as.POSIXct(strptime("2015-09-01 00:00:00", "%Y-%m-%d %H:%M:%S"))
FirstWeekEnd = as.POSIXct(strptime("2015-09-06 00:00:00", "%Y-%m-%d %H:%M:%S"))
# Second Week: 2015-09-06 00:00:00 to 2015-09-13 00:00:00
SecondWeekStart = as.POSIXct(strptime("2015-09-06 00:00:00", "%Y-%m-%d %H:%M:%S"))
SecondWeekEnd = as.POSIXct(strptime("2015-09-13 00:00:00", "%Y-%m-%d %H:%M:%S"))
# Third Week: 2015-09-13 00:00:00 to 2015-09-20 00:00:00
ThirdWeekStart = as.POSIXct(strptime("2015-09-13 00:00:00", "%Y-%m-%d %H:%M:%S"))
ThirdWeekEnd = as.POSIXct(strptime("2015-09-20 00:00:00", "%Y-%m-%d %H:%M:%S"))
# Fourth Week: 2015-09-20 00:00:00 to 2015-09-27 00:00:00
FourthWeekStart = as.POSIXct(strptime("2015-09-20 00:00:00", "%Y-%m-%d %H:%M:%S"))
FourthWeekEnd = as.POSIXct(strptime("2015-09-27 00:00:00", "%Y-%m-%d %H:%M:%S"))
# Fifth Week: 2015-09-27 00:00:00 to 2015-10-01 00:00:00
FifthWeekStart = as.POSIXct(strptime("2015-09-27 00:00:00", "%Y-%m-%d %H:%M:%S"))
FifthWeekEnd = as.POSIXct(strptime("2015-10-01 00:00:00", "%Y-%m-%d %H:%M:%S"))
#SepDTDist$Lpep_dropoff_datetimeCnvrt[1]<SepDTDist$Lpep_dropoff_datetimeCnvrt[2]
FirstWeek = SepDTDist[FirstWeekStart<Lpep_dropoff_datetimeCnvrt & 
                        FirstWeekEnd>Lpep_dropoff_datetimeCnvrt,AverageSpeed]
SecondWeek = SepDTDist[SecondWeekStart<Lpep_dropoff_datetimeCnvrt & 
                         SecondWeekEnd>Lpep_dropoff_datetimeCnvrt,AverageSpeed]
ThirdWeek = SepDTDist[ThirdWeekStart<Lpep_dropoff_datetimeCnvrt & 
                        ThirdWeekEnd>Lpep_dropoff_datetimeCnvrt,AverageSpeed]
FourthWeek = SepDTDist[FourthWeekStart<Lpep_dropoff_datetimeCnvrt & 
                         FourthWeekEnd>Lpep_dropoff_datetimeCnvrt,AverageSpeed]
FifthWeek = SepDTDist[FifthWeekStart<Lpep_dropoff_datetimeCnvrt & 
                        FifthWeekEnd>Lpep_dropoff_datetimeCnvrt,AverageSpeed]

#' * Assuming that the estimate of speed mean has normal distribution by Central Limit Theorem, I take a given week and compare its mean with the mean of all other weeks via t-test.
#' * Although I am not using it here, but it might be better to use Bonferroni alpha, which in this case is $0.05/5=0.01$ for inference
t.test(FirstWeek, c(SecondWeek,ThirdWeek,FourthWeek,FifthWeek)) 
#' * As t-value for comparing the first week with the rest is $-0.10>-1.96$ the first week's average speed is not significantly different than other weeks.
t.test(SecondWeek, c(FirstWeek,ThirdWeek,FourthWeek,FifthWeek)) 
#' * As t-value for comparing the second week with the rest is $-1.83$ and p-value is $0.07$, based on Bonferroni alpha, second week has significantly less average speed.
#' * Labor day and Patriot day holidays might have affected the traffic pattern.
t.test(ThirdWeek, c(FirstWeek,SecondWeek,FourthWeek,FifthWeek)) 
#' * As t-value for comparing the third week with the rest is $-2.54<-1.96$, third week has significantly less average speed than other weeks.
#' * This week has 3 Jewish Holidays for RoshHashana, which might have resulted in couple of financial institutions to be less active.
t.test(FourthWeek, c(FirstWeek,SecondWeek,ThirdWeek,FifthWeek)) 
#' * As t-value for comparing tje fourth week with the rest is $2.21>1.96$, the fourth week has significantly more average speed than other weeks
#' * This week is the firt week of Fall with a Jewish (Yom Kippur) and Christian (St Matthew) holidays, which might have affected the traffic pattern negatively.
t.test(FifthWeek, c(FirstWeek,SecondWeek,ThirdWeek,FourthWeek)) 
#' * As t-value for comparing the fifth week with the rest is $0.889$, the fifth week does not have significantly different average speed.

#---------------------------------------------------------
#' ### Can you build up a hypothesis of average trip speed as a function of time of day?
#---------------------------------------------------------
# Night, Early Morning, Morning, Late Morning, Early Afternoon, Afternoon, Late Afternoon, Early Evening, Everning, Night
#' * I can expect that 7:00 to 9:00 in the morning there is high traffic (less speed) for school and work, and 4:00-7:00 pm will also follow the same pattern.

HourlySpeedSummary = SepDTDist[,list(AverageSpeed=mean(AverageSpeed)),by='Hour']

ggplot(HourlySpeedSummary, aes(Hour, AverageSpeed)) +   
  geom_bar( position = "dodge", stat="identity")+
  labs(x="Hour", y="Average Speed", title="Average Speed per Hour")


MorningPeak = SepDTDist[Hour>=7 & Hour<=9,AverageSpeed]
ExcludeMorning = SepDTDist[Hour<7 | Hour>9,AverageSpeed]
AfternoonPeak = SepDTDist[Hour>=16 & Hour<=19,AverageSpeed]
ExcludeAfternoon = SepDTDist[Hour<16 | Hour>19,AverageSpeed]

t.test(MorningPeak, ExcludeMorning) 
#' * As t-value to compare morning hour to the rest is $-1.32$, we can not reject the hypothesis that morning has the same average speed as the rest of the day.
t.test(AfternoonPeak, ExcludeAfternoon) 
#' * As t-value to compare afternoon peak hours (16-19) is $-3.30<-1.96$, we can reject the hypothesis that afternoon has the same average speed as the rest of the day, so we can conclude that afternoon has significantly less average speed than the rest of the day.
#' * If I had more time I would have spent sometime to search by a k-tree, anomaly detection by clustering tree approach, and I would also have touched the curiosity section.
