/* Meisam Hejazinia, mxh109420 Credit card model*/
PROC IMPORT OUT= WORK.creditcard 
            DATAFILE= "C:\Users\mxh109420\Documents\BPSMurthiHWs\HW6\cc_
data2.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;
proc freq data=creditcard;
tables rewards;
run;
proc freq data=creditcard;
tables affinity;
run;
proc means data=creditcard;
var limit profit;
run;
proc freq data=creditcard;
tables dm ds ts net;
run;
proc reg data=creditcard;
Model profit = totalfee affinity rewards limit numcard dm ds ts gold platinum quantum;
run;
proc means data=creditcard;
var totalfee affinity rewards limit numcard dm ds ts gold platinum quantum;
run;
proc logistic data=creditcard descending;
  class affinity rewards dm ds ts gold platinum quantum;
  Model active = affinity rewards limit numcard dm ds ts gold platinum quantum;
run;
proc logistic data=creditcard descending;
  class affinity rewards dm ds ts gold platinum quantum;
  Model active = affinity rewards limit numcard dm ds ts gold platinum quantum /link=probit;
run;
proc means data=creditcard;
var profit;
run;
proc qlim data=creditcard ;
  Model profit = totalfee affinity rewards limit numcard dm ds ts gold platinum quantum;
  endogenous profit ~ censored (lb= -772.1370250 ub=20557.3);
run;
proc qlim data=creditcard ;
	Model active = affinity rewards limit numcard dm ds ts gold platinum quantum /discrete;
	Model profit = totalfee affinity rewards limit numcard dm ds ts gold platinum quantum /select(active=1);
run;
