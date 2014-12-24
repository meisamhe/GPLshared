function [h] = hap(tt1, t, unblncPnl, tt2, GTtemp, piaitemp, T,til) %a,b,
% we needed t in order to corporate relevant add-ons only

if (t == T)
   h = tt1; % for this case there is no state equation for add-ons to use 
else
    h  = zeros(til+1,1); %first one for platform and the rest are add-ons
    % make sure the first one is the platform
    h(1) = tt1; % for the real data of ffx add-on observation equation 
    % we need for moment zero because our data is from moment 1 (which is from state eq. of add-ons)    
    
    
    h(2:til+1) = tt2((unblncPnl(1:til,2)-1)*T+t).^2./tt1.*reshape(GTtemp(1,1,unblncPnl(1:til,2)),[til 1])+ tt2((unblncPnl(1:til,2)-1)*T+t)...
                    .*reshape(GTtemp(2,2,unblncPnl(1:til,2)), [til 1])+(piaitemp(unblncPnl(1:til,2)))'.*tt1; 
    
end;
