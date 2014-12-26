cm=[43	13	8	21	14
16	15	15	13	13
3	5	14	5	4
2	3	5	9	4
2	1	0	4	7];
% calculating kappa
diag=0;
xis=zeros(1,5);
xis2=zeros(1,5);
xsi=zeros(5,1);
xsi2=zeros(5,1);
for i=1:5;
    diag=diag+cm(i,i);
    xis(1,i)=sum(cm(i,:));
    xis2(1,i)=sum(cm(i,:))^2;
    xsi(i,1)=sum(cm(:,i));
    xsi2(i,1)=sum(cm(:,i))^2;
end;
sum1=xis*xsi;
sum2=xis*xsi2;
sum3=xis2*xsi;
N=sum(xsi);
kappa=(N*diag-sum1)/(N^2-sum1);
varkappa=(N^2*sum1+sum1^2-N*(sum2+sum3))/(N*(N^2-sum1)^2);
sd=sqrt(varkappa);
zscore=kappa/sd;
%goodman kruskal lambda
colmax=max(cm);
obs=sum(xis);
lambda=(sum(colmax)-max(xis))/(obs-max(xis));
% find column of max
maxcoli=0;
for i=1:5;
    if max(xis)==xis(1,i);
       maxcoli=i; 
    end;
end;
cons=0; % conditional sum
for i=1:5;
    if cm(maxcoli,i)==colmax(1,i)
        cons=cons+cm(maxcoli,i);
    end;
end;
varlam=(N-sum(colmax))*(sum(colmax)+max(xis)-2*cons)/(N-max(xis))^3;
sdlam=sqrt(varlam);
zscorevl=lambda/sdlam;

% calculating kappa
cm=[43	13	8	21	14
16	15	15	13	13
3	5	14	5	4
2	3	5	9	4
2	1	0	4	7];
dm=5; % dimension of confusion matrix
diag=0;
xis=zeros(1,dm);
xis2=zeros(1,dm);
xsi=zeros(dm,1);
xsi2=zeros(dm,1);
for i=1:dm;
    diag=diag+cm(i,i);
    xis(1,i)=sum(cm(i,:));
    xis2(1,i)=sum(cm(i,:))^2;
    xsi(i,1)=sum(cm(:,i));
    xsi2(i,1)=sum(cm(:,i))^2;
end;
sum1=xis*xsi;
sum2=xis*xsi2;
sum3=xis2*xsi;
N=sum(xsi);
kappa=(N*diag-sum1)/(N^2-sum1);
varkappa=(N^2*sum1+sum1^2-N*(sum2+sum3))/(N*(N^2-sum1)^2);
sd=sqrt(varkappa);
zscore=kappa/sd;
%goodman kruskal lambda
colmax=max(cm);
obs=sum(xis);
lambda=(sum(colmax)-max(xis))/(obs-max(xis));
% find column of max
maxcoli=0;
for i=1:dm;
    if max(xis)==xis(1,i);
       maxcoli=i; 
    end;
end;
cons=0; % conditional sum
for i=1:dm;
    if cm(maxcoli,i)==colmax(1,i)
        cons=cons+cm(maxcoli,i);
    end;
end;
varlam=(N-sum(colmax))*(sum(colmax)+max(xis)-2*cons)/(N-max(xis))^3;
sdlam=sqrt(varlam);
zscorevl=lambda/sdlam;