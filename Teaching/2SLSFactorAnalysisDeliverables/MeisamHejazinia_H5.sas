Data PIMS;
infile "C:\Users\mxh109420\Documents\MurthiCourse\HW5ClusterFactorDiscrim2SLS\PIMS.dat";
input MS QUAL PRICE PLB DC PION EF PHPF PLPF
PSC PAPC NCOMP MKTEXP TYRP PNP CUSTTYP NCUST
CUSTSIZE PENEW CAP RBVI EMPRODY UNION;
run;
proc syslin data=PIMS 2sls;
      endogenous  ms qual plb price dc;
      instruments pion tyrp ef phpf plpf psc papc ncomp mktexp
	  		 pnp custtyp ncust custsize penew cap rbvi emprody union;
		model ms=qual plb price pion tyrp ef phpf plpf psc papc ncomp mktexp/stb;
		model qual=price dc pion ef tyrp mktexp pnp/stb;
		model plb=dc pion tyrp ef pnp custtyp ncust custsize/stb;
		model price=ms qual dc pion ef tyrp mktexp pnp/stb;
		model dc=ms qual pion ef tyrp penew cap rbvi emprody union/stb;
  run;
proc reg data=PIMS ;
	model ms=qual plb price pion tyrp ef phpf plpf psc papc ncomp mktexp/stb;
run;
proc syslin data=PIMS 3sls;
      endogenous  ms qual plb price dc;
      instruments pion tyrp ef phpf plpf psc papc ncomp mktexp
	  		 pnp custtyp ncust custsize penew cap rbvi emprody union;
		model ms=qual plb price pion tyrp ef phpf plpf psc papc ncomp mktexp/stb;
		model qual=price dc pion ef tyrp mktexp pnp/stb;
		model plb=dc pion tyrp ef pnp custtyp ncust custsize/stb;
		model price=ms qual dc pion ef tyrp mktexp pnp/stb;
		model dc=ms qual pion ef tyrp penew cap rbvi emprody union/stb;
  run;
/*Second question*/
Data FAQ2;
infile "C:\Users\mxh109420\Documents\MurthiCourse\HW5ClusterFactorDiscrim2SLS\Q1_KASI_TV_DATA.txt";
input (Q1 Q2 Q3 Q4 Q5 Q6 Q7 Q8 Q9 Q10 Q11 Q12 Q13 Q14 Q15 Q16 Q17 Q18 Q19) (1.0);
run;
Proc corr data=FAQ2;
run;
PROC FACTOR DATA= FAQ2 METHOD = PRINCIPAL SCREE ROTATE = VARIMAX REORDER;
VAR Q1 Q2 Q3 Q4 Q5 Q6 Q7 Q8 Q9 Q10 Q11 Q12 Q13 Q14 Q15 Q16 Q17 Q18 Q19;
run;
/*Third question*/
PROC IMPORT OUT= WORK.PDACLUST 
            DATAFILE= "C:\Users\mxh109420\Documents\MurthiCourse\HW5Clus
terFactorDiscrim2SLS\pda_20012.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;
PROC IMPORT OUT= WORK.Discrim 
            DATAFILE= "C:\Users\mxh109420\Documents\MurthiCourse\HW5Clus
terFactorDiscrim2SLS\pda_disc20012.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;
proc cluster data=PDACLUST simple noeigen method=centroid rmsstd rsquare nonorm out=tree;
id id;
var innovator Use_message Use_cell Use_PIM Inf_passive Inf_active remote_access Share_info
	Monitor Email Web M_media ergonomic monthly price;
run;
proc tree data=tree out=clus5 n=5;
id id;
copy innovator Use_message Use_cell Use_PIM Inf_passive Inf_active remote_access Share_info
	Monitor Email Web M_media ergonomic monthly price;
run;
proc sort data=clus5; by cluster;
proc means data=clus5; by cluster;
var innovator Use_message Use_cell Use_PIM Inf_passive Inf_active remote_access Share_info
	Monitor Email Web M_media ergonomic monthly price;
run;
/* creating data for discriminant analysis*/
proc sql;
create table DiscrimCl as
select c.cluster, d.*
from clus5 c, discrim d
where c.id=d.id;
run;
proc discrim data=DiscrimCl out=discrimn_out ; 
  class cluster; 
  var age education income construction emerg sales service professional compu pda cell_Ph
	pc away bus_w pc_mag field_s m_gourm; 
run;
proc candisc data=DiscrimCl out=discrim_out ; 
  class cluster; 
  var age education income construction emerg sales service professional compu pda cell_Ph
	pc away bus_w pc_mag field_s m_gourm; 
run;
proc fastclus data=PDACLUST maxclusters = 4 out=test1; 
	id id;
	var innovator Use_message Use_cell Use_PIM Inf_passive Inf_active remote_access Share_info
		Monitor Email Web M_media ergonomic monthly price;
run;