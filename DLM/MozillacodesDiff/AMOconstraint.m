function [c,ceq]=AMOconstraint(x) %,gradc,gradceq

% as AMO is monthly data
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
%yctemp = yctemp - repmat(mean(yctemp), [pT+1 1]); % demean to make sure there is no multicollinearity

x = x - mean(yctemp(:,3)); % demean to make sure that it is zero mean in the data

c=-14.4421-x; % just make sure that real x do not become negative (as contribution can not be negative) 
% the mean is free and I will set it to 14.4421 later
% By adding mean and rescaling back I will find the real number of
% contributions

ceq = [];




