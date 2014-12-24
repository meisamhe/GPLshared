% Script to use with probit.m to check the inputs and specifications of the model
% Written by Kenneth Train, Jan 9, 2008, based on earlier code to use with logit.m

function ok=check

global NCS NROWS XMAT
global IDV NAMES B PREDICT
global NALT C SIMTYPE SMSCALE NDRAWS SEED1 


ok=0;

disp('Checking the data and specifications.');
disp('');

if ceil(NCS) ~= NCS | NCS < 1;
   disp(['NCS must be a positive integer, but it is set to ' num2str(NCS)]);
   disp('Program terminated.');
   return
end

if ceil(NALT) ~= NALT | NALT < 1;
   disp(['NALT must be a positive integer, but it is set to ' num2str(NALT)]);
   disp('Program terminated.');
   return
end

if NROWS ~= (NALT.*NCS);
  disp('NROWS does not equal NALT*NCS, as it must.');
  disp('Program terminated.');
  return
end

if sum(sum(ceil(IDV) ~= IDV | IDV < 1),1) ~ 0;
   disp('IDV must contain positive integers only, but it contains other values.');
   disp('Program terminated.');
   return
end

if ( size(XMAT,1) ~= NROWS)
      disp(['XMAT has ' num2str(size(XMAT,1)) ' rows']);
      disp(['but it should have NROWS= '  num2str(NROWS)   ' rows.']);
      disp('Program terminated.');
      return
end

if sum(XMAT(:,1) > NCS) ~= 0
     disp(['The first column of XMAT has a value greater than NCS= ' num2str(NCS)]);
     disp('Program terminated.');
     return
end

if sum(XMAT(:,1) < 1) ~= 0
     disp('The first column of XMAT has a value less than 1.');
     disp('Program terminated.');
     return
end

if sum(XMAT(:,2) > NALT) ~= 0
     disp(['The second column of XMAT has a value greater than NALT= ' num2str(NALT)]);
     disp('Program terminated.');
     return
end

if sum(XMAT(:,2) < 1) ~= 0
     disp('The second column of XMAT has a value less than 1.');
     disp('Program terminated.');
     return
end

k=reshape(XMAT(:,2),NALT,NCS);
for s=1:NALT;
if sum(k(s,:) ~= s,2) ~= 0
    disp('The second column of XMAT does not ascend from 1 to NALT for each choice situation.');
    disp('Program terminated.')
    return
end
end

if sum(XMAT(:,3) ~= 0 & XMAT(:,3) ~= 1) ~= 0
     disp('The third column of XMAT has a value other than 1 or 0.');
     disp('Program terminated.');
     return
end

for s=1:NCS
    k=(XMAT(:,1) == s);
    if sum(XMAT(k,3)) > 1
       disp('The third column of XMAT indicates more than one chosen alternative');
       disp(['for choice situation ' num2str(s)]);
       disp('Program terminated.');
       return
    end
    if sum(XMAT(k,3)) < 1
       disp('The third column of XMAT indicates that no alternative was chosen');
       disp(['for choice situation ' num2str(s)]);
       disp('Program terminated.');
       return
    end 
end

if sum(sum(isnan(XMAT)),2) ~= 0
   disp('XMAT contains missing data.');
   disp('Program terminated.');
   return
end;

if sum(sum(isinf(XMAT)),2) ~= 0
   disp('XMAT contains an infinite value.');
   disp('Program terminated.');
   return
end;

if sum(sum(isinf(XMAT)),2) ~= 0
   disp('XMAT contains an infinite value.');
   disp('Program terminated.');
   return
end;

if size(IDV,1) ~= 1;
   disp(['IDV must have 1 row and yet it is set to have ' num2str(size(IDV,1))]);
   disp('Program terminated.');
   return
end;

if sum(IDV > size(XMAT,2)) ~= 0;
   disp('IDV identifies a variable that is outside XMAT.');
   disp('IDV is');
   IDV
   disp('when each element must be no greater than')
   disp([num2str(size(XMAT,2)) ' which is the number of columns in XMAT.']);
   disp('Program terminated.');
   return
end;

if sum(IDV <= 3) ~= 0;
   disp('Each element in IDV must exceed 3');
   disp('since the first three variables in XMAT cannot be explanatory variables.');
   disp('But IDV is');
   IDV(:,1)
   disp('which has an element below 3.')
   disp('Program terminated.');
   return
end;


if size(NAMES,1) ~= 1;
   disp(['NAMES must have 1 row and yet it is set to have ' num2str(size(NAMES,1))]);
   disp('Program terminated.');
   return
end;

if size(IDV,2) ~= size(NAMES,2);
   disp(['IDV and NAMES must have the same length but IDV has length ' num2str(size(IDV,2))]);
   disp(['while NAMES has length ' num2str(size(NAMES,2))]);
   disp('Program terminated.');
   return
end; 

if size(B,1) ~= 1;
   disp(['B must have 1 row and yet it is set to have ' num2str(size(B,1))]);
   disp('Program terminated.');
   return
end;
  
if size(B,2) ~= size(IDV,2);
   disp(['B must have the same length as IDV but instead has length ' num2str(size(B,2))]);
   disp('Program terminated.');
   return
end; 

if size(C,1) ~= 1;
   disp(['C must have 1 row and yet it is set to have ' num2str(size(C,1))]);
   disp('Program terminated.');
   return
end;
  
if size(C,2) ~= 2 ; %((NALT*(NALT-1)/2)-1)
   disp(['C must has the wrong number of elements. It has ' num2str(size(C,2))]);
   disp(['but needs to have ' num2str(((NALT*(NALT-2)/2)-1))]);
   disp('Program terminated.');
   return
end;

if (SIMTYPE ~= 1) & (SIMTYPE ~= 2) & (SIMTYPE ~= 3);
   disp(['SIMTYPE must be 1, 2, or 3, but it is set to ' num2str(SIMTYPE)]);
   disp('Program terminated.');
   return
end 

if ceil(SMSCALE) < 0;
   disp(['SMSCALE must be a positive number, but it is set to ' num2str(SMSCALE)]);
   disp('Program terminated.');
   return
end


if ceil(NDRAWS) ~= NDRAWS | NDRAWS < 1;
   disp(['NDRAWS must be a positive integer, but it is set to ' num2str(NDRAWS)]);
   disp('Program terminated.');
   return
end

if ceil(SEED1) ~= SEED1 | SEED1 < 1;
   disp(['SEED1 must be a positive integer, but it is set to ' num2str(SEED1)]);
   disp('Program terminated.');
   return
end

if (PREDICT ~= 0) & (PREDICT ~= 1) & (PREDICT ~= 2);
   disp(['PREDICT must be 0, 1, or 2, but it is set to ' num2str(PREDICT)]);
   disp('Program terminated.');
   return
end

if (PREDICT >0) & sum(ceil(XMAT(:,2)) ~= XMAT(:,2),1) > 0;
   disp('The second colum of XMAT must contain positive integers only, in order to do predictions.')
   disp('but it contains other values.');
   disp('Program terminated.');
   return
end


ok=1;

