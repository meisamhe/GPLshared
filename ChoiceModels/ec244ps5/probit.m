% Matlab code to estimate a probit model with maximum simulated likelihood.
% Allows accept-reject, smoothed accept-reject, and GHK simulation. 
% Assumes the same number of alternatives in each choice situation.
% Written by Kenneth Train, Jan. 9,, 2008, based on earlier code logit.m

clear all

% Declare GLOBAL variables
% GLOBAL variables are all in caps
% DO NOT CHANGE ANY OF THESE 'global' STATEMENTS
global NCS NROWS XMAT
global IDV NAMES B PREDICT
global MAXITERS PARAMTOL LLTOL
global VARS IDCASE IDDEP IDALT
global NALT C SIMTYPE SMSCALE NDRAWS SEED1 


% OUTPUT FILE
% Put the name you want for your output file (including full path if not the current 
% working directory) after words "delete" and "diary".
% The 'diary off' and 'delete filename' commands close and delete the previous version 
% of the file created during your current matlab session or in any previous sessions. 
% If you want to append the new output to the old output, then 
% put % in front of the 'diary off' and 'delete filename' commands (or erase them).

diary off
delete myrun.out
diary myrun.out

% TITLE
% Put a title for the run in the quotes below, to be printed at the top of the output file.
disp 'Meisam.he Probit of mode choice, with alts: car alone, carpool, bus, train.'

% DATA
        

% Number of choice situations in dataset.
NCS=453;   

% Number of alternatives in each choice situation
NALT=4;  

% Total number of alternatives in all choice situations combined.
% This is the number of rows of data in XMAT below.
% Do not change this line of code.
NROWS=453*4;

% Load and/or create XMAT, a matrix that contains the data.
%
% XMAT must contain one row of data for each alternative in each choice situation.
% The rows are grouped by choice situations.
% The number of rows in XMAT must be NROWS, specified above.
% The columns in XMAT are variable that describe the alternative.
% 
% The *first* column of XMAT identifies the choice situation. 
% The choice situations must be numbered sequentially from 1 to NCS, in ascending order.
% The *second* column of XMAT identifies the alternative for each choice situation.
% All alternatives for a given choice situation must be grouped together.
% The alternatives are numbered sequentially from 1 to NALT, in ascending order.
% The *third* column of XMAT identifies the chosen alternatives (1 for
% chosen, 0 for not). One and only one alternative must be chosen for each
% choice situation.
% The remaining columns of XMAT can be any variables.

XMAT=load('xdata.asc');  %The variables are described below
XMAT(:,5)=XMAT(:,5)./10; %To scale time
% increase cost of car only 50%. 
%XMAT((XMAT(:,6)==0 & XMAT(:,7)==0 & XMAT(:,8)==0),4)= 1.5*XMAT((XMAT(:,6)==0 & XMAT(:,7)==0 & XMAT(:,8)==0),4);

% 1. idcase: gives the observation number (1-900)
% 2. idalt: gives the alternative number (1-5)
% 3. depvar: identifies the chosen alternative (1=chosen, 0=nonchosen)
% 4. cost, in dollars per trip
% 5. time, in tens of minutes per trip
% 6. carpool asc
% 7. bus asc
% 8. rail asc


%Identify the columns of XMAT that you want to enter as explanatory variables in the model.

IDV=[4 5 6 7 8];

%Give names to the variables. Put the names in single quotes.'}

NAMES={'cost' 'time' 'carpool' 'bus' 'train' };

%Give starting values for the coefficients of these variables.

B=[-0.256 -0.289 -1.8583 -1.0936 -0.9234];
%zeros(1,size(IDV,2));


%Give starting values for the elements of the Choleski factor of the normalized covariance of utility differences
% differenced from first alternative. Top-left element is 1 by normalization, and so first element is row 2, col 1
%order is
% x
% 1 2
% 3 4 5
% etc.

C= [0.4131 0.4513]; %-0.1197 0.3623 0.4253
%[ 0.5000    0.8660   0.5000    0.2887    0.8165]; %This represents independent utilities


%Type of simulation: 1=accept-reject, 2=logit smoothed accept-reject, 3= GHK
%Do not use accept-reject (SIMTYPE=1) for estimation since the gradient-based optimizer will fail.
%Use accept-reject only for prediction (ie when PREDICT==2).
SIMTYPE=2;

%If you are using logit-smoothed accept-reject simulator (SIMTYPE=1), then set the scale to be used
%in smoothing. Simulated utility is multiplied by this scale when entering the logit formula
%so a larger SMSCALE means closer to 0-1 accept-reject and a smaller SMSCALE means more smoothing.
SMSCALE=20;

%Number of draws to use in simulation
NDRAWS=100;

%Seed to use for random number generator
SEED1=1324;

%Do you want to predict probabilities and aggregate shares for each alternative?
%Predicted shares are given for each unique value (ie alternative number) in the second column of XMAT.
%Predicted probabilities for each alternative in each choice situation are held in vector probs, which is NROWSx1.
%Set PREDICT=0 to estimate only and not predict
%    PREDICT=1 to estimate the model and then predict at the estimated coefficients
%    PREDICT=2 to predict at the starting values for B and C and not estimate

PREDICT=0;

% OPTIMIZATION 
% Maximum number of iterations for the optimization routine.
% The code will abort after ITERMAX iterations, even if convergence has
% not been achieved. The default is 400, which is used when MAXITERS=[];
MAXITERS=[];

% Convergence criterion based on the maximum change in parameters that is considered
% to represent convergence. If all the parameters change by less than PARAMTOL 
% from one iteration to the next, then the code considers convergence to have been
% achieved. The default is 0.000001, which is used when PARAMTOL=[];
PARAMTOL=[];

% Convergence criterion based on change in the log-likelihood that is
% considered to represent convergence. If the log-likelihood value changes
% less than LLTOL from one iteration to the next, then the optimization routine
% considers convergence to have been achieved. The default is 0.000001,
% which is used when LLTOL=[];
LLTOL=[];

%Do not change the next line. It runs the model.
doit
