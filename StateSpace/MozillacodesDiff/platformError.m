function [e] =  platformError(q,y,forecast,t,unblncPnl,tt2,n,r,F,T) %a,b,
% we needed t in order to corporate relevant add-ons only
% y here to calculate the error is only tt2 but with lead (rather than lag)

if (t == T)
   e = y - forecast(1); % for this case there is no state equation for add-ons to use 
else
    if size(find(unblncPnl>t+1,1),1)>0
        til = find(unblncPnl>t+1,1)-1;
    else
        til = n;
    end
    e  = zeros(til+1,1); %first one for platform and the rest are add-ons

    e(1) = y - forecast(1);
    parfor i=1:til;
        temptt = tt2{unblncPnl(i,2)};
        e(i+1) = temptt(t-unblncPnl(i,1)+2) - forecast(i+1); %because it is about state equation
    end;
end;  
