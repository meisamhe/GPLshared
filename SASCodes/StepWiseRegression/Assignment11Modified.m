crimerate=[79.1	163.5	57.8	196.9	123.4	68.2	96.3	155.5	85.6	70.5	167.4	84.9	51.1	66.4	79.8	94.6	53.9	92.9	75	122.5	74.2	43.9	121.6	96.8	52.3	199.3	34.2	121.6	104.3	69.6	37.3	75.4	107.2	92.3	65.3	127.2	83.1	56.6	82.6	115.1	88	54.2	82.3	103	45.5	50.8	84.9
];
crimerate=crimerate';
x=[151	1	91	58	56	510	950	33	301	108	41	394	261
143	0	113	103	95	583	1012	13	102	96	36	557	194
142	1	89	45	44	533	969	18	219	94	33	318	250
136	0	121	149	141	577	994	157	80	102	39	673	167
141	0	121	109	101	591	985	18	30	91	20	578	174
121	0	110	118	115	547	964	25	44	84	29	689	126
127	1	111	82	79	519	982	4	139	97	38	620	168
131	1	109	115	109	542	969	50	179	79	35	472	206
157	1	90	65	62	553	955	39	286	81	28	421	239
140	0	118	71	68	632	1029	7	15	100	24	526	174
124	0	105	121	116	580	966	101	106	77	35	657	170
134	0	108	75	71	595	972	47	59	83	31	580	172
128	0	113	67	60	624	972	28	10	77	25	507	206
135	0	117	62	61	595	986	22	46	77	27	529	190
152	1	87	57	53	530	986	30	72	92	43	405	264
142	1	88	81	77	497	956	33	321	116	47	427	247
143	0	110	66	63	537	977	10	6	114	35	487	166
135	1	104	123	115	537	978	31	170	89	34	631	165
130	0	116	128	128	536	934	51	24	78	34	627	135
125	0	108	113	105	567	985	78	94	130	58	626	166
126	0	108	74	67	602	984	34	12	102	33	557	195
157	1	89	47	44	512	962	22	423	97	34	288	276
132	0	96	87	83	564	953	43	92	83	32	513	227
131	0	116	78	73	574	1038	7	36	142	42	540	176
130	0	116	63	57	641	984	14	26	70	21	486	196
131	0	121	160	143	631	1071	3	77	102	41	674	152
135	0	109	69	71	540	965	6	4	80	22	564	139
152	0	112	82	76	571	1018	10	79	103	28	537	215
119	0	107	166	157	521	938	168	89	92	36	637	154
166	1	89	58	54	521	973	46	254	72	26	396	237
140	0	93	55	54	535	1045	6	20	135	40	453	200
125	0	109	90	81	586	964	97	82	105	43	617	163
147	1	104	63	64	560	972	23	95	76	24	462	233
126	0	118	97	97	542	990	18	21	102	35	589	166
123	0	102	97	87	526	948	113	76	124	50	572	158
150	0	100	109	98	531	964	9	24	87	38	559	153
177	1	87	58	56	638	974	24	349	76	28	382	254
133	0	104	51	47	599	1024	7	40	99	27	425	225
149	1	88	61	54	515	953	36	165	86	35	395	251
145	1	104	82	74	560	981	96	126	88	31	488	228
148	0	122	72	66	601	998	9	19	84	20	590	144
141	0	109	56	54	523	968	4	2	107	37	489	170
162	1	99	75	70	522	996	40	208	73	27	496	224
136	0	121	95	96	574	1012	29	36	111	37	622	162
139	1	88	46	41	480	968	19	49	135	53	457	249
126	0	104	106	97	599	989	40	24	78	25	593	171
130	0	121	90	91	623	1049	3	22	113	40	588	160
];
scatter(x(:,1),crimerate); % pre-plot age (Rate vs. age)
scatter(x(:,2),crimerate); % Southern state
scatter(x(:,3),crimerate); % education preplot
scatter(x(:,4),crimerate); % local government expenditure1
scatter(x(:,5),crimerate); % police expenditure 2
scatter(x(:,6),crimerate); % labor force participation rate 
scatter(x(:,7),crimerate); % males per femail rate
scatter(x(:,8),crimerate); % population size
scatter(x(:,9),crimerate); % non white
scatter(x(:,10),crimerate); % unemployment rate 14-24
scatter(x(:,11),crimerate); %unemployment rate 25-39
scatter(x(:,12),crimerate); %median value transferable goods and assets
scatter(x(:,13),crimerate); %families earning
normplot(crimerate);
%my recreation of wheel for backward approach
mcv=x; %meaninful covariates
cvn=cellstr({'Age' 'S' 'Ed' 'Ex0' 'Ex1' 'LF' 'M' 'N' 'NW' 'U1' 'U2' 'W' 'X'});
stat =regstats(crimerate,mcv,'linear');
s=size(mcv);
pval=stat.tstat.pval; 
mpval=0;
maxindx=0;
for i=1:s(2)+1;
    if pval(i)>mpval;
        mpval=pval(i);
        maxindx=i;
    end;
end;
maxindx=maxindx-1;
step=1;
while (mpval>.05);
    pval
    cvn(maxindx)
    if (maxindx==1);
        mcv=mcv(:,maxindx+1:s(2));
        cvn=cvn(:,maxindx+1:s(2));
    else;
         btemp = mcv(:,1:maxindx-1);
         ttemp= mcv(:,maxindx+1:s(2));
         mcv=[btemp ttemp];
         bcvn= cvn(:,1:maxindx-1);
         tcvn= cvn(:,maxindx+1:s(2));
         cvn=[bcvn tcvn];
    end;
    stat =regstats(crimerate,mcv,'linear');
    s=size(mcv);
    pval=stat.tstat.pval;
    mpval=0;
    maxindx=0;
    for i=1:s(2)+1;
        if pval(i)>mpval;
            mpval=pval(i);
            maxindx=i;
        end;
    end;
    step=step+1; %next step
    maxindx=maxindx-1;
end;
pval
%forward
mcv=x; %meaninful covariates
cvn=cellstr({'Age' 'S' 'Ed' 'Ex0' 'Ex1' 'LF' 'M' 'N' 'NW' 'U1' 'U2' 'W' 'X'});
fsw=false;
%initiation
i=0;
min=1;
vvec=ones(1,13); % variable vector showing checked
for i=1:13;
    cov=x(:,i);
    stat =regstats(crimerate,cov,'linear');
   if (stat.tstat.pval(2)<min); 
      candidate=i; 
      min=stat.tstat.pval(2);
      pval=stat.tstat.pval;
   end;
end; % I know at least one var is in
% save profile of candidate
cov=x(:,candidate);
cvn(candidate) % first variable added
vvec(1,candidate)=0; % keep track of not adding multiple times
pval
nadd=1; % keeps number of added
for j=1:13;
    min=1;
    for i=1:13;
        if vvec(1,i)==1;
            tempc=cov;
            cov=[cov x(:,i)];
            stat =regstats(crimerate,cov,'linear');
           if (max(stat.tstat.pval)<min); 
              candidate=i; 
              min=max(stat.tstat.pval);
              pval=stat.tstat.pval;
           end;
           cov=tempc;
        end;
    end; 
    if (max(pval) >.05);
        j=100; % mean break the loop
    else
         %print profile of candidate
        cov=[cov x(:,candidate)];
        cvn(candidate)
        vvec(1,candidate)=0;
        pval
        nadd=nadd+1;
    end;
end;

%stepwise approach:
[b,se,pval,inmodel,stats,nextstep,history]= stepwisefit(x,crimerate)

% residual plot
beta=stat.tstat.beta;
modelx=[ones(47,1) x(:,4) x(:,13) x(:,3) x(:,1)];
ybar=modelx*beta;
res=crimerate-ybar;
scatter(x(:,4),res); % police expenditure 60 residual
scatter(x(:,13),res); % Medium income residual
scatter(x(:,3),res); % Education residual
scatter(x(:,1),res); % age residual plot

%fun = @(x0,y0,x1,y1) norm(y1-x1*(x0\y0))^2;  % residual sum of squares
%[in,history] = sequentialfs(fun,x,crimerate,'cv',5)
%fsra(crimerate,x)


