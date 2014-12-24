% run GA:
% start with current allocation
X0=[972
994
1011
1375
794
1673
1402
1537
1159
965
903
835
1047
923
801
1233
841
2416
2620
1776
1235
1624
2054
1834
1729
1276
1498
1346
1790
2275
2294
1360
951
1359
1261
1409
1391
1222
1805
1316
1720
1412
1651
1723
1470
1351
2093
1283];
X0 = X0';
% as AMO is monthly data
x=X0; % to convert to daily
yctemp(1, 3)   = 0;
yctemp(2:19, 3)=x(1);
yctemp(20:50, 3)=x(2);
yctemp(51:80, 3)=x(3);
yctemp(81:111, 3)=x(4);
yctemp(112:141, 3)=x(5);
yctemp(142:172, 3)=x(6);
yctemp(173:203, 3)=x(7);
yctemp(204:231, 3)=x(8);
yctemp(232:262, 3)=x(9);
yctemp(263:292, 3)=x(10);
yctemp(293:323, 3)=x(11);
yctemp(324:353, 3)=x(12);
yctemp(354:384, 3)=x(13);
yctemp(385:415, 3)=x(14);
yctemp(416:445, 3)=x(15);
yctemp(446:476, 3)=x(16);
yctemp(477:506, 3)=x(17);
yctemp(507:537, 3)=x(18);
yctemp(538:568, 3)=x(19);
yctemp(569:596, 3)=x(20);
yctemp(597:627, 3)=x(21);
yctemp(628:657, 3)=x(22);
yctemp(658:688, 3)=x(23);
yctemp(689:718, 3)=x(24);
yctemp(719:749, 3)=x(25);
yctemp(750:780, 3)=x(26);
yctemp(781:810, 3)=x(27);
yctemp(811:841, 3)=x(28);
yctemp(842:871, 3)=x(29);
yctemp(872:902, 3)=x(30);
yctemp(903:933, 3)=x(31);
yctemp(934:962, 3)=x(32);
yctemp(963:994, 3)=x(33);
yctemp(995:1026, 3)=x(34);
yctemp(1027:1058, 3)=x(35);
yctemp(1059:1084, 3)=x(36);
yctemp(1085:1115, 3)=x(37);
yctemp(1116:1146, 3)=x(38);
yctemp(1147:1176, 3)=x(39);
yctemp(1177:1207, 3)=x(40);
yctemp(1208:1237, 3)=x(41);
yctemp(1238:1268, 3)=x(42);
yctemp(1269:1299, 3)=x(43);
yctemp(1300:1327, 3)=x(44);
yctemp(1328:1358, 3)=x(45);
yctemp(1359:1388, 3)=x(46);
yctemp(1389:1419, 3)=x(47);
yctemp(1420:1424, 3)=x(48);
sum(yctemp(:, 3))
X0=yctemp(:, 3);
%X0=yctemp(:, 3)-mean(yctemp(:, 3)); % demeaning it
X0 = X0';
X0 = X0/100;
%constraint on probability only for now
% options  =  optimset('fmincon');
% % options = optimset(options,'Algorithm','interior-point','Display','Iter','TolCon',1e-13);
% % [xnew,fval,exitflag,output,lambda,grad,hessian] =fmincon(@(x)0,X0,[],[],[],[],lb,ub,'AMOconstraint',options);
% % X0 = xnew;
% %[ce,ceq]=shareconstraint(X0)
% %setting options
% options  =  optimset('fmincon');
% options = optimset(options,'Algorithm','interior-point','Display','Iter','TolCon',1e-13,'TolFun',1e-12,'TolX',1e-4);
% options = optimset(options,'MaxFunEvals',1e15,'GradObj','off','GradConstr','off');
% options = optimset(options,'MaxIter',1e15); %This keeps the previous options
% 
% 
% [x,fval,exitflag,output,lambda,grad,hessian] = fmincon(@(x)FirefoxAMOOptimizationFunction(X0,yp,pp,m0p,C0p,caddon,yc),X0,[],[],[],[],lb,ub,'AMOconstraint',options);

% display initial point
disp('initial point is:')
disp(FirefoxAMOOptimizationFunctionNew(X0,yp,pp,m0p,C0p,caddon,yc))
%pause
disp('Whether the constraint is met:')
[c,ce]=AMOconstraint(X0)
%pause

% run Genetic Algorithm
ObjectiveFunction = @FirefoxAMOOptimizationFunctionNew;
nvars = size(X0,2);    % Number of variables
%constraint on total AMo contribution
lb = -Inf(1,nvars); % for 48 month
ub = Inf(1,nvars); % Not close from the top
LB = lb';   % Lower bound
UB = ub';  % Upper bound
InitialPopulation = zeros(30,nvars);
% for i=2:30;
%     InitialPopulation(i,:)= 100*randn(1,nvars).*X0;
% end;
options = gaoptimset('Display','iter','Generations',1000*nvars); %'InitialPopulation',InitialPopulation
ConstraintFunction = @AMOconstraintNew;
[x,fval] = ga({ObjectiveFunction,yp,pp,m0p,C0p,caddon,yc},nvars,[],[],[],[],LB,UB, ...
    ConstraintFunction,gaoptimset)

 xresultGA = x;
 

 % aggregate monthly
monthlytransform =zeros(1,48);
monthlytransform(1)=sum(xresultGA(2:19));
monthlytransform(2)=sum(xresultGA(20:50));
monthlytransform(3)=sum(xresultGA(51:80));
monthlytransform(4)=sum(xresultGA(81:111));
monthlytransform(5)=sum(xresultGA(112:141));
monthlytransform(6)=sum(xresultGA(142:172));
monthlytransform(7)=sum(xresultGA(173:203));
monthlytransform(8)=sum(xresultGA(204:231));
monthlytransform(9)=sum(xresultGA(232:262));
monthlytransform(10)=sum(xresultGA(263:292));
monthlytransform(11)=sum(xresultGA(293:323));
monthlytransform(12)=sum(xresultGA(324:353));
monthlytransform(13)=sum(xresultGA(354:384));
monthlytransform(14)=sum(xresultGA(385:415));
monthlytransform(15)=sum(xresultGA(416:445));
monthlytransform(16)=sum(xresultGA(446:476));
monthlytransform(17)=sum(xresultGA(477:506));
monthlytransform(18)=sum(xresultGA(507:537));
monthlytransform(19)=sum(xresultGA(538:568));
monthlytransform(20)=sum(xresultGA(569:596));
monthlytransform(21)=sum(xresultGA(597:627));
monthlytransform(22)=sum(xresultGA(628:657));
monthlytransform(23)=sum(xresultGA(658:688));
monthlytransform(24)=sum(xresultGA(689:718));
monthlytransform(25)=sum(xresultGA(719:749));
monthlytransform(26)=sum(xresultGA(750:780));
monthlytransform(27)=sum(xresultGA(781:810));
monthlytransform(28)=sum(xresultGA(811:841));
monthlytransform(29)=sum(xresultGA(842:871));
monthlytransform(30)=sum(xresultGA(872:902));
monthlytransform(31)=sum(xresultGA(903:933));
monthlytransform(32)=sum(xresultGA(934:962));
monthlytransform(33)=sum(xresultGA(963:994));
monthlytransform(34)=sum(xresultGA(995:1026));
monthlytransform(35)=sum(xresultGA(1027:1058));
monthlytransform(36)=sum(xresultGA(1059:1084));
monthlytransform(37)=sum(xresultGA(1085:1115));
monthlytransform(38)=sum(xresultGA(1116:1146));
monthlytransform(39)=sum(xresultGA(1147:1176));
monthlytransform(40)=sum(xresultGA(1177:1207));
monthlytransform(41)=sum(xresultGA(1208:1237));
monthlytransform(42)=sum(xresultGA(1238:1268));
monthlytransform(43)=sum(xresultGA(1269:1299));
monthlytransform(44)=sum(xresultGA(1300:1327));
monthlytransform(45)=sum(xresultGA(1328:1358));
monthlytransform(46)=sum(xresultGA(1359:1388));
monthlytransform(47)=sum(xresultGA(1389:1419));
monthlytransform(48)=sum(xresultGA(1420:1424));



 
 % draw optimal path versus real path
 allocation=[972	958
994	1526
1011	1642
1375	1380
794	1450
1673	1298
1402	1651
1537	1201
1159	1571
965	1508
903	1435
835	1409
1047	1540
923	1280
801	1332
1233	1554
841	1556
2416	1455
2620	1210
1776	956
1235	1718
1624	1668
2054	1523
1834	1203
1729	1704
1276	1439
1498	1594
1346	1479
1790	1432
2275	1837
2294	1345
1360	1285
951	1670
1359	1347
1261	1472
1409	1407
1391	1485
1222	1631
1805	1532
1316	1538
1720	1283
1412	1329
1651	1640
1723	1492
1470	1608
1351	1462
2093	1380
1283	210];
ColorSet = varycolor(100);
set(0,'DefaultAxesColorOrder',[1 0 0;0 1 0;0 0 1],...
      'DefaultAxesLineStyleOrder','-|--|:')
set(gca, 'ColorOrder', ColorSet);
plot(allocation)
title('Editorial(AMO) Efforts'); xlabel('Month');
ylabel('Effort Level (Contribution)');
set(legend('Real AMO Contribution Level','Optimal AMO Contribution Level'),'FontAngle','italic','TextColor',[.3,.2,.1],'Location','SouthOutside','Orientation','horizontal');
figureHandle = gcf;
%# make all text in the figure to size 14 and bold
set(findall(figureHandle,'type','text'),'fontSize',14); %'fontWeight','bold'