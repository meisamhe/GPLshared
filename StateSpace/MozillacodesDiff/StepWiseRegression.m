%stepwise regression for alpha,p,q,delta (mean for 52 addons)on the explanatory variables
%------------------------------------------------------------------------------------------------------------------
% reading explained/dependent variables
%=================================================================================================================
[num,txt,raw] = xlsread('C:\Users\MHE\Desktop\ActiveCourses\Projects\FirefoxAddon(VeryLowPriority)\DiffData\AnalysisOFStepWiseRegression.xlsx',1); 
num=num(:,3:15); % list of variables: [1: delta, 2:6: p, 7:12: q, delta:13] in result
alpha = num(:,1);
p     = num(:,2:6);
q     = num(:,7:12);
delta = num(:,13);
%-------------------------------------------------------------------------------------------------------------------------

% read explanatory/independent variables for alpha
[num,txt,raw] = xlsread('C:\Users\MHE\Desktop\ActiveCourses\Projects\FirefoxAddon(VeryLowPriority)\DiffData\AnalysisOFStepWiseRegression.xlsx',2); 
 num=num(:,3:36); % list of variables
 x  = num;

% run stepwise regression to explain alpha
clc
[b,se,pval,inmodel,stats,nextstep,history]= stepwisefit(x,alpha)
%====================================================================================================================

% read explanatory/independent variables for p
[num,txt,raw] = xlsread('C:\Users\MHE\Desktop\ActiveCourses\Projects\FirefoxAddon(VeryLowPriority)\DiffData\AnalysisOFStepWiseRegression.xlsx',3); 
 num=num(:,3:36); % list of variables
 x  = num;

% run stepwise regression to explain p
clc
for i=1:size(p,2)
    [b,se,pval,inmodel,stats,nextstep,history]= stepwisefit(x,p(:,i))
end;
%====================================================================================================================


% read explanatory/independent variables for q
[num,txt,raw] = xlsread('C:\Users\MHE\Desktop\ActiveCourses\Projects\FirefoxAddon(VeryLowPriority)\DiffData\AnalysisOFStepWiseRegression.xlsx',4); 
 num=num(:,3:31); % list of variables
 x  = num;
% run stepwise regression to explain q
clc
for i=1:size(q,2)
    [b,se,pval,inmodel,stats,nextstep,history]= stepwisefit(x,q(:,i))
end;
%====================================================================================================================
% read explanatory/independent variables for delta
[num,txt,raw] = xlsread('C:\Users\MHE\Desktop\ActiveCourses\Projects\FirefoxAddon(VeryLowPriority)\DiffData\AnalysisOFStepWiseRegression.xlsx',5); 
 num=num(:,3:36); % list of variables
 x  = num;
 
% run stepwise regression to explain delta
clc
[b,se,pval,inmodel,stats,nextstep,history]= stepwisefit(x,delta)
%====================================================================================================================
% check multicollinearity

%check for alpha
alphaitems = [4,5,6,7,19,20,21,22,23,24,28,29,33];

 [num,txt,raw] = xlsread('C:\Users\MHE\Desktop\ActiveCourses\Projects\FirefoxAddon(VeryLowPriority)\DiffData\AnalysisOFStepWiseRegression.xlsx',2); 
 alphatotal = num(:,alphaitems);
 for i=1:size(alphaitems,2);
     indep = alphatotal;
     indep (:,i)=[];
     temp = regstats(alphatotal(:,i),indep,'linear');
     VIF =1/(1-temp.rsquare);
     disp(VIF);
 end;
 %-------------------=> Results: No multicollinearity

% check for p
pitmes = [3,4,5,6,7,11,12,13,14,15,20,22,24,30,33];
 [num,txt,raw] = xlsread('C:\Users\MHE\Desktop\ActiveCourses\Projects\FirefoxAddon(VeryLowPriority)\DiffData\AnalysisOFStepWiseRegression.xlsx',3); 
 ptotal = num(:,pitmes);
 for i=1:size(pitmes,2);
     indep = ptotal;
     indep (:,i)=[];
     temp = regstats(ptotal(:,i),indep,'linear');
     VIF =1/(1-temp.rsquare);
     disp(VIF);
 end;
 
  %-------------------=> Results: No multicollinearity


% check for q
qitems=[3,4,5,6,7,9,10,11,13,19,26,27,28];
 [num,txt,raw] = xlsread('C:\Users\MHE\Desktop\ActiveCourses\Projects\FirefoxAddon(VeryLowPriority)\DiffData\AnalysisOFStepWiseRegression.xlsx',4); 
 qtotal = num(:,qitems);
 for i=1:size(qitems,2);
     indep = qtotal;
     indep (:,i)=[];
     temp = regstats(qtotal(:,i),indep,'linear');
     VIF =1/(1-temp.rsquare);
     disp(VIF);
 end;

  %-------------------=> Results: Only multicollinearity in 12, so I
  %dropped it

 
% check for delta
deltaitems =  [4,5,6,19,20,21,22,23,24,27];
 [num,txt,raw] = xlsread('C:\Users\MHE\Desktop\ActiveCourses\Projects\FirefoxAddon(VeryLowPriority)\DiffData\AnalysisOFStepWiseRegression.xlsx',5); 
 deltatotal = num(:,deltaitems);
 for i=1:size(deltaitems,2);
     indep = deltatotal;
     indep (:,i)=[];
     temp = regstats(deltatotal(:,i),indep,'linear');
     VIF =1/(1-temp.rsquare);
     disp(VIF);
 end;

%iterate on each item and run stepwise regression and give the results
% [b,se,pval,inmodel,stats,nextstep,history]= stepwisefit(x,crimerate)