% this function will only set component of matrix within range and sets the
% rest to zero => it is used for errors creation
function  result = setlimited(data,Tj,pT) %,b1,b2,alpha
   result = zeros(pT,1);
   result(pT-Tj+1:pT) = data; % to make sure that errors are multiplied for corresponding time
return;