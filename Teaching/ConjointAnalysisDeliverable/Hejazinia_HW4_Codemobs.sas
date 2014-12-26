title 'Preference for Chocolate Candies';
/* 
Brand - 3 levels - (Complete, Smile, Wave)
Scent  3 levels - (fresh, lemon, Unscented)
Whether there was a softener or not (Y, N) 2 levels
Size of packet (32, 48, 64) 3 levels
Price (2.99, 3.99, 4.99) 3 levels
1-9 point scale with 9 indicating a higher preference.*/
data dtrgntchc;
input brand	$ scent $	soft $	oz	pr	s1	s2	S3	s4	s5 s6	s7	S8	s9	s10;	
datalines;	 	 	 	 	 	 	 	 	 	 	 	 	 	 
complete	fresh	n	48	4.99	1	3	3	2	2	1	3	3	2	2
complete	fresh	y	32	2.99	1	3	3	5	5	2	3	3	5	5
complete	lemon	n	32	2.99	1	2	7	5	1	3	2	7	5	1
complete	lemon	y	64	3.99	1	9	5	8	1	4	9	5	8	1
complete	U	n	64	3.99	1	9	7	8	7	5	1	7	8	7
complete	U	y	48	4.99	1	3	3	2	3	1	1	3	2	3
Smile	fresh	n	64	2.99	1	9	9	9	6	1	1	1	1	6
Smile	fresh	y	48	3.99	1	7	7	6	5	1	7	7	6	5
Smile	lemon	n	48	3.99	1	7	7	6	1	1	7	5	5	6
Smile	lemon	y	32	4.99	1	1	1	1	1	1	1	1	1	6
Smile	U	n	32	4.99	1	1	3	1	2	1	1	3	1	2
Smile	U	y	64	2.99	1	9	3	9	9	1	9	3	9	9
Wave	fresh	n	32	3.99	7	1	7	4	5	7	1	7	4	5
Wave	fresh	y	64	4.99	5	5	3	3	2	5	5	3	3	2
Wave	lemon	n	64	4.99	5	5	5	3	1	5	5	5	3	1
Wave	lemon	y	48	2.99	9	9	5	7	1	9	9	5	7	1
Wave	U	n	48	2.99	9	9	5	7	7	9	9	5	7	7
Wave	U	y	32	3.99	7	1	5	4	5	7	1	5	4	5
Wave	lemon	n	64	2.99	8	9	6	9	3	8	9	6	9	3
Smile	lemon	n	32	4.99	2	1	3	2	1	2	1	3	2	1
Smile	fresh	y	48	2.99	2	8	4	5	5	2	8	4	5	5
complete	U	y	32	2.99	2	4	2	5	6	2	4	2	5	6
complete	lemon	y	48	3.99	2	6	6	6	1	2	6	6	6	1
;
/* manual calculation*/
/* First step: Dummy Coding*/
Data dtchcd;
set dtrgntchc;
/*reversing the Scale*/
array s(10) s1-s10;
Select (brand);
	when("complete") do;
		B0=0;
		B1=0;
	end;
	when ("Smile") do;
		B0=1;
		B1=0;
	end;
	when ("Wave") do;
		B0=0;
		B1=1;
	end;
	otherwise put 'PROBLEM OBSERVATION';
end;               /* end of select */
Select (scent);
	when("fresh") do;
		Sc0=0;
		Sc1=0;
	end;
	when ("lemon") do;
		Sc0=1;
		Sc1=0;
	end;
	when ("U") do;
		Sc0=0;
		Sc1=1;
	end;
	otherwise put 'PROBLEM OBSERVATION';
end;               /* end of select */
Select (soft);
	when("y") do;
		So0=0;
	end;
	when ("n") do;
		So0=1;
	end;
	otherwise put 'PROBLEM OBSERVATION';
end;               /* end of select */
Select (oz);
	when(32) do;
		oz0=0;
		oz1=0;
	end;
	when (48) do;
		oz0=1;
		oz1=0;
	end;
	when (64) do;
		oz0=0;
		oz1=1;
	end;
	otherwise put 'PROBLEM OBSERVATION';
end;  
Select (pr);
	when(2.99) do;
		p0=0;
		p1=0;
	end;
	when (3.99) do;
		p0=1;
		p1=0;
	end;
	when (4.99) do;
		p0=0;
		p1=1;
	end;
	otherwise put 'PROBLEM OBSERVATION';
end;
drop i;
run;
%macro conjoint(outt,s);
	proc reg outtest=&outt noprint data=dtchcd;
	model &s= B0 B1 Sc0 Sc1 So0 oz0 oz1 p0 p1;
	run;
%mend conjoint;
%macro merge (dtsts);
	data bmrgd;
	set &dtsts;
	run;
%mend merge;
Data temp;
array beta(10) $ ('b1' 'b2' 'b3' 'b4' 'b5' 'b6' 'b7' 'b8' 'b9' 'b10');
array s(10) $ ('s1' 's2' 's3' 's4' 's5' 's6' 's7' 's8' 's9' 's10');
do i=1 to 10;
	call execute('%conjoint('||beta(i)||','||s(i)||')');
end;
/*datasets=cat(of beta1-beta5);*/
drop i;
drop s0-s10;
drop beta0-beta10;
/*%merge("B1 B2 B3 B4 B5");*/
run;
Data beta;
set B1-B10;
obs+1;
run;
data ss ;
 set Beta(rename=(intercept=c0 b0=c1 b1=c2 sc0=c3 sc1=c4 so0=c5 oz0=c6 oz1=c7 p0=c8 p1=c9));
 /*array c(10) intercept b0 b1 sc0 sc1 so0 oz0 oz1 p0 p1;*/
run;
data ssv(keep=c0-c9);
 set ss;
run;
%macro parthworth(outt,r1,r2);
proc model outtest=&outt noprint data=ssv;
  eq.first  = a11 - a13 - &r1;
  eq.second = a12 - a13 - &r2;
  eq.third  = a11+a12+a13;
  solve a11 a12 a13 / solveprint;
  id &r1 &r2;
run;
%mend parthworth;
Data temp;
array beta(4) $ ('br' 'sc' 'si' 'pr');
array s(8) $ ('c1' 'c2' 'c3' 'c4' 'c6' 'c7' 'c8' 'c9');
do i=1 to 8 by 2;
	call execute('%parthworth('||beta(i/2+1)||','||s(i)||','||s(i+1)||')');
end;
run;
proc model outtest=So noprint data=ssv;
  eq.first  = a11-c5;
  eq.second = a11+a12;
  solve a11 a12 / solveprint;
  id c5;
run;
Data Br;
set Br;
obs+1;
run;
proc print data=So;
var a11 a12;
run;
Data Sc;
retain obs 0;
set Sc;
obs+1;
run;
Data So;
set So;
obs+1;
run;
Data Si;
set Si;
obs+1;
run;
Data Pr;
set Pr;
obs+1;
run;
proc sql;
create table wts as
 select Br.obs,max(Br.a11,Br.a12,Br.a13)-min(Br.a11,Br.a12,Br.a13) as Brim,
     max(Sc.a11,Sc.a12,Sc.a13)-min(Sc.a11,Sc.a12,Sc.a13) as Scim,
	 max(So.a11,So.a12)-min(So.a11,So.a12) as Soim,
	 max(Si.a11,Si.a12,Si.a13)-min(Si.a11,Si.a12,Si.a13) as Siim,
	 max(Pr.a11,Pr.a12,Pr.a13)-min(Pr.a11,Pr.a12,Pr.a13) as Prim
 from Br, Sc, So, Si, Pr
 where Br.obs=Sc.obs and Sc.obs=So.obs and So.obs=Si.obs and Si.obs=Pr.obs;
quit;
proc print data=Br;
var a11 a12 a13;
run;
proc print data=Sc;
var a11 a12 a13;
run;
proc print data=Si;
var a11 a12 a13;
run;
proc print data=Pr;
var a11 a12 a13;
run;
proc print data=So;
var a11 a12;
run;
data relimprt;
 set wts;
 ttlpw=sum(Brim,Scim,Soim,Siim,Prim);
 Brim=Brim/ttlpw;
 Scim=Scim/ttlpw;
 Soim=Soim/ttlpw;
 Siim=Siim/ttlpw;
 Prim=Prim/ttlpw;
 drop ttlpw;
run;
proc print data=relimprt;
run;
proc means data=relimprt;
run;
/* products*/
data Np;
input product $ brand	$ scent $ soft $ oz	pr;	
datalines;	
A	Wave lemon y 64	2.99
B	Complete fresh y 48	2.99
C	Smile u	y 48 3.99
D	Wave u	y 48 2.99
E	Smile u	n 48 2.99
;
run;
Data Npc;
set Np;
Select (brand);
	when("Complete") do;
		B0=0;
		B1=0;
	end;
	when ("Smile") do;
		B0=1;
		B1=0;
	end;
	when ("Wave") do;
		B0=0;
		B1=1;
	end;
	otherwise put 'PROBLEM OBSERVATION';
end;               /* end of select */
Select (scent);
	when("fresh") do;
		Sc0=0;
		Sc1=0;
	end;
	when ("lemon") do;
		Sc0=1;
		Sc1=0;
	end;
	when ("u") do;
		Sc0=0;
		Sc1=1;
	end;
	otherwise put 'PROBLEM OBSERVATION';
end;               /* end of select */
Select (soft);
	when("y") do;
		So0=0;
	end;
	when ("n") do;
		So0=1;
	end;
	otherwise put 'PROBLEM OBSERVATION';
end;               /* end of select */
Select (oz);
	when(32) do;
		oz0=0;
		oz1=0;
	end;
	when (48) do;
		oz0=1;
		oz1=0;
	end;
	when (64) do;
		oz0=0;
		oz1=1;
	end;
	otherwise put 'PROBLEM OBSERVATION';
end;  
Select (pr);
	when(2.99) do;
		p0=0;
		p1=0;
	end;
	when (3.99) do;
		p0=1;
		p1=0;
	end;
	when (4.99) do;
		p0=0;
		p1=1;
	end;
	otherwise put 'PROBLEM OBSERVATION';
end;
run;
proc sql;
create table putil as
Select
b.intercept+b.B0*n.B0+ b.B1*n.B1 + b.Sc0*n.Sc0 + b.Sc1*n.Sc1 + b.So0*n.So0 + b.oz0*n.oz0 + b.oz1*n.oz1 + b.p0*n.p0 + b.p1*n.p0 as Util,
product, obs
From Beta b, Npc n;
quit;
proc sql;
create table pu as
	select A.obs, UA, UB, UC, UD, UE, 
	exp(UA)/(exp(UA)+exp(UB)+exp(UC)+exp(UD)+exp(UE)) as PA,
	exp(UB)/(exp(UA)+exp(UB)+exp(UC)+exp(UD)+exp(UE)) as PB,
	exp(UC)/(exp(UA)+exp(UB)+exp(UC)+exp(UD)+exp(UE)) as PC,
	exp(UD)/(exp(UA)+exp(UB)+exp(UC)+exp(UD)+exp(UE)) as PD,
	exp(UE)/(exp(UA)+exp(UB)+exp(UC)+exp(UD)+exp(UE)) as PE
	from (select obs, Util as UA from putil where product='A') A,
		 (select obs, Util as UB from putil where product='B') B,
		 (select obs, Util as UC from putil where product='C') C,
		 (select obs, Util as UD from putil where product='D') D,
		 (select obs, Util as UE from putil where product='E') E
	where A.obs=B.obs and B.obs=C.obs and C.obs=D.obs and D.obs=E.obs;
quit;
proc print data=pu;
Var UA UB UC UD UE PA PB PC PD PE;
format UA UB UC UD UE PA PB PC PD PE 5.3;
run;
proc means data=pu Fw=5;
var PA PB PC PD PE;
run;
/* Second question*/
data p189;
  length state $ 2 ;
  input State Y X1 X2 X3 Region ;
  label x1 = 'Income'
        x2 = 'Residents under 18'
        x3 = 'Residents in Urban Areas'
         y = 'Expenditure';
cards;
ME 235 3944 325 508 1
NH 231 4578 323 564 1
VT 270 4011 328 322 1
MA 261 5233 305 846 1
RI 300 4780 303 871 1
CT 317 5889 307 774 1
NY 387 5663 301 856 1
NJ 285 5759 310 889 1
PA 300 4894 300 715 1
OH 221 5012 324 753 2
IN 264 4908 329 649 2
IL 308 5753 320 830 2
MI 379 5439 337 738 2
WI 342 4634 328 659 2
MN 378 4921 330 664 2
IA 232 4869 318 572 2
MO 231 4672 309 701 2
ND 246 4782 333 443 2
SD 230 4296 330 446 2
NB 268 4827 318 615 2
KS 337 5057 304 661 2
DE 344 5540 328 722 3
MD 330 5331 323 766 3
VA 261 4715 317 631 3
WV 214 3828 310 390 3
NC 245 4120 321 450 3
SC 233 3817 342 476 3
GA 250 4243 339 603 3
FL 243 4647 287 805 3
KY 216 3967 325 523 3
TN 212 3946 315 588 3
AL 208 3724 332 584 3
MS 215 3448 358 445 3
AR 221 3680 320 500 3
LA 244 3825 355 661 3
OK 234 4189 306 680 3
TX 269 4336 335 797 3
MT 302 4418 335 534 4
ID 268 4323 344 541 4
WY 323 4813 331 605 4
CO 304 5046 324 785 4
NM 317 3764 366 698 4
AZ 332 4504 340 796 4
UT 315 4005 378 804 4
NV 291 5560 330 809 4
WA 312 4989 313 726 4
OR 316 4697 305 671 4
CA 332 5438 307 909 4
AK 546 5613 386 484 4
HI 311 5309 333 831 4
;
run;
/* Simple OLS*/
Proc Reg data=P189;
model Y= X1 X2 X3;
run;
/* Outlier check*/
Proc Reg data=P189;
model Y= X1 X2 X3/influence;
run;
/*remove outlier*/
ods output OutputStatistics=table1;
Proc Reg data=P189;
model Y= X1 X2 X3/influence;
run;
ods output close;
data table1(keep=md);
n=50; /* number of observation*/
set table1; 
md=(n-1)*(HatDiagonal/n); 
run;
/*Merge the two datasets:*/
data table;
set P189;
set table1;
run;
/*=CHIINV(probability,df) in excel. =CHIINV(0.05,3)=7.81 for three df*/
data table (drop=md);
set table (where=(md<=7.81));
run;
/* check the heterodescedasticity*/
proc model data=P189;
  parms a1 b1 b2 b3;
  y = a1 + b1 * x1 + b2 * x2+ b3*x3;
  fit y / white pagan=(1 x1 x2 x3)
  out=resid1 outresid;
run;
quit;
data P189m;
set P189;
x12=x1**2;
x22=x2**2;
x32=x3**2;
run;
/*Correcting Heteroscedasticity*/
 proc model data=P189m;
      parms a1 b1 b2 b3 b4 b5 b6;
      /*x12_inv = 1/x12;*/
      y = a1 + b1 * x1 + b2 * x2+ b3*x3+b4*x12+b5*x22+b6*x32;
      fit y / white pagan=(1 x1 x2 x3 x12 x22 x32);
      /*weight x12_inv;*/
run;
quit;
/* Third question */
PROC IMPORT OUT= WORK.Wagepan 
            DATAFILE= "C:\Users\mxh109420\Documents\MurthiCourse\wagepan
.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;
/* first step should be to sort the dataset*/
proc sort data=Wagepan;
	by nr year;
run;
proc tscsreg data=Wagepan;
	id nr year;
	model lwage=educ black hisp exper expersq married union/fixone fixtwo ranone Rantwo;
run;


/* check over detergent data*/
proc transreg utilities separators=', ' short data=dtrgntchc;
title2 'Metric Conjoint Analysis';
model identity(s1-s5) = class(brand scent soft oz / zero=sum);
run;

/*using built in function*/
proc transreg utilities separators=', ' short;
title2 'Metric Conjoint Analysis';
model identity(rating) = class(chocolate center nuts / zero=sum);
run;
