mcv=x; %meaninful covariates
cvn=cellstr({'Age' 'S' 'Ed' 'Ex0' 'Ex1' 'LF' 'M' 'N' 'NW' 'U1' 'U2' 'W' 'X'});
fsw=false;
%initiation
i=0;
min=1;
vvec=ones(1,13); % variable vector showing checked
for i=1:13;
    cov=x(:,i);
    stat =regstats(crimerate,cov,'linear');
   if (stat.tstat.pval(2)<min); 
      candidate=i; 
      min=stat.tstat.pval(2);
      pval=stat.tstat.pval;
   end;
end; % I know at least one var is in
% save profile of candidate
cov=x(:,candidate);
cvn(candidate) % first variable added
vvec(1,candidate)=0; % keep track of not adding multiple times
pval
nadd=1; % keeps number of added
for j=1:13;
    min=1;
    for i=1:13;
        if vvec(1,i)==1;
            tempc=cov;
            cov=[cov x(:,i)];
            stat =regstats(crimerate,cov,'linear');
           if (max(stat.tstat.pval)<min); 
              candidate=i; 
              min=max(stat.tstat.pval);
              pval=stat.tstat.pval;
           end;
           cov=tempc;
        end;
    end; 
    if (max(pval) >.05);
        j=100; % mean break the loop
    else
         %print profile of candidate
        cov=[cov x(:,candidate)];
        cvn(candidate)
        vvec(1,candidate)=0;
        pval
        nadd=nadd+1;
    end;
end;

