x=[1	2	3	4	5	6	7	8	9	10	11	12	13	14	15	16	17	18	19	20	21	22	23	24	25	26	27	28	29	30	31	32	33	34	35	36	37	38	39	40	41	42	43	44	45	46	47	48	49	50
    ]';
d=[0	0	0	0	0	1	0	0	0	0	0	0	0	1	0	0	1	1	1	0	1	0	1	0	0	0	0	1	1	1	1	0	0	1	1	0	0	1	1	1	1	1	1	1	1	1	1	1	1	1
    ]';
[b,dev,stats] = glmfit(x,d,'binomial','link','logit')

z=[ones(50,1) x];
pwr=z*b;
prob=zeros(50,3);
for i=1:50;
    prob(i,1)=exp(pwr(i,1))/(1+exp(pwr(i,1)));
    prob(i,2)=1/(1+exp(pwr(i,1)));
    if (prob(i,1)>prob(i,2))
           prob(i,3)=1;
    end;
end;
cm=zeros(2,2); % confusion matrix
for i=1:50;
    if d(i,1)==0;
        if prob(i,3)==0;
           cm(1,1)=cm(1,1)+1; 
        else
           cm(1,2)=cm(1,2)+1;
        end;
    else
        if prob(i,3)==0;
           cm(2,1)=cm(2,1)+1; 
        else
           cm(2,2)=cm(2,2)+1;
        end;
    end;
end;
% calculating kappa
dm=2; % dimension of confusion matrix
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
% traditional discriminant analysis (Result of R)
trr=[0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1
]';
cmt=zeros(2,2); % confusion matrix
for i=1:50;
    if d(i,1)==0;
        if trr(i,1)==0;
           cmt(1,1)=cmt(1,1)+1; 
        else
           cmt(1,2)=cmt(1,2)+1;
        end;
    else
        if trr(i,1)==0;
           cmt(2,1)=cmt(2,1)+1; 
        else
           cmt(2,2)=cmt(2,2)+1;
        end;
    end;
end;
% to calculate kappa  and lambda the same code used above but for cmt
% since it is repitition I did not print this one out
% check sas result
cms=[18 6
    7 19];
cm=cms;
% again as above kappa and lambda the same code used above