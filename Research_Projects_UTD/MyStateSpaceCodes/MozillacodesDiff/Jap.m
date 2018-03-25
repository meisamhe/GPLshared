function [Ja] = Jap(tt1, t, unblncPnl, tt2, GTtemp, piaitemp, T,til) %alpha,

if (t == T)
   Ja = 1; % for this case there is no state equation for add-ons to use 
else
   % we needed t in order to corporate relevant add-ons only
    % make sure the first one is the platform
        Ja  = zeros(til+1,1); %first one for platform and the rest are add-ons
        Ja(1) = 1; % for the real data of ffx add-on observation equation 
        % we need for moment zero because our data is from moment 1 (which is from state eq. of add-ons)      
        % since I am conditioning for n_it-1 then I should use the real data

         Ja(2:til+1) =(reshape(GTtemp(1,1,unblncPnl(1:til,2)),[til 1])./(tt1.^2).*tt2((unblncPnl(1:til,2)-1)*T+t).^2) + piaitemp(unblncPnl(1:til,2))';
end;
