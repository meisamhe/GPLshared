%=============================================================%
% This is the main part of Markov Chain Monte Carlo estimation%
% Version without size-heterogeneity in terms of costs        %
%=============================================================%
%================================================
% Global parameters not changing over iterations
%================================================
clear all
clc
diary
diary('commandLine.txt')
diary on
%parameters used in function but I made global
global parcurr zcurr dcurr ecurr acurr bcurr xcurr
global par xgrid kgrid kcut id year expt rd prodv cap lnxs lnrd zpl u2 uz

global nobs np T S ngrid nkgrid maxiter xmin xmax

% data
nobs=4684; np=1171; T=4; S=10;

%grids
ngrid=100;nkgrid=8; maxiter=1000;
xmin=-.275; xmax=1.35;

%first stage estimates
global dr0 etad etax betak scale rhox0 rhox1 rhox2 rhox3 gd gex gdex sigx
global delta tol
dr0=4.4232; etad=-6.38; etax=-6.10; betak=.3404/(1+etad); scale=1e-3;
rhox0=.4727/-(1+etad);rhox1=.5925; rhox2=-.0705*(1+etad); rhox3=-0.005*(1+etad)*(1+etad);
gd=.2576/-(1+etad); gex=.1052/-(1+etad); gdex=-0.0635/-(1+etad); sigx=.5916/-(1+etad);
delta=0.5; tol=1e-3;

%parameters for mcmc runs
global nzparm ndparm neparm naparm nbparm nxparm npar
nzparm=2; ndparm=2; neparm=2; naparm=4; nbparm=4; nxparm=1; npar=15;

%mcmc parameters
nrep=2000; block=5; %I changed it from 20,000 to 2000

%======================= 
% Model Parameters
%=======================
% raw data variables
id = zeros(nobs,1); year = zeros(nobs,1);
expt=zeros(nobs,1); rd=zeros(nobs,1); prodv = zeros(nobs,1); cap=zeros(nobs,1);
lnxs=zeros(nobs,1); lnrd=zeros(nobs,1); zpl=zeros(nobs,1);
uz= zeros(np*T,S);

% random grids
xgrid=zeros(ngrid,1); u1=zeros(ngrid,1); u2=zeros(ngrid,1);

%fixed grids
kgrid=zeros(nkgrid,1); kcut=zeros(nkgrid,1);

%random uniform noises for mcmc iteration
um =zeros(nrep*block,1);
umz=zeros(1,nzparm);
umd=zeros(1,ndparm);
ume=zeros(1,neparm);
uma=zeros(1,naparm);
umb=zeros(1,nbparm);
umx=zeros(1,nxparm);

%priors
lrhoz=0; hrhoz=0; msigz=0; vsigz=0;mxr0=0; vxr0=0;
priormd = zeros(ndparm,1); priorvd=zeros(ndparm,1);
priorme=zeros(neparm,1); priorve=zeros(neparm,1);
priorma=zeros(naparm,1); priorva=zeros(naparm,1);
priormb=zeros(nbparm,1); priorvb=zeros(nbparm,1);

%steps for random walk and each run's parameter updates
stepz=zeros(1,nzparm); zprop=zeros(1,nzparm); zcurr=zeros(1,nzparm);
stepd=zeros(1,ndparm); dprop=zeros(1,ndparm); dcurr=zeros(1,ndparm);
stepe=zeros(1,neparm); eprop=zeros(1,neparm); ecurr=zeros(1,neparm);
stepa=zeros(1,naparm); aprop=zeros(1,naparm); acurr=zeros(1,naparm);
stepb=zeros(1,nbparm); bprop=zeros(1,nbparm); bcurr=zeros(1,nbparm);
stepx=zeros(1,nxparm); xprop=zeros(1,nxparm); xcurr=zeros(1,nxparm);

%starting value and iterations
start=zeros(1,npar); parcurr=zeros(1,npar); parprop=zeros(1,npar); 
priden=zeros(1,npar); lpriden=zeros(1,npar);
ln=0; rllcurr=0; rllprop=0; d=0; accprob=0;

%records
tacc=zeros(nrep,1); taccz=zeros(nrep,1); taccd=zeros(nrep,1); tacce=zeros(nrep,1);
tacca=zeros(nrep,1); taccb=zeros(nrep,1); rate=zeros(nrep,1);
par =zeros(nrep,npar);

%=================================================
% General Coding Parameter Definition
%==================================================
i=0; j=0; k=0; p=0; q=0; ios=0;
temp=0;

%=============================================
%read in the data (size of nobs)
%=============================================
data_dyn=csvread('data_dyn.csv'); 
id=data_dyn(:,1);
year=data_dyn(:,2);
expt=data_dyn(:,3);
rd=data_dyn(:,4);
prodv=data_dyn(:,5);
cap=data_dyn(:,6);
lnxs=data_dyn(:,7);

%=======================================
%read in the 100 sobol points (ngrid)
%=======================================
sobolp=csvread('sobolp.csv');
u1=sobolp(:,1);
u2=sobolp(:,2);

%==============================
%define kgrid,xgrid
%==============================
%kgrid fixed
kgrid(1,1)=7.07;
kgrid(2,1)=8.39;
kgrid(3,1)=8.94;
kgrid(4,1)=9.50;
kgrid(5,1)=10.03;
kgrid(6,1)=10.62;
kgrid(7,1)=11.32;
kgrid(8,1)=13.22;

%kcut fixed
kcut(1,1)=7.96;
kcut(2,1)=8.69;
kcut(3,1)=9.21;
kcut(4,1)=9.76;
kcut(5,1)=10.35;
kcut(6,1)=10.91;
kcut(7,1)=11.91;
kcut(8,1)=16.84;

%random grids of x
%u1=normrnd(0,1,ngrid,1);
xgrid=xmin+(xmax-xmin)*u1;
%for i=1:ngrid
%	xgrid(i,1)=xmin+(xmax-xmin)*i/ngrid
%end

%take random draws for the construction of export shocks
uz=normrnd(0,1,np*T,S);

disp('Total number of iterations');
disp(nrep);

%==========================================
%MCMC Preliminaries
%==========================================
%draw random noises
um=normrnd(0,1,nrep*block,1);
um=log(um);

%define the priors
%uniform(-1,1)
lrhoz=-1;
hrhoz=1;

%lognormal(0,10)
msigz=0;
vsigz=10;

%normal
priormd(1,1)=0;
priormd(2,1)=0;

priorvd(1,1)=1000;
priorvd(2,1)=1000;

priorme(1,1)=0;
priorme(2,1)=0;

priorve(1,1)=1000;
priorve(2,1)=1000;

priorma(1,1)=0;
priorma(2,1)=0;
priorma(3,1)=0;
priorma(4,1)=0;
priorva(1,1)=100;
priorva(2,1)=100;
priorva(3,1)=100;
priorva(4,1)=100;

priormb(1,1)=0;
priormb(2,1)=0;
priormb(3,1)=0;
priormb(4,1)=0;
priorvb(1,1)=100;
priorvb(2,1)=100;
priorvb(3,1)=100;
priorvb(4,1)=100;

mxr0=0;
vxr0=100;

%steps for random walk
stepz(1,1)=0.005;
stepz(1,2)=0.0025;

stepd(1,1:ndparm/2)=1;
stepd(1,ndparm/2+1:ndparm)=5;

stepe(1,1:neparm/2)=.25;
stepe(1,neparm/2+1:neparm)=2;

stepa=0.01;
stepb=0.01;
stepx=0.01;

%starting value 

start(1,1)=0.76;
start(1,2)=-0.21;

start(1,3)=70;
start(1,4)=380;

start(1,5)=10;
start(1,6)=50;

start(1,7)=-4.0059;
start(1,8)=1.9955;
start(1,9)=0.1724;
start(1,10)=0.2710;

start(1,11)=-5.4041;
start(1,12)=2.2519;
start(1,13)=0.1270;
start(1,14)=0.3305;

start(1,15)=3.8;

%-----------------
%starting values
%-----------------
%par(1:1,1:npar)=start
parcurr=start;

taccz(1,1)=0;
taccd(1,1)=0;
tacce(1,1)=0;
tacca(1,1)=0;
taccb(1,1)=0;
tacc(1,1)=0;

for i=2:nrep;
    if(i/10==ceil(i/10))
        disp('iteration number:');
        disp(i);
    end;

    updatepar()%parcurr,zcurr,dcurr,ecurr,acurr,bcurr,xcurr

    if (i==2)
        %prior, notice the shape of normpdf
        priden(1,1)=unifpdf(zcurr(1,1),lrhoz,hrhoz) ;
        priden(1:1,2:2)=normpdf(zcurr(1,2),msigz,vsigz);
        priden(1:1,nzparm+1:nzparm+ndparm)=normpdf(dcurr',priormd,priorvd);
        priden(1:1,nzparm+ndparm+1:nzparm+ndparm+neparm)=normpdf(ecurr',priorme,priorve);
        priden(1:1,nzparm+ndparm+neparm+1:nzparm+ndparm+neparm+naparm)=normpdf(acurr',priorma,priorva);
        priden(1:1,nzparm+ndparm+neparm+naparm+1:nzparm+ndparm+neparm+naparm+nbparm)=normpdf(bcurr',priormb,priorvb);
        priden(1:1,nzparm+ndparm+neparm+naparm+nbparm+1:npar)=normpdf(xcurr',mxr0,vxr0);
        lpriden=log(priden);
        %log-likelihood of current parameters
        %parcurr,xgrid,kgrid,kcut,id,year,expt,rd,prodv,cap,lnxs,lnrd,zpl,u2,uz;
        ln=tml();
        rllcurr=ln+sum(lpriden);
    end; 	

    %------------------
    %update (rhoz,sigz)
    %------------------
    umz=normrnd(0,1,1,nzparm);
    zprop=zcurr+umz.*stepz;
    %update prior
    priden(1,1)=unifpdf(zprop(1,1),lrhoz,hrhoz); 
    priden(1:1,2:2)=normpdf(zprop(1,2),msigz,vsigz);
    priden(1:1,nzparm+1:nzparm+ndparm)=normpdf(dcurr',priormd,priorvd);
    priden(1:1,nzparm+ndparm+1:nzparm+ndparm+neparm)=normpdf(ecurr',priorme,priorve);
    priden(1:1,nzparm+ndparm+neparm+1:nzparm+ndparm+neparm+naparm)=normpdf(acurr',priorma,priorva);
    priden(1:1,nzparm+ndparm+neparm+naparm+1:nzparm+ndparm+neparm+naparm+nbparm)=normpdf(bcurr',priormb,priorvb);
    priden(1:1,nzparm+ndparm+neparm+naparm+nbparm+1:npar)=normpdf(xcurr',mxr0,vxr0); 
    lpriden=log(priden);
    %log-likelihood of proposed parameters
    parprop=parcurr;
    parprop(1:1,1:nzparm)=zprop;
    %parprop,xgrid,kgrid,kcut,id,year,expt,rd,prodv,cap,lnxs,lnrd,zpl,u2,uz
    rllprop=tml()+sum(lpriden);
    %update parameters vector
    d=rllprop-rllcurr;
    accprob=min(0.0,d);
    if (um((i-1)*block+1,1)<=accprob)
        parcurr=parprop;
        taccz(i,1)=taccz(i-1,1)+1;
        rllcurr=rllprop;
        disp('new points accepted');
        disp('z transition');
        disp(zprop);
    else
    	taccz(i,1)=taccz(i-1,1);
    end; 

    %--------------------
    %update gammai gammad
    %--------------------
    %parcurr,zcurr,dcurr,ecurr,acurr,bcurr,xcurr
    updatepar();
    umd=normrnd(0,1,ndparm,1);
    dprop=dcurr+umd'.*stepd;
    %update prior
    %prior, notice the shape of normpdf
    priden(1,1)=unifpdf(zcurr(1,1),lrhoz,hrhoz); 
    priden(1:1,2:2)=normpdf(zcurr(1,2),msigz,vsigz);
    priden(1:1,nzparm+1:nzparm+ndparm)=normpdf(dprop',priormd,priorvd);
    priden(1:1,nzparm+ndparm+1:nzparm+ndparm+neparm)=normpdf(ecurr',priorme,priorve);
    priden(1:1,nzparm+ndparm+neparm+1:nzparm+ndparm+neparm+naparm)=normpdf(acurr',priorma,priorva);
    priden(1:1,nzparm+ndparm+neparm+naparm+1:nzparm+ndparm+neparm+naparm+nbparm)=normpdf(bcurr',priormb,priorvb);
    priden(1:1,nzparm+ndparm+neparm+naparm+nbparm+1:npar)=normpdf(xcurr',mxr0,vxr0); 
    lpriden=log(priden);
    %log-likelihood of proposed parameters
    parprop=parcurr;
    parprop(1:1,nzparm+1:nzparm+ndparm)=dprop;
    %parprop,xgrid,kgrid,kcut,id,year,expt,rd,prodv,cap,lnxs,lnrd,zpl,u2,uz
    rllprop=tml()+sum(lpriden);
    %update parameters vector
    d=rllprop-rllcurr;
    accprob=min(0.0,d);
    if (um((i-1)*block+2,1)<=accprob)
        parcurr=parprop;
        taccd(i,1)=taccd(i-1,1)+1;
        rllcurr=rllprop;
        disp('new points accepted');
        disp('r&d costs');
        disp(dprop);
    else
     taccd(i,1)=taccd(i-1,1);
    end; 


    %--------------------
    %update gammaf gammas
    %--------------------
    %parcurr,zcurr,dcurr,ecurr,acurr,bcurr,xcurr
    updatepar();
    ume=normrnd(0,1,neparm,1);
    eprop=ecurr+ume'.*stepe;
    %update prior
    %prior, notice the shape of normpdf
    priden(1,1)=unifpdf(zcurr(1,1),lrhoz,hrhoz) ;
    priden(1:1,2:2)=normpdf(zcurr(1,2),msigz,vsigz);
    priden(1:1,nzparm+1:nzparm+ndparm)=normpdf(dcurr',priormd,priorvd);
    priden(1:1,nzparm+ndparm+1:nzparm+ndparm+neparm)=normpdf(eprop',priorme,priorve);
    priden(1:1,nzparm+ndparm+neparm+1:nzparm+ndparm+neparm+naparm)=normpdf(acurr',priorma,priorva);
    priden(1:1,nzparm+ndparm+neparm+naparm+1:nzparm+ndparm+neparm+naparm+nbparm)=normpdf(bcurr',priormb,priorvb);
    priden(1:1,nzparm+ndparm+neparm+naparm+nbparm+1:npar)=normpdf(xcurr',mxr0,vxr0); 
    lpriden=log(priden);
    %log-likelihood of proposed parameters
    parprop=parcurr;
    parprop(1:1,nzparm+ndparm+1:nzparm+ndparm+neparm)=eprop;
    %parprop,xgrid,kgrid,kcut,id,year,expt,rd,prodv,cap,lnxs,lnrd,zpl,u2,uz
    rllprop=tml()+sum(lpriden);
    %update parameters vector
    d=rllprop-rllcurr;
    accprob=min(0.0,d);
    if (um((i-1)*block+3,1)<=accprob)
        parcurr=parprop;
        tacce(i,1)=tacce(i-1,1)+1;
        rllcurr=rllprop;
        disp('new points accepted');
        disp('export costs');
        disp(eprop);
    else
    	tacce(i,1)=tacce(i-1,1);
    end; 

    %--------------------
    %update xr0 a
    %--------------------
    %parcurr,zcurr,dcurr,ecurr,acurr,bcurr,xcurr
    updatepar();
    uma=normrnd(0,1,naparm,1);
    aprop=acurr+uma'.*stepa;
    umx=normrnd(0,1,nxparm,1);
    xprop=xcurr+umx'.*stepx;

    % update prior
    % prior, notice the shape of normpdf
    priden(1,1)=unifpdf(zcurr(1,1),lrhoz,hrhoz) ;
    priden(1:1,2:2)=normpdf(zcurr(1,2),msigz,vsigz);
    priden(1:1,nzparm+1:nzparm+ndparm)=normpdf(dcurr',priormd,priorvd);
    priden(1:1,nzparm+ndparm+1:nzparm+ndparm+neparm)=normpdf(ecurr',priorme,priorve);
    priden(1:1,nzparm+ndparm+neparm+1:nzparm+ndparm+neparm+naparm)=normpdf(aprop',priorma,priorva);
    priden(1:1,nzparm+ndparm+neparm+naparm+1:nzparm+ndparm+neparm+naparm+nbparm)=normpdf(bcurr',priormb,priorvb);
    priden(1:1,nzparm+ndparm+neparm+naparm+nbparm+1:npar)=normpdf(xprop',mxr0,vxr0); 
    lpriden=log(priden);
    %log-likelihood of proposed parameters
    parprop=parcurr;
    parprop(1:1,nzparm+ndparm+neparm+1:nzparm+ndparm+neparm+naparm)=aprop;
    parprop(1:1,nzparm+ndparm+neparm+naparm+nbparm+1:npar)=xprop;
    %parprop,xgrid,kgrid,kcut,id,year,expt,rd,prodv,cap,lnxs,lnrd,zpl,u2,uz
    rllprop=tml()+sum(lpriden);
    %update parameters vector
    d=rllprop-rllcurr;
    accprob=min(0.0,d);
    if (um((i-1)*block+4,1)<=accprob)
        parcurr=parprop;
        tacca(i,1)=tacca(i-1,1)+1;
        rllcurr=rllprop;
        disp('new points accepted');
        disp('initial condition export');
        disp(aprop);
        disp(xprop);
    else
    	tacca(i,1)=tacca(i-1,1);
    end; 

    %--------------------
    %update b
    %--------------------
    %parcurr,zcurr,dcurr,ecurr,acurr,bcurr,xcurr
    updatepar();
    umb=normrnd(0,1,nbparm,1);
    bprop=bcurr+umb'.*stepb;

    %update prior
    %prior, notice the shape of normpdf
    priden(1,1)=unifpdf(zcurr(1,1),lrhoz,hrhoz) ;
    priden(1:1,2:2)=normpdf(zcurr(1,2),msigz,vsigz);
    priden(1:1,nzparm+1:nzparm+ndparm)=normpdf(dcurr',priormd,priorvd);
    priden(1:1,nzparm+ndparm+1:nzparm+ndparm+neparm)=normpdf(ecurr',priorme,priorve);
    priden(1:1,nzparm+ndparm+neparm+1:nzparm+ndparm+neparm+naparm)=normpdf(acurr',priorma,priorva);
    priden(1:1,nzparm+ndparm+neparm+naparm+1:nzparm+ndparm+neparm+naparm+nbparm)=normpdf(bprop',priormb,priorvb);
    priden(1:1,nzparm+ndparm+neparm+naparm+nbparm+1:npar)=normpdf(xcurr',mxr0,vxr0); 
    lpriden=log(priden);
    %log-likelihood of proposed parameters
    parprop=parcurr;
    parprop(1:1,nzparm+ndparm+neparm+naparm+1:nzparm+ndparm+neparm+naparm+nbparm)=bprop;
    parprop(1:1,nzparm+ndparm+neparm+naparm+nbparm+1:npar)=xprop;
    %parprop,xgrid,kgrid,kcut,id,year,expt,rd,prodv,cap,lnxs,lnrd,zpl,u2,uz
    rllprop=tml()+sum(lpriden);
    %update parameters vector
    d=rllprop-rllcurr;
    accprob=min(0.0,d);
    if (um((i-1)*block+5,1)<=accprob)
        parcurr=parprop;
        taccb(i,1)=taccb(i-1,1)+1;
        rllcurr=rllprop;
        disp( 'new points accepted');
        disp( 'initial condition rd');
        disp(bprop);
    else
    	taccb(i,1)=taccb(i-1,1);
    end; 

    %------------------------------
    %update optimal for iteration i
    %------------------------------
    tacc(i,1)=min([taccz(i,1) taccd(i,1) tacce(i,1) tacca(i,1) taccb(i,1)]);
    rate(i,1)=tacc(i,1)/(i-1);
    disp('acceptance rate');
    disp(rate(i,1));
    disp('');
    %par(i:i,1:npar)=parcurr
    
    % open a file for writing
    fid = fopen('param.txt', 'a');
    fprintf(fid, '%19f10.4\n', parcurr);
    fclose(fid);

    fid = fopen('accept.txt', 'a');
    fprintf(fid, '%2f10.4', rllcurr);
    fprintf(fid, '%2f10.4\n', rate(i,1));
    fclose(fid);

end;
diary off
parameters=zeros(15,2000);
parameter=textread('param.txt', ...
'%s');
for j=1:2141;
    for k=1:15;
        parameters(k,j)=str2double(parameter{15*(j-1)+k}(1:size(parameter{15*(j-1)+k},2)-4));
    end;
end;
parameters=parameters(:,142:2141);
% print parameters and standard deviations
disp('mean and std of gammaI and gammaD (R&D FC,SC) is:');
disp([mean(parameters(3:4,:),2)';  std(parameters(3,:)) std(parameters(4,:))]);
disp('mean and std of gammaF and gammaS (Export FC, SC) is:');
disp([mean(parameters(5:6,:),2)';  std(parameters(5,:)) std(parameters(6,:))]);
% open a file for writing
fid = fopen('paramfinal2000.txt', 'a');
fprintf(fid, '%19f\n', parameters);
fclose(fid);