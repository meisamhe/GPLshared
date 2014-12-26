Libname HW7 "C:\Users\mxh109420\Documents\BPSMurthiHWs\HW7Survival";
Data HW7.bank;
set HW7.Cc_surv;
if inactive='Y' then delete;
run;
proc print data=Hw7.bank (obs=29);
var close_date;
run;
data HW7.Bankd (keep= PROD_ACCT_NO CURRENT_BALANCE CUR_CREDIT_LINE AFFINITY_FLAG ALPHA_STATE CARD_COUNT ACQ_FLAG PRODFLAG STATUS CDATE RDATE CSDate DUR TTR TTC Reward);
  array m{12}$ ('JAN','FEB','MAR','APR','MAY','JUN','JUL','AUG','SEP','OCT','NOV','DEC');
  set HW7.Bank;
  /* convert close_date*/
  if length(close_date)>9 then do;
	day=substr(close_date,1,2);
	dayn=put(day,2.0);
	month=substr(close_date,3,3);
	year=substr(close_date,6,4);
	yearn=put(year,4.0);
   end;
  do i=1 to 12;
  	if month=m(i) then monthn=i;
  end;
  cdate=MDY(monthn,dayn,yearn);
  DUR=cdate-MDY(6,30,2000);
  format cdate date9. ;
  /* convert first retail date*/
  if length(FIRST_RETAIL_DT)>9 then do;
	day=substr(FIRST_RETAIL_DT,1,2);
	dayn=put(day,2.0);
	month=substr(FIRST_RETAIL_DT,3,3);
	year=substr(FIRST_RETAIL_DT,6,4);
	yearn=put(year,4.0);
   end;
  do i=1 to 12;
  	if month=m(i) then monthn=i;
  end;
  RDATE=MDY(monthn,dayn,yearn);
  TTR=RDATE-MDY(6,30,2000);
  format RDATE date9. ;
	/* convert CASH DATE*/
    if length(FIRST_CASH_DATE)>9 then do;
	day=substr(FIRST_CASH_DATE,1,2);
	dayn=put(day,2.0);
	month=substr(FIRST_CASH_DATE,3,3);
	year=substr(FIRST_CASH_DATE,6,4);
	yearn=put(year,4.0);
   end;
  do i=1 to 12;
  	if month=m(i) then monthn=i;
  end;
  CSDATE=MDY(monthn,dayn,yearn);
  TTC=CSDATE-MDY(6,30,2000);
  format CSDATE date9. ;
  drop i month year day;
run;
/* test whether survival curves are parallel*/
proc lifetest data=HW7.Bankd plots=(s);
  time Dur;
  strata AFFINITY_FLAG;
run;
proc lifetest data=HW7.Bankd plots=(s);
  time Dur;
  strata CARD_COUNT;
run;
proc lifetest data=HW7.Bankd plots=(s);
  time Dur;
  strata ACQ_FLAG;
run;
proc lifetest data=HW7.Bankd plots=(s);
  time Dur;
  strata PRODFLAG;
run;
proc lifetest data=HW7.Bankd plots=(s);
  time Dur;
  strata Reward;
run;
proc phreg data=HW7.Bankd;
  model Dur = CUR_CREDIT_LINE AFFINITY_FLAG2 AFFINITY_FLAG3 
	CARD_COUNT ACQ_FLAG2 ACQ_FLAG3 ACQ_FLAG4 PRODFLAG2  
	PRODFLAG3 PRODFLAG4 TTC TTR Reward1;
  /* compare with non endorsed*/
  AFFINITY_FLAG2 = (AFFINITY_FLAG='A');
  AFFINITY_FLAG3 = (AFFINITY_FLAG='F');
  AFFINITY_FLAG: test AFFINITY_FLAG2, AFFINITY_FLAG3;
  /* compared with internet*/
  ACQ_FLAG2=(ACQ_FLAG="Tele Marketing");
  ACQ_FLAG3=(ACQ_FLAG="Direct Mail");
  ACQ_FLAG4=(ACQ_FLAG="Direct Promotions");
  ACQ_FLAG: test ACQ_FLAG2, ACQ_FLAG3, ACQ_FLAG4;
  /* compared with standard*/
  PRODFLAG2=(PRODFLAG="Platinum Plus");
  PRODFLAG3=(PRODFLAG="Quantum");
  PRODFLAG4=(PRODFLAG="Premium");
  ACQ_FLAG: test PRODFLAG2, PRODFLAG3, PRODFLAG4;
  /* reward compared with No*/
  Reward1=(Reward="YES");
 run;
 DATA HW7.Bankdlr;
 set HW7.Bankd;
 /* compare with non endorsed*/
  AFFINITY_FLAG2 = (AFFINITY_FLAG='A');
  AFFINITY_FLAG3 = (AFFINITY_FLAG='F');
  /* compared with internet*/
  ACQ_FLAG2=(ACQ_FLAG="Tele Marketing");
  ACQ_FLAG3=(ACQ_FLAG="Direct Mail");
  ACQ_FLAG4=(ACQ_FLAG="Direct Promotions");
  /* compared with standard*/
  PRODFLAG2=(PRODFLAG="Platinum Plus");
  PRODFLAG3=(PRODFLAG="Quantum");
  PRODFLAG4=(PRODFLAG="Premium");
  /* reward compared with No*/
  Reward1=(Reward="YES");
run;
proc lifereg data=HW7.Bankdlr;
  model Dur = CUR_CREDIT_LINE AFFINITY_FLAG2 AFFINITY_FLAG3 
	CARD_COUNT ACQ_FLAG2 ACQ_FLAG3 ACQ_FLAG4 PRODFLAG2  
	PRODFLAG3 PRODFLAG4 TTC TTR Reward1/dist=lnormal;
 run;
 proc lifereg data=HW7.Bankdlr;
  model Dur = CUR_CREDIT_LINE AFFINITY_FLAG2 AFFINITY_FLAG3 
	CARD_COUNT ACQ_FLAG2 ACQ_FLAG3 ACQ_FLAG4 PRODFLAG2  
	PRODFLAG3 PRODFLAG4 TTC TTR Reward1/dist=Weibull ;
 run;
  proc lifereg data=HW7.Bankdlr;
  model Dur = CUR_CREDIT_LINE AFFINITY_FLAG2 AFFINITY_FLAG3 
	CARD_COUNT ACQ_FLAG2 ACQ_FLAG3 ACQ_FLAG4 PRODFLAG2  
	PRODFLAG3 PRODFLAG4 TTC TTR Reward1/dist=exponential ;
 run;
   proc reg data=HW7.Bankdlr;
  model Dur = CUR_CREDIT_LINE AFFINITY_FLAG2 AFFINITY_FLAG3 
	CARD_COUNT ACQ_FLAG2 ACQ_FLAG3 ACQ_FLAG4 PRODFLAG2  
	PRODFLAG3 PRODFLAG4 TTC TTR Reward1 ;
 run;
