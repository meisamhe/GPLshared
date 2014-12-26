% normal BLP model
%Program for Aggregate LOGIT model with Standard errors
dta=zeros(114,26);
dta = importdata('d:\coff.txt');
price=dta(:,1:4);
sale=dta(:,5:8);
feat=dta(:,9:12);
disp=dta(:,13:16);
fd=dta(:,17:20);
inst=dta(:,21:26);  %instrument: standard price
ms=size(dta); % size of matrix
n=ms(1,1);%rows(dta)

%Create shares from sales
tot=1000000; % total amount of sales
s=sale/tot;
ou=1-sum(s'); % sum of column(sumc(s')); ou: outside option 
ou=ou'; % to have all 1-p in one column

%Reformat the data so brands are stacked one on top of the other
p=reshape(price',4*n,1); % need to transpose since matlab diff Gauss
f=reshape(feat',4*n,1);
d=reshape(disp',4*n,1);
fd=reshape(fd',4*n,1);
s=reshape(s',4*n,1);
ou=[ou ou ou ou];
ou=reshape(ou',4*n,1);
%inst=dta(:,21:26); 
inst=[inst inst inst inst];
inst=reshape(inst',6,4*n); % need to reshape revers and then back due to different structure of MATLAB
inst=inst';

%Create a matrix of brand intercepts
oi=[1 0 0 0
    0 1 0 0
    0 0 1 0
    0 0 0 1];

for ii=1:114;% one less since it will automatically break on 115
    if ii==1;
        o=oi;
    else;
        o=[o oi]; % try to used transpose for | of Gauss
    end;
end;
o=o';

%Create the matrix of X variables
nudta=[o p f d fd];

%Run basic regression
bols=inv(nudta'*nudta)*(nudta'*log(s./ou));
erols=log(s./ou)-nudta*bols;
vcvols=(erols'*erols)*inv(nudta'*nudta)/n;

%Create matrix of instruments
%implement '*~' operation to calculate o*~inst
% multiplies each column of first matrix to all rows of second
% this creates instrument for each of the brands based on line of brand
size1=size(o);
col1=size1(1,2);
size2=size(inst);
col2=size2(1,2);
for i=1:col1;
    mtemp=o(:,i);
    tempou=bsxfun(@times,mtemp,inst);
    if i==1;
        tempr=tempou;
    else;
        tempr=[tempr tempou];
    end;
end;

oins=[o tempr f d fd];

%Run 2sls
mmm=inv(oins'*oins);
sha=log(s./ou);

bb=inv(nudta'*oins*mmm*oins'*nudta)*(nudta'*oins*mmm*oins'*sha);
erbb=sha-nudta*bb;
vcvbb=(erbb'*erbb)*inv(nudta'*oins*mmm*oins'*nudta)/n;
% use erbbm since matlab does not multiple ".*" item by item when number of
% elements not equal
for i=1:31;
    if i==1;
        erbbm=erbb;
    else;
        erbbm=[erbbm erbb];
    end;
end;
%GMM invert shares to obtain mean utilities
mmm=inv((oins.*erbbm)'*(oins.*erbbm)); %Approximates the optimal weight matrix

%Print results
'OLS'
OLSresult=[bols sqrt(diag(vcvols))];
OLSresult
'IV'
IVresult=[bb sqrt(diag(vcvbb))];
IVresult

%Check whether 2sls is indeed 2sls
%First regress prices on instruments
bp=inv(oins'*oins)*(oins'*p);
%Now compute fitted prices
fp=oins*bp;
%In the second step, replace price with fitted price in the basic regression model
nudta2=[o fp f d fd];
bols2=inv(nudta2'*nudta2)*(nudta2'*log(s./ou));

%Print results
[bb bols2]

%Heterogeneity
%Create draws for brand preferences and price sensitivity
nd=1000;%Number of draws of people with different sensitivity to price and brand
%rndseed 1; %Seed value (not needed in MATLAB)
w1=randn(n,nd); %Draws for brand 1
w1=[w1 w1 w1 w1]; %This and next step ensures that the same draw is used to compute utily for a particular brand
w1=reshape(w1,nd,4*n);
w1=w1';
w2=randn(n,nd);
w2=[w2 w2 w2 w2];
w2=reshape(w2',nd,4*n);
w2=w2';
w3=randn(n,nd);
w3=[w3 w3 w3 w3];
w3=reshape(w3',nd,4*n);
w3=w3';
w4=randn(n,nd);
w4=[w4 w4 w4 w4];
w4=reshape(w4,nd,4*n);
w4=w4';
wp=randn(n,nd); %Draws for price coefficient variation
wp=[wp wp wp wp];
wp=reshape(wp,nd,4*n);
wp=wp';
km=0.00001;

mmm=inv(oins'*oins); %Reset mmm

% call function to minimize sum of square
%clear awp,zz,aw,aw1,aw2,aw3,aw4,ch,dd,k,de1,de,nch,er,jj;
%x0=zeros(5,1);
%_opalgr=2;
%_opgtol=1e-5;
%__output=1;
%output file=agglogit2.out on;
%__title="ND=1000";
%/*{x,ff,g,retcode}=optprt(optmum(&lpr,x0));*/
%{x,ff,G,retcode }= qnewton(&lpr,x0);
X0=zeros(1,5);
%anonymous function method
ObjectiveFunction = @(x)lpr(x,w1,w2,w3,w4,wp,p,o,s,nudta,oins,mmm,n,km,nd);
[x,fval,exitflag,output] = fminsearch(ObjectiveFunction,X0);
zz
x
xx=[x zz'];
xx=xx';
%standard errors
%gg=gradp(&lpr2,xx);
ObjectiveFunction = @(x)lpr2(x,w1,w2,w3,w4,wp,p,o,s,oins,n,km,nd);
gg=gradient(ObjectiveFunction,xx);
vv=inv(gg'*mmm*gg);
%output file=agglogit2.out on;
%print "ND=1000";
%print;
%print "Standard errors for parameters";
[xx sqrt(diag(vv))]
%print;
%output off;
%end;
