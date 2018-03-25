function [Jn] = Jmaddon(d,tt1,t,Tj,pT,ttp,tt0p,olst) %alpha,
                
if (pT-Tj+t-1 == 0)
%  Jn  =  2*d(1)*tt1(1)./m0p + d(2); % just starts from the difference b/w to arrays 
    Jn  =  2*d(1)*tt1(1)./tt0p + d(2)+ (d(3:size(olst,2)+2)'*olst(t,:)'); % just starts from the difference b/w to arrays 
else
%  Jn  =  2*d(1)*tt1(1)./mp(pT-Tj+t-1) + d(2); % just starts from the difference b/w to arrays
  Jn  =  2*d(1)*tt1(1)./ttp(pT-Tj+t-1) + d(2) + (d(3:size(olst,2)+2)'*olst(t,:)'); % just starts from the difference b/w to arrays
end;
%Jm  =  diag(Jm);


% if (t==1 )
%     Jm =  -d(1)*tt1(1).^2./m0p.^2 + aipi; 
% else
%     Jm =  -d(1)*tt1(1).^2./mp(pT-Tj+t-1).^2 + aipi; 
% end;
% 
% Jj = [Jn Jm];