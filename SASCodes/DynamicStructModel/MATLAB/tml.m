
%===============================
%Define the likelihood function
%===============================

function tmll=tml()

    global par xgrid kgrid kcut id year expt rd prodv cap lnxs lnrd zpl u2 uz
    global nobs np T S ngrid nkgrid maxiter xmin xmax
    global dr0 etad etax betak scale rhox0 rhox1 rhox2 rhox3 gd gex gdex sigx
    global delta tol
    global nzparm ndparm neparm naparm nbparm nxparm npar
    %==================== 
    %Use these modules
    %====================

    %objective
    % tml

    % dynamic parameters
    % par=zeros(1,npr)
    % sigz,rhoz,xr0
    % gammaI1,gammaI2,gammaD1,gammaD2,gammaF1,gammaF2,gammaS1,gammaS2
    % a0,a1,a2,a3,b0,b1,b2,b3

    %=================================================
    % General Coding Parameter Definition
    %==================================================
    i=0; j=0; k=0; p=0; q=0; ios=0; iter=0;
    temp=0; tempi=0;
    tempc=zeros(2,1);

    %=======================================
    % Model Variable Declaration
    %=======================================

    %raw data variables
    % id, year
    % expt, rd, prodv, cap, lnxs, lnrd, zpl =zeros(nobs,1)

    %static profits
    pid=zeros(ngrid,nkgrid); pix =zeros(ngrid,nkgrid);

    %transition matrix for value functions
    Tx11=zeros(ngrid,ngrid); Tx10=zeros(ngrid,ngrid); Tx01=zeros(ngrid,ngrid); 
    Tx00=zeros(ngrid,ngrid); Tz=zeros(ngrid,ngrid); Tzx11=zeros(ngrid,ngrid); 
    Tzx10=zeros(ngrid,ngrid); Tzx01=zeros(ngrid,ngrid); Tzx00=zeros(ngrid,ngrid);

    %random grids
    zgrid=zeros(ngrid,1);  % u1=zeros(ngrid,1); u2

    %fixed grids
    % kgrid, kcut

    %value functions on the grids
    V11=zeros(ngrid,nkgrid); V10=zeros(ngrid,nkgrid); V01=zeros(ngrid,nkgrid); V00=zeros(ngrid,nkgrid);
    V11new=zeros(ngrid,nkgrid); V10new=zeros(ngrid,nkgrid); V01new=zeros(ngrid,nkgrid); V00new=zeros(ngrid,nkgrid);
    Evk11=0; Evk10=0; Evk01=0; Evk00=0; gammai=0; gammad=0; gammaf=0; gammas=0; Vrd1=0; Vrd0=0; Vnd1=0; Vnd0=0;
    tk=0; tc=0; eicost=0; escost=0; dicost=0; dscost=0; eecost=0; decost=0;

    %simulated z shocks
    varz=0; sigz0=0;
    z=zeros(np*T,S); %uz
    Szz=zeros(T,T); varc=zeros(T,T); varct=zeros(T,T); B=zeros(T,T); evec=zeros(T,T);
    %Szzp, tSzzp, Szpzp, invS, A, zpp
    dume=zeros(T,1);
    eval=zeros(T,1); tempv=zeros(T,1);  zplp =zeros(T,1); 

    %define the likelihood function
    xit=0; dit=0; eit=0; zit=0; ldit=0; leit=0; lzit=0; evit11=0; evit10=0; evit01=0; evit00=0;
            vrdi1=0; vndi1=0; vrdi0=0; vndi0=0; pxi=0; ccpe1=0; ccpd1=0;
    ki=0;
    ml=zeros(np,1);
    lfi=zeros(S,1);
    le=zeros(T,1); ld=zeros(T,1); lz=zeros(T,1);
    li=0;
    pz=zeros(ngrid,1); px11=zeros(ngrid,1); px10=zeros(ngrid,1); px01=zeros(ngrid,1); px00=zeros(ngrid,1);
    Tzx11i=zeros(ngrid,1); Tzx10i=zeros(ngrid,1); Tzx01i=zeros(ngrid,1); Tzx00i=zeros(ngrid,1);

    %================================
    %update dynamic parameters
    %================================
    rhoz=par(1,1);
    sigz=exp(par(1,2));

    gammaI1=par(1,3);
    gammaI2=par(1,3);
    gammaD1=par(1,4);
    gammaD2=par(1,4);
    gammaF1=par(1,5);
    gammaF2=par(1,5);
    gammaS1=par(1,6);
    gammaS2=par(1,6);

    a0=par(1,7);
    a1=par(1,8);
    a2=par(1,9);
    a3=par(1,10);
    b0=par(1,11);
    b1=par(1,12);
    b2=par(1,13);
    b3=par(1,14);

    xr0=par(1,15);
    %=============================================
    %read in the data
    %=============================================
    %datatrim=csvread('tatrim.csv');
    %id=datatrim(:,1); years=datatrim(:,2); expt=datatrim(:,3); rd=datatrim(:,4);
    %prodv=datatrim(:,5); cap=datatrim(:,6); lnxs=datatrim(:,7); lnrd=datatrim(:,8);

    %==============================
    %random grids of z
    %==============================
    varz=sigz*sigz/(1-rhoz*rhoz);
    % u2=normrnd(0,1,ngrid,1);
    zgrid=-3*sqrt(varz)+6*sqrt(varz)*u2;
    %for i=1:ngrid
    %	zgrid(i,1)=-3*sqrt(varz)+6*sqrt(varz)*i/ngrid;
    %end;

    %================================
    %define domestic market profit
    %================================
    for k=1:nkgrid;
        for i=1:ngrid;
              pid(i,k)=exp(dr0+(1+etad)*(betak*kgrid(k,1)-xgrid(i,1)))*(-1/etad)*scale; 
        end;
    end;

    %=============================
    %define export market profit
    %=============================
    for k=1:nkgrid;
        for i=1:ngrid;
           pix(i,k)=exp(xr0+(1+etax)*(betak*kgrid(k,1)-xgrid(i,1))+zgrid(i,1))*(-1/etax)*scale;
        end;
    end;

    %==============================================
    %define transition matrix of x and z over grids
    %==============================================
    for i=1:ngrid;
        for j=1:ngrid;
            temp=xgrid(j,1)-rhox0-rhox1*xgrid(i,1)-rhox2*xgrid(i,1)^2-rhox3*xgrid(i,1)^3;
            Tx11(i,j)=exp(-(temp-gd-gex-gdex)*(temp-gd-gex-gdex)/(2*sigx*sigx))/sigx;
            Tx10(i,j)=exp(-(temp-gd)*(temp-gd)/(2*sigx*sigx))/sigx;
            Tx01(i,j)=exp(-(temp-gex)*(temp-gex)/(2*sigx*sigx))/sigx;
            Tx00(i,j)=exp(-(temp)*(temp)/(2*sigx*sigx))/sigx;
            %normalize later on joint grids (x_n, z_n)
        end;
        Tx11(i,:)=Tx11(i,:)/sum(Tx11(i,:));
        Tx10(i,:)=Tx10(i,:)/sum(Tx10(i,:));
        Tx01(i,:)=Tx01(i,:)/sum(Tx01(i,:));
        Tx00(i,:)=Tx00(i,:)/sum(Tx00(i,:));
    end;

    for i=1:ngrid;
        for j=1:ngrid;
            Tz(i,j)=exp(-(zgrid(j,1)-rhoz*zgrid(i,1))^2/(2*sigz^2))/sigz;
        end;
        Tz(i,:)=Tz(i,:)/sum(Tz(i,:));
    end;

    %element by element multiplication
    Tzx11=Tx11*Tz;
    Tzx10=Tx10*Tz;
    Tzx01=Tx01*Tz;
    Tzx00=Tx00*Tz;

    for i=1:ngrid;
        Tzx11(i,:)=Tzx11(i,:)/sum(Tzx11(i,:));
        Tzx10(i,:)=Tzx10(i,:)/sum(Tzx10(i,:));
        Tzx01(i,:)=Tzx01(i,:)/sum(Tzx01(i,:));
        Tzx00(i,:)=Tzx00(i,:)/sum(Tzx00(i,:));
    end;

    %disp(transpose(Tzx10-Tzx00));
    %disp('============');
    %disp(transpose(Tzx01-Tzx00));
    %disp('============');
    %disp(transpose(Tzx11-Tzx00));

    %===========================================
    %start the value function iteration on grids
    %===========================================
    %initialize the value functions by (lagrd, lagexp)
    V11=0;   
    V10=0;  
    V01=0;	
    V00=0;

    V11new=(pid+pix)/(1-delta);
    V10new=pid/(1-delta);
    V01new=(pid+pix)/(1-delta);
    V00new=pid/(1-delta);

    iter=1; 

    while (max(abs(V11-V11new)) >tol | max(abs(V10-V10new))>tol |...
    max(abs(V01-V01new)) > tol | max(abs(V00-V00new))>tol & iter<= maxiter)

        iter=iter+1;
        if (iter>=maxiter) 
            disp('max iter exceeded');
            exit;
        end;

        V11=V11new;
        V10=V10new;
        V01=V01new;
        V00=V00new;

        for k=1:nkgrid;

            if (k<=4) 
                gammai=gammaI1;
                gammad=gammaD1;
                gammaf=gammaF1;
                gammas=gammaS1;
            else
                gammai=gammaI2;
                gammad=gammaD2;
                gammaf=gammaF2;
                gammas=gammaS2;
            end;

            for i=1:ngrid;
                %i. continue as rd performer
                Evk11=sum(Tzx11(i,:)*V11(:,k));
                Evk10=sum(Tzx10(i,:)*V10(:,k));

                tc=pix(i,k)+delta*(Evk11-Evk10);

                %previous exporter;
                Vrd1=pix(i,k)+delta*Evk11-expcdf(tc,gammaf)*gammaf;
                %new exporter
                Vrd0=pix(i,k)+delta*Evk11-expcdf(tc,gammas)*gammas;


                %ii. continue as non-rd performer
                Evk01=sum(Tzx01(i,:)*V01(:,k));
                Evk00=sum(Tzx00(i,:)*V00(:,k));

                tc=pix(i,k)+delta*(Evk01-Evk00);

                %previous exporter
                Vnd1=pix(i,k)+delta*Evk01-expcdf(tc,gammaf)*gammaf;
                %new exporter
                Vnd0=pix(i,k)+delta*Evk01-expcdf(tc,gammas)*gammas;

                %iii. iterate to get V11 V10

                %start as rd performer and exporter
                tc=Vrd1-Vnd1;

                V11new(i,k)=pid(i,k)+Vrd1-expcdf(tc,gammai)*gammai;

                %start as an non-rd performer and exporter

                V01new(i,k)=pid(i,k)+Vrd1-expcdf(tc,gammad)*gammad;

                %iv. iterate to get V01 V00

                %start as rd performer and non-exporter
                tc=Vrd0-Vnd0;

                V10new(i,k)=pid(i,k)+Vrd0-expcdf(tc,gammai)*gammai;

                %start as non-rd performer and non-exporter

                V00new(i,k)=pid(i,k)+Vrd0-expcdf(tc,gammad)*gammad;

            end;
        end;
    end;



    %disp(transpose(V11new));  
    %================================================================
    %draw random sequences of z shocks, conditional on export revenue
    %================================================================
    zpl=(lnxs-xr0).*(-1*(lnxs>0));

    %Simulate trajectory of z_{0}^{T} for each observation.
    z=0;
    %set up general covariance matrix
    temp=sigz^2/(1-rhoz^2);
    Szz=eye(T)*temp;
    for i=1:T;
        for k=1:T;
             if (i~=k)
                Szz(i,k)=rhoz^(abs(i-k))*temp;
             end;
        end;
    end;

    for p=1:np;
        dume(1:T,1)=expt(T*(p-1)+1:T*p,1);
        q=sum(dume);
        zplp(:,1)=zpl(T*(p-1)+1:T*p,1);

        Szzp=zeros(T,q);tSzzp=zeros(q,T);Szpzp=zeros(q,q);invS=zeros(q,q);A=zeros(T,q);zpp=zeros(q,1);
        k=0;
        for i=1:T;		
              if (dume(i,1)==1)
                  k=k+1	;
                  zpp(k,1)=zplp(i,1);
              end;	
        end;

        if ((q>0)& (q<T))
               %construct matrix Szzp, dimension T by q, delete years (col) with no exports
               %construct matrix Szpzp, dimension q by q, delete years (row, col) with no exports
            k=0;
            for i=1:T;		
                  if (dume(i,1)==1)
                      k=k+1;	
                      Szzp(:,k)=Szz(:,i);
                  end;	
            end;

            k=0;
            for i=1:T;
                  if (dume(i,1)==1)
                      k=k+1;
                      Szpzp(k,:)=Szzp(i,:);
                  end;
            end; 
            invS=inv(Szpzp);
            tSzzp=transpose(Szzp);
            varc=Szz-(Szzp*invS)*tSzzp;

            % check if any numerical negative diagonal
             for i=1:T;
                temp=varc(i,i);
                varc(i,i)=max(temp,0.0);
             end;
            A=Szzp*invS;

         elseif (q==T)
            varc=zeros(T,T); 
            A=eye(T);
        else
            varc=Szz;
            A=zeros(T,q);
        end;
        [evec,eval]=eig(varc); %eigen values
        eval=sort(diag(eval));
        % again check numerical negative eigen-value
        for i=1:T;
            tempv=zeros(T,1);
            tempv(i,1)=sqrt(max(eval(i,1),0.0));
            tempv=evec*tempv;
            B(:,i)=tempv(:,1);
        end;

        %check
        %varct=B*transpose(B);
        %disp( varc );
        %disp( varct );

        if (q>0) 
            for k=1:S;
                %tempv=A*zpp;
                z(T*(p-1)+1:T*p,k)=A(:,:)*zpp(:,1)+B(:,:)*uz(T*(p-1)+1:T*p,k);
            end;
        else
            z(T*(p-1)+1:T*p,:)=B*uz(T*(p-1)+1:T*p,:);
        end;

        Szzp=0;tSzzp=0;Szpzp=0;invS=0;A=0;zpp=0;
    end;

    %disp(transpose(z));


    %====================================================
    %define the likelihood function
    %====================================================
    ml=0;

    for i=1:np;

        %initialize likelihood 
        le=0;
        ld=0;
        lz=0;
        lfi=0;
        minaloc=kgrid.*(cap((i-1)*T+1,1)<=kcut);
        minaloc(minaloc==0)=Inf;
        tempc(:,1)= find(minaloc==min(minaloc));
        ki=tempc(1,1);

        if (ki<=4)
            gammai=gammaI1;
            gammad=gammaD1;
            gammaf=gammaF1;
            gammas=gammaS1;
        else
            gammai=gammaI2;
            gammad=gammaD2;
            gammaf=gammaF2;
            gammas=gammaS2;
        end;

        for k=1:S;

            for j=1:T;

                %----1. data
                xit=prodv((i-1)*T+j,1);
                dit=rd((i-1)*T+j,1);
                eit=expt((i-1)*T+j,1);
                zit=z((i-1)*T+j,k);

                %for non-initial years
                 if (j>1) 

                    ldit=rd((i-1)*T+j-1,1);
                    leit=expt((i-1)*T+j-1,1);
                    lzit=z((i-1)*T+j-1,k);

                    %-----2. observation time specific p(x_n|x_it,d_it,e_it), p(z_n|z_it)
                    pz=normpdf(zgrid,rhoz*zit,sigz);
                    temp=rhox0+rhox1*xit+rhox2*(xit^2)+rhox3*(xit^3);
                    px11=normpdf(xgrid,temp+gd+gex+gdex,sigx);
                    px10=normpdf(xgrid,temp+gd,sigx);
                    px01=normpdf(xgrid,temp+gex,sigx);
                    px00=normpdf(xgrid,temp,sigx);


                    Tzx11i=(pz.*px11)/sum(pz.*px11);
                    Tzx10i=(pz.*px10)/sum(pz.*px10);
                    Tzx01i=(pz.*px01)/sum(pz.*px01);
                    Tzx00i=(pz.*px00)/sum(pz.*px00);

                    %------3. calculate pxi, evit+1, veit, vdit
                    evit11=sum(Tzx11i(:,1).*V11(:,ki));
                    evit10=sum(Tzx10i(:,1).*V10(:,ki));
                    evit01=sum(Tzx01i(:,1).*V01(:,ki));
                    evit00=sum(Tzx00i(:,1).*V00(:,ki));
                    pxi=exp(xr0+(1+etax)*(betak*kgrid(ki,1)-xit)+zit)*(-1/etax)*scale;

                    tc=pxi+delta*(evit11-evit10);
                    %for previous exporter, continue with exporter fixed cost
                    vrdi1=pxi+delta*evit11-expcdf(tc,gammaf)*gammaf;

                    %for previous non-exporter, continue with exporter sunk cost
                    vrdi0=pxi+delta*evit11-expcdf(tc,gammas)*gammas;

                    tc=pxi+delta*(evit01-evit00);
                    %for previous exporter, continue with exporter fixed cost
                    vndi1=pxi+delta*evit01-expcdf(tc,gammaf)*gammaf;

                    %for previous non-exporter, continue with exporter sunk cost
                    vndi0=pxi+delta*evit01-expcdf(tc,gammas)*gammas;



                    %----4.1 eit*lnP(eit=1|xit, zit, kit, eit-1,dit)+(1-eit)*lnP(eit=0|xit, zit,kit, eit-1,dit)
                    ccpe1=leit*dit*expcdf(pxi+delta*(evit11-evit10), gammaf)+leit*(1-dit)*expcdf(pxi+delta*(evit01-evit00), gammaf)+...
                          (1-leit)*dit*expcdf(pxi+delta*(evit11-evit10), gammas)+(1-leit)*(1-dit)*expcdf(pxi+delta*(evit01-evit00), gammas);
                    le(j,1)=(eit)*ccpe1+(1-eit)*(1-ccpe1);

                    %----4.2 dit*lnP(dit=1|xit, zit, kit, eit-1, dit-1)+(1-dit)*lnP(dit=0|xit, zit,kit, eit-1, dit-1)
                    ccpd1=leit*ldit*expcdf(vrdi1-vndi1,gammai)+leit*(1-ldit)*expcdf(vrdi1-vndi1,gammad)+...
                        (1-leit)*ldit*expcdf(vrdi0-vndi0,gammai)+(1-leit)*(1-ldit)*expcdf(vrdi0-vndi0,gammad);
                    ld(j,1)=(dit)*ccpd1+(1-dit)*(1-ccpd1);

                    %----4.3 lnP(zit|zit-1)
                    lz(j,1)=1/(sigz*sqrt(2*acos(-1.0)))*exp(-(zit-rhoz*lzit)^2/(2*sigz^2));
                    lz(j,1)=lz(j,1)*(eit)+(1-eit);

                else		

                    %----5.1 ei0*lnP(ei0=1|xi0, zi0, ki0)+(1-ei0)*lnP(ei0=0|xi0,zi0,ki0)
                    temp=normcdf(a0+a1*xit+a2*zit+a3*kgrid(ki,1));
                    le(j,1)=(eit)*temp+(1-eit)*(1-temp);

                    %----5.2 di0*lnP(di0=1|xi0,zi0,ki0,ei0)+(1-di0)*lnP(di0|xi0,zi0,ki0,ei0)
                    temp=normcdf(b0+b1*xit+b2*zit+b3*kgrid(ki,1));
                    ld(j,1)=(dit)*temp+(1-dit)*(1-temp);

                    %----5.3 lnP(zi0)
                    sigz0=sigz/sqrt(1-rhoz^2);
                    lz(j,1)=1/(sigz0*sqrt(2*acos(-1.0)))*exp(-(zit)^2/(2*sigz0^2));
                    %get rid of the non-exporting years
                    lz(j,1)=lz(j,1)*(eit)+(1-eit);
                 end; 

            end;
            
            li=prod(lz)*prod(ld)*prod(le);

            lfi(k,1)=max(li,1e-30);

        end;
        ml(i,1)=log(sum(lfi)/S);
    end;

    tmll=sum(ml);
	
end




