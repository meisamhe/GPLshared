/*Meisam Hejazinia: Mxh109420*/
TITLE "Meisam Hejazinia First Homework of Data Analysis Course of Professor Murthi";
LIBNAME mxh1942 "C:\Users\mxh109420\Documents\BPSMurthiHWs\FirstHW\";
PROC IMPORT OUT= mxh1942.gas
            DATAFILE= "C:\Users\mxh109420\Documents\BPSMurthiHWs\FirstHW\Gas_data.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;
PROC MEANS data=mxh1942.gas;
RUN;
DATA mxh1942.CGas; *data cleaning;
	set mxh1942.gas;
	if cust2003=. then delete; *remove missing data;
	if cust2003<100 then delete;  *remove outlier obesrvations;
	dhu=hu-hu0;
	dtotmf=totmf-totmf0;
	dlarge=large-large0;
	dsmall=small-small0;
	dv=vachu-vachu0;
	down=ownocc-ownocc0;
	dgas=gas-gas0;
	dpci=pci-pci0;
	dno1865=no1865-no18650;
	dno65=no65-no650;
	Label dhu="# housing units change" 
		dtotmf="# multi family unit change"
		dlarge="# large homes unit change"
		dsmall="# small homes unit change"
		dv="# vacant housing change"
		down="# owner occupied homes change"
		dgas="# primary gas user home change"
		dpci="per capita income change"
		dno1865="percentage of population b/w 18 & 65 change"
		dno65="percenage of population older than 65 change";
		
RUN; 
Data mxh1942.ICGas;
set mxh1942.CGas;
iholh=down*dlarge;
Label iholh="interaction between change in large homes and change in owner occupied homes";
RUN;
PROC REG data=mxh1942.ICGas;
	model lostc= dhu dtotmf dlarge dsmall dv down dgas dpci dno1865 dno65 iholh/ collin vif stb;
RUN;