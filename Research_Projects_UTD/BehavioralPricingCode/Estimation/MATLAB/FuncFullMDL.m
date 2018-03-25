% this function is to find c and bp to evaluate full mode (d1c+d2c-bpP2)

function  [LL,grad] = FuncFullMDL(x,P1,P2,Dur1,Dur2,lambda,gamma,cost,delta) %,b1,b2,alpha 

   global vcm se_est betas variance
   
   [J,T]=size(delta);
   
   c = exp(x(1)); % constraint to make sure it is positive
   bp = -exp(x(2)); % to make sure it is negative
   
   dd        =    delta; % first segment utility portion %{1};solution{2};solution{3}
   dd_n=reshape(dd',J*2,1);

    %beta=[alpha alphap betar];
    p = 4;
    X1= [(0.5*Dur1+gamma.*Dur2)*c+bp*P1 cost lambda.*(P1-P2) zeros(J,1)];
    X2= [gamma.*lambda.*Dur2.*0.5*c+bp*gamma.*lambda.*P2 gamma.*lambda.*cost zeros(J,1) gamma.*(ones(J,1)-lambda).*max((0.5*Dur1+gamma.*Dur2)*c + bp*P1,1e-50)];

    X=[X1 X2]';
    Xn=reshape(X,p,J*2);
    Xn=Xn'; %stack X's
    Yn=dd_n;
    
    % modify the part that I know
    p = 3; % because the first column was data
    Yn=dd_n-Xn(:,1); % take the data out
    Xn=Xn(:,2:4); %stack X's

    %OLS
    XnXnInv =(Xn'*Xn)\speye(size(Xn'*Xn));
    betas=XnXnInv*Xn'*Yn;
    errors=Yn-Xn*betas;
    vcm=(errors'*errors)*XnXnInv/(2*J);
    se_est=sqrt(diag(vcm));

    % calculate variance
    variance                 =    mean(errors.^2);
    
    LL =    -(- 0.5*T*J*log(2*pi*variance) -   0.5*sum(errors.^2/variance));
    
    dcp1 =[(0.5*Dur1+gamma.*Dur2) P1];
    
        
    dcp2 = [gamma.*lambda.*Dur2.*0.5 gamma.*lambda.*P2] + repmat(betas(3)*gamma.*(ones(J,1)-lambda),[1 2]).*repmat(((0.5*Dur1+gamma.*Dur2)*c + bp*P1>1e-50),[1 2]).*[(0.5*Dur1+gamma.*Dur2) P1];
    
    dcp=[dcp1 dcp2]';
    dcp=reshape(dcp,2,J*2);
    dcp=dcp'; %stack X's
    
    dvariance = mean(2*repmat(errors,[1 2]).*dcp);
    
    grad =  -(-0.5*T*J* dvariance/variance);
return;