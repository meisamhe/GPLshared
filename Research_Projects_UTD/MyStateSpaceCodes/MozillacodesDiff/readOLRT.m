function  [x,y,uT,ol,stvar,ver,wkend,status,Ti,stol,stavg] = readOLRT(num,Ti,alphabeta,p,tt1p,tt0p,pT,scale,pusg,ffxvrsn,numCatOL,numCatVAR,i) %,b1,b2,alpha %,int ,piai

   %use moving average for ol
%    ol = tsmovavg(fliplr(num(1:Ti+6,8)')','s',7,1);
%    ol = ol(7:Ti+6);
%    if (size(find(isnan(ol), 1, 'last' ),1) ~= 0)
%      Ti = Ti - find(isnan(ol), 1, 'last' );
%      oldsize = size(ol,1);
%      ol = ol((oldsize-Ti)+1:oldsize);
%    end;
   ol = fliplr(num(1:Ti,8)')'./numCatOL(1:Ti,i);%./pusg(pT-Ti+1:pT);
   y = fliplr(num(1:Ti,1)')'./scale; %M download
   x = ones(p,Ti);
   %ol  =fliplr(num(1:Ti,8)')'./scale; %M users
   stvar =  fliplr(num(1:Ti,17)')';%./numCatVAR(1:Ti,i); %M variance (Variance is considered in its absolute sense)
   wkend =  fliplr(num(1:Ti,26)')'; %M variance
   status  =fliplr(num(1:Ti,10)')'; %M users
   stol    = stvar.*ol;
   stavg   = fliplr(num(1:Ti,27)')'; %average rating observable
   %demaning olbservational learning rating, and interaction
   ol = ol - mean(ol);
   stvar = stvar - mean(stvar);
   stol = stol - mean(stol);
   status = status - mean(status);
   stavg = stavg - mean(stavg);
   
   ver =  fliplr(num(1:Ti,19)')'; %M variance
   vertemp = ver;
   brkpnttemp = find(ver);
   if (size(brkpnttemp,1)>0)
       if (size(brkpnttemp,1)>1)
           for i=1:size(brkpnttemp,1)-1
               vertemp(brkpnttemp(i):brkpnttemp(i+1)-1) = 0.89.^[1:brkpnttemp(i+1)-brkpnttemp(i)];
           end;
       end;
       i = size(brkpnttemp,1);
       vertemp(brkpnttemp(i):size(vertemp,1)) = 0.89.^[1:size(vertemp,1)-brkpnttemp(i)+1];
       ver  = vertemp;
   end;
   
   ver = ver - mean(ver);
   ffxvrsn = ffxvrsn - mean(ffxvrsn);
 %  olst =[ol st]; % int  ver
   phetrogn = [ones(Ti,1) ver ffxvrsn(pT-Ti+1:pT)]; %wkend [ones(Ti,1) ver]; % for heterogeneity in p %ver wkend  ol wkend ver wkend
   %ver.*ffxvrsn(pT-Ti+1:pT) wkend
%    size(phetrogn)
%    size(alphabeta)
%    size((phetrogn*alphabeta)')
%    size(x(1:Ti))
%    size([tt0p tt1p(pT-Ti+1:pT-1)])
   uT=  (phetrogn*alphabeta)'.*x(1:Ti).*[tt0p tt1p(pT-Ti+1:pT-1)]; %alphap*x(1:Ti).*[tt0p tt1p(pT-Ti+1:pT-1)]+
%   piai = diag(alphabeta);
   
return;