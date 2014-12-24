function [relvntvar] = relvar(v,t, unblncPnl, n, T) %alpha,

% relvar is the relevant variance of the full platform diffusion system
if (t == T)
   relvntvar = v(1,1); % for this case there is no state equation for add-ons to use 
else
    if size(find(unblncPnl>t+1,1),1)>0
      til = find(unblncPnl>t+1,1)-1;
    else
        til = n;
    end
    relevent=til;
    temp = unblncPnl(1:relevent,2);
    relvntvar = v([1 temp'+1],[1 temp'+1]); % the first one for platform obs eq. the rest for add-on state eq.
end
