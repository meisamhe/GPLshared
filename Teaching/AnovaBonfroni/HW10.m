sor=[51	36	50	35	42
27	20	26	17	27
37	22	41	37	30
42	36	32	34	27
27	18	33	14	29
43	32	43	35	40
41	22	36	25	38
38	21	31	20	16
36	23	27	25	28
26	31	31	32	36
29	20	25	26	25
];
%first part incorrect assumption of independence
p = anova1(sor);
% ANOVA repeated measure
p2 = anova2(sor,1)
% Bonferroni method paired t-test
PAIRS=[ 
1	2
1	3
1	4
1	5
2	3
2	4
2	5
3	4
3	5
4	5
 ];
ALPHA =0.05;
TAIL =  0;%  the HA: "means are not equal."
[hb,pb,sigPairsb]=ttest_bonf(sor,PAIRS,ALPHA,TAIL);
% part 4: multivariate analysis
contrast=zeros(10,5);
for i=1:10;
    contrast(i,PAIRS(i,1))=1;
    contrast(i,PAIRS(i,2))=-1;
end;
covm=cov(sor);
csct=diag(contrast*covm*contrast')
p=5;
n=11;
cy=mean(sor)';
U=contrast*cy+sqrt(csct/n)*sqrt((p-1)*(n-1)/(n-p+1)*finv(1-.05,p-1,n-p+1));
L=contrast*cy-sqrt(csct/n)*sqrt((p-1)*(n-1)/(n-p+1)*finv(1-.05,p-1,n-p+1));
Cint=[L U];