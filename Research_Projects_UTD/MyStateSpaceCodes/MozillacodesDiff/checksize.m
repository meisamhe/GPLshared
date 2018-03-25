function n=checksize(y) 
n=size(y,1);
for i=1:size(y,1);
    if (isnan(y(i,1)))
        n=i-1;
        break
    end;
end;
