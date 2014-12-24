% Predicts probabilities and market shares for each alternative.
% Written by Kenneth Train on Dec 11, 2007.

%Inputs: coef is Kx1 where K is number of explanatory variables
%
%Globals: NCS: scale number of choice situations
%         NALT: scalar number of alternatives in each choice situation
%         IDDEP: (NCS*NALT)x1 vector identifying the chosen alternative (1=chosen, 0=nonchosen)
%         VARS: (NCS*NALT)xK matrix of explanatory variables
%         SIMTYPE: scalar simulation type indicator
%         SMSCALE: scalar that gives scale for smoothing in logit-smoothed accept-reject simulator
%         NDRAWS: scalar number of draws
%         SEED1: scalar seed for random number generator


%Output: probs: NALTxNCS matrix of predicted probabilities for each alternative in each choice situation

function probs=pred(param);

global NCS NALT IDDEP VARS SIMTYPE SMSCALE NDRAWS SEED1

%Arrange parameters
coef=param(1:size(VARS,2),1);
cholparam=param(size(VARS,2)+1:end,1);
cholmat=eye(NALT-1);
count=1;
for r=2:(NALT-1);
  for c=1:r; 
     cholmat(r,c)=cholparam(count,1);
     count=count+1;
  end;
end;



probs=zeros(NALT,NCS);
v=VARS*coef;
v=reshape(v,NALT,NCS);
y=reshape(IDDEP,NALT,NCS);
randn('state',SEED1); 
rand('state',SEED1);


if SIMTYPE ~= 3;
  for r=1:NCS;
      e=cholmat*randn(NALT-1,NDRAWS);    %(NALT-1)xNDRAWS: Create draws of error differences
      e=[zeros(1,NDRAWS);e];             %NALTxNDRAWS: append zero error difference for first alternative
      u=repmat(v(:,r),1,NDRAWS)+e;
      if SIMTYPE == 1;
         u= (u == repmat(max(u),NALT,1)); %NALTxNDRAWSIdentifies alt with highest utility
         probs(:,r)=mean(u,2);
      else
         u=exp(u.*SMSCALE);
         u=u./repmat(sum(u,1),NALT,1);
         probs(:,r)=mean(u,2);
      end
  end
end

if SIMTYPE == 3;
    cholmat=[zeros(NALT-1,1) cholmat];
    cholmat=[zeros(1,NALT);cholmat]; %This makes Choleski matrix for utilities, NALTxNALT
    varmat=cholmat*(cholmat');  %Covariance matrix of utilities
    z=zeros(NALT,1); 
    for r=1:NCS;
        e=rand(NALT-1,NDRAWS);
        for alt=1:NALT
            yy=z;
            yy(alt,1)=1;
            vtilde=v(yy==0,r)-repmat(v(yy==1,r),NALT-1,1);
            choltilde=varmat(yy==0,:)-repmat(varmat(yy==1,:),NALT-1,1);
            choltilde=choltilde(:,yy==0)-repmat(choltilde(:,yy==1),1,NALT-1);
            choltilde=chol(choltilde)';   %Transpose to make lower-triangular
            probs(alt,r)=ghk(vtilde,choltilde,e);
        end;
    end;
end;

ss=mean(y,2);
ps=mean(probs,2);

disp('Actual and predicted shares');
disp('     Alt      Actual    Predicted');
i=1:NALT;
disp([ i' ss ps ]);
disp('');
disp('Predicted probabilities are held in vector probs, which has size NALTxNCS.');

