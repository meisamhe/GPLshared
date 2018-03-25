function [Jn] = Jmaddonpq(d,tt1,t,Tj,pT,ttp,tt0p,phetrgn,qhetrgn,rp,rq) %alpha,
                
if (pT-Tj+t-1 == 0)
%     Jn  =  2*(d(1)+(d(3+rp:2+rp+rq)'*qhetrgn(t,:)'))*tt1(1)./tt0p + d(2)+ (d(3:2+rp)'*phetrgn(t,:)')...
%         +(d(3+rp+rq:2+rp+2*rq)'*qhetrgn(t,:)'); % just starts from the difference b/w to arrays 
  Jn  =  2*((d(1+rp:rp+rq)'*qhetrgn(t,:)'))*tt1(1)./tt0p + 1 + (d(1:rp)'*phetrgn(t,:)')... %d(1)+ d(2)
        +(d(1+rp+rq:rp+2*rq)'*qhetrgn(t,:)')+d(rp+2*rq+1); % just starts from the difference b/w to arrays 
%   Jn  =  2*((d(1+rp:rp+rq)'*qhetrgn(t,:)'))*tt1(1)./tt0p + 1 + (d(1:rp)'*phetrgn(t,:)')... %d(1)+ d(2)
%         +(d(1+rp+rq:rp+2*rq)'*qhetrgn(t,:)'); % just starts from the difference b/w to arrays 
else
%     Jn  =  2*(d(1)+(d(3+rp:2+rp+rq)'*qhetrgn(t,:)'))*tt1(1)./ttp(pT-Tj+t-1) + d(2) + (d(3:2+rp)'*phetrgn(t,:)')...
%         +(d(3+rp+rq:2+rp+2*rq)'*qhetrgn(t,:)'); % just starts from the difference b/w to arrays
    Jn  =  2*((d(1+rp:rp+rq)'*qhetrgn(t,:)'))*tt1(1)./ttp(pT-Tj+t-1) + 1 + (d(1:rp)'*phetrgn(t,:)')... %d(1)+d(2)
        +(d(1+rp+rq:rp+2*rq)'*qhetrgn(t,:)')+d(rp+2*rq+1); % just starts from the difference b/w to arrays
%      Jn  =  2*((d(1+rp:rp+rq)'*qhetrgn(t,:)'))*tt1(1)./ttp(pT-Tj+t-1) + 1 + (d(1:rp)'*phetrgn(t,:)')... %d(1)+d(2)
%         +(d(1+rp+rq:rp+2*rq)'*qhetrgn(t,:)'); % just starts from the difference b/w to arrays
end;
