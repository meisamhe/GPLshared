function y = lpr(x,w1,w2,w3,w4,wp,p,o,s,nudta,oins,mmm,n,km,nd);
%Random component of brand preferences & price: variances
aw1=x(1,1)*w1;
aw2=x(1,2)*w2;
aw3=x(1,3)*w3;
aw4=x(1,4)*w4;
% for same dimension convention of MATLAB
for i=1:1000;
    if i==1;
        om1=o(:,1);
        om2=o(:,2);
        om3=o(:,3);
        om4=o(:,4);
        pm=p(:,1);
    else;
        om1=[om1 o(:,1)];
        om2=[om2 o(:,2)];
        om3=[om3 o(:,3)];
        om4=[om4 o(:,4)];
        pm=[pm p];
    end;
end;
% aw=aw1.*o(:,1)+aw2.*o(:,2)+aw3.*o(:,3)+aw4.*o(:,4); Guss code
aw=aw1.*om1+aw2.*om2+aw3.*om3+aw4.*om4; % create effect of variance on each of the brands
awp=pm.*wp.*x(1,5); % price coefficient

%Contraction map
dd=zeros(4*n,1);
k=100;
de1=dd;
while(k>km);
    de=de1;
    nch=zeros(4*n,1);
    for i=1:nd;
        ch=(exp(aw(:,i)+awp(:,i)+de));
        ch=reshape(ch,n,4);
        sumcol=1+sum(ch');
        sumcol=sumcol';
        sumcol=[sumcol sumcol sumcol sumcol];
        ch=ch./(sumcol);
        nch=nch+(reshape(ch,4*n,1)/nd);
    end;
    de1=de+log(s)-log(nch);
    k=max(max((abs(de1-de))'));
end;
dd=de1;
zz=inv(nudta'*oins*mmm*oins'*nudta)*(nudta'*oins*mmm*oins'*dd);
er=dd-nudta*zz;
y=er'*oins*mmm*oins'*er;
