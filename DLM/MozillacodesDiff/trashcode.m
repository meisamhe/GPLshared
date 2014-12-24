% all the following are taken out to make the code clean

    % create conditional variance for each addon 
    % create conditional variance of state equation(j+1'th element)
%      w (j) = D1(j+1,j+1) - D1(j+1,[1:j j+2:(2*n+2)])* (D1([1:j j+2:(2*n+2)],[1:j j+2:(2*n+2)]))...
%          \speye(size((D1([1:j j+2:(2*n+2)],[1:j j+2:(2*n+2)]))))...%     inv(D1([1:j j+2:(2*n+2)],[1:j j+2:(2*n+2)]))...
%         * D1([1:j j+2:(2*n+2)],j+1); 
    % create conditional variance of observation equation of each addon (n+2+j=n+j+2'th element) 
%      v (j)  = D1(n+2+j,n+2+j) - D1(n+2,[1:n+1+j n+3+j:(2*n+2)])* (D1([1:n+1+j n+3+j:(2*n+2)],[1:n+1+j n+3+j:(2*n+2)]))...
%          \speye(size((D1([1:n+1+j n+3+j:(2*n+2)],[1:n+1+j n+3+j:(2*n+2)]))))...%  inv(D1([1:n+1+j n+3+j:(2*n+2)],[1:n+1+j n+3+j:(2*n+2)]))...
%         * D1([1:n+1+j n+3+j:(2*n+2)],n+2+j); 


%[m(:,1:T(j),j),C(:,:,1:T(j),j),m0(:,:,j),C0(:,:,j),tt1(j,1:T(j)),tt0]     =     kalffbsFD(y(j, 1:T(j)),F,p,m0(:,:,j),C0(:,:,j),v(j),w(j),GT(:,:,j),uT(1:T(j),j)',j);   %,a,b,alpha
        %b_(1:T(j),jp,j)          =     reshape(tt1(j,1:T(j))',T(j)*p,1); 
		        %fprintf(fidb_, '%19f\n', reshape(tt1{j}',T(j)*p,1));
        %b0_(:,jp,j)         =     tt0;
		       % fprintf(fidb0_, '%19f\n', tt0);
        
        % m0_(:,:,j,jp)
		        % fprintf(fidm0_, '%19f\n',m0{j});
        % C0_(:,:,j,jp)
		     %   fprintf(fidC0_, '%19f\n',C0{j});
		
		
%     bt(1,1)=-1;
%     while ((bt(1,1)<0) || (bt(1,1)>1)); %make sure it complies with theory
%         bt   =  b1 + chol(S1)'*randn(length(b1),1);
%     end;
%    btemp(:,j)=bt; % to use in cross section

   % create errors of platform equation
    % create errors of the system equation
   % eetemp(:,1) =(ttr1-ttind1(1:pT,1:2)*btp(1:2,1)-uTp'); %since it is for platform it is full
   
    % create errors of the observation equation
    %eetemp(:,n+2)=(yp - ttr1); % to use it in order to recover full variance matrix
	
	 %tt1(j,1:T(j))';
        % creating the independant
        %ttind1=[[tt0;tt1(1,1:T(j)-1)'].^2 [tt0;tt1(1,1:T(j)-1)'] x(j,1:T(j))']; % drop last value
        %ttind1=[[tt0;tt1(1,1:T(j)-1)'].^2 [tt0;tt1(1,1:T(j)-1)'] x{j}']; % drop last value
		
		
		%     bt(1,1)=-1;
    %     while ((bt(1,1)<0) || (bt(1,1)>1)); %make sure it complies with theory
    %         bt   =  b1 + chol(S1)'*randn(length(b1),1);
    %     end;
    %    btemp(:,j)=bt; % to use in cross section
	        %uT(1:T(j),j)=   bt(3,1)*x(j,1:T(j));
	
	% uT  = diag(bt(3,1))*x;
	
	       
       % create errors of the system equation
        %eetemp(:,j+1)   = setlimited(ttr1-ttind1(1:T(j),1:2)*bt(1:2,1)-uT{j}',T(j),pT);
                
        % create errors of the observation equation
        %eetemp1(:,j)= setlimited((y{j} - ttr1),T(j),pT);
		
		
		            %c_(:,jp,j)
					
					%  fprintf(fidc_, '%19f\n',[bt;v(j);w(j)]);
		
     
	 %BassLogLL(y(j, 1:T(j)),F,p,m0(:,:,j),C0(:,:,j),v(j),w(j),GT(:,:,j),uT(1:T(j),j)',j);
           %fprintf(fidLL_, '%19f\n',LL (1,jp));
		   
	%BassLogLL(y(j, 1:T(j)),F,p,m0(:,:,j),C0(:,:,j),v(j),w(j),GT(:,:,j),uT(1:T(j),j)',j);
	
	    %simulate vp,wp,vi ~ IW (System Equation)
    df = 2*n+2 + df0;
    Sig = (Sig0inv + ee'*ee)\speye(size(Sig0inv + ee'*ee)); % inv(Sig0inv + ee'*ee);
    D1inv = wishrnd(Sig,df);
	D1 = D1inv\speye(size(D1inv));
    
    % create conditional variance of the platform  
    % create conditional variance for observation the next round of platform ffbs
    vp = D1(1:n+1,1:n+1) - D1(1:n+1,n+1:(2*n+2))*  (D1(n+1:(2*n+2),n+1:(2*n+2))) ...
        \speye(size((D1(n+1:(2*n+2),n+1:(2*n+2)))))... %   inv(D1(n+1:(2*n+2),n+1:(2*n+2)))
        * D1(n+1:(2*n+2),1:n+1); 
    % create conditional variance of state equation of platform (n+2'th element)
     wp = D1(n+2,n+2) - D1(n+2,[1:n+1 n+3:(2*n+2)])*(D1([1:n+1 n+3:(2*n+2)],[1:n+1 n+3:(2*n+2)]))...
         \speye(size((D1([1:n+1 n+3:(2*n+2)],[1:n+1 n+3:(2*n+2)])))) ... %  inv(D1([1:n+1 n+3:(2*n+2)],[1:n+1 n+3:(2*n+2)]))...
        * D1([1:n+1 n+3:(2*n+2)],n+2); 
		
		    % prepare error matrix
    ee(:,1:n+2)       =   eetemp;    % for errors of add-on state equations (which is observation equation for platform)
    ee(:,n+3:(2*n+2))   =   eetemp1;     % for errors of add-on observation equation
   
    %simulate vp,wp,vi ~ IW (System Equation)
    df = 2*n+2 + df0;
    Sig = (Sig0inv + ee'*ee)\speye(size(Sig0inv + ee'*ee)); % inv(Sig0inv + ee'*ee);
    D1inv = wishrnd(Sig,df);
	D1 = D1inv\speye(size(D1inv));
    
    % create conditional variance of the platform  
    % create conditional variance for observation the next round of platform ffbs
    vp = D1(1:n+1,1:n+1) - D1(1:n+1,n+1:(2*n+2))*  (D1(n+1:(2*n+2),n+1:(2*n+2))) ...
        \speye(size((D1(n+1:(2*n+2),n+1:(2*n+2)))))... %   inv(D1(n+1:(2*n+2),n+1:(2*n+2)))
        * D1(n+1:(2*n+2),1:n+1); 
    % create conditional variance of state equation of platform (n+2'th element)
     wp = D1(n+2,n+2) - D1(n+2,[1:n+1 n+3:(2*n+2)])*(D1([1:n+1 n+3:(2*n+2)],[1:n+1 n+3:(2*n+2)]))...
         \speye(size((D1([1:n+1 n+3:(2*n+2)],[1:n+1 n+3:(2*n+2)])))) ... %  inv(D1([1:n+1 n+3:(2*n+2)],[1:n+1 n+3:(2*n+2)]))...
        * D1([1:n+1 n+3:(2*n+2)],n+2); 
		
	%b_(1:T(j),jp,j)          =     reshape(tt1(j,1:T(j))',T(j)*p,1); 
	       %fprintf(fidb_, '%19f\n', reshape(tt1{j}',T(j)*p,1));
        %b0_(:,jp,j)         =     tt0;
		
		       % fprintf(fidb0_, '%19f\n', tt0);
        %c_(:,jp,j)
		     %   df_(:,jp)         =     D1(:);         % to save full var-covar matrix
      %  fprintf(fidc_, '%19f\n',[bt;v(j);w(j)]);
       % m0_(:,:,j,jp)
	        %   fprintf(fidm0_, '%19f\n',m0{j});
        %C0_(:,:,j,jp)
		     %   fprintf(fidC0_, '%19f\n',C0{j});
			         %BassLogLL(y(j, 1:T(j)),F,p,m0(:,:,j),C0(:,:,j),v(j),w(j),GT(:,:,j),uT(1:T(j),j)',j);
        %fprintf(fidLL_, '%19f\n',LL (1,jp));
		
		 df0 = pT;
		 Sig0 = eye((2*n+2)*(2*n+2))/5;
		 Sig0inv =  Sig0\speye(size(Sig0));%inv(Sig0);
		 
		
		%  Jm =  [1- d(1)*alpha(1)*tt1(1)^(alpha(1)-1); ...
		%         1- d(2)*alpha(2)*tt1(2)^(alpha(2)-1)];
		%  Jm =  diag(Jm);

		%f = d(1)*tt1(1,t-1).^2 + d(2)*tt1(1,t-1);
		
		
		+  BassLogLLPlatform(yp(1:pT),F,pp,m0p(:,:),C0p(:,:),vp,wp,GTp(:,:),uTp(1:pT)')
		
		  BassLogLLAdon(y{j},F,p,m0{j},C0{j},v(j),w(j),GT(:,:,j),uT{j}',j); 
		  
		  
		C0_mean = cell([1 n]);
		m0_mean = cell([1 n]);
		C0_temp = zeros((ndraw-ndraw0)/jumps, n);
		m0_temp = zeros((ndraw-ndraw0)/jumps, n);
		parfor i=1:(ndraw-ndraw0)/jumps;
			i
		   m0_temp(i,:)   =   cell2mat(m0i_{j});
		   C0_temp(i,:)   =  cell2mat(C0i_{j}); 
		end;
		
		parfor j=1:n;
		j
		 m0_mean{j}   =   mean(m0_temp(:,j));
		 C0_mean{j}   =   mean(C0_temp(:,j));
		end;
		% for the platform
		m0p_mean(:,:) = mean(m0p_);
		C0p_mean(:,:) = mean (C0p_mean);
		LLtemp (j)      =  BassLogLL(y{j},F,p,m0_mean{j},C0_mean{j},v(j),w(j),GT(:,:,j),uT{j}',j);
	
		m0i_{jp}   =   m0_;
        C0i_{jp}   =  C0_;
		  
		m0_{j}   =   m0{j};
		C0_{j}   =  C0{j};
		m0p_(:,:,jp)   =   m0p;
        C0_(:,:,jp)   =  C0p;
		
		 fidm0_ = fopen('m0_parameterHBKFNoPltfrm.txt', 'a');
        fidC0_ = fopen('C0_parameterHBKFNoPltfrm.txt', 'a');
		 fclose(fidm0_);
         fclose(fidC0_);
		 %LLmean      = LLmean + BassLogLL(y(1:T(j),j),F,p,m0_mean(:,:,j),C0_mean(:,:,j),v(j),w(j),GT(:,:,j),uT(1:T(j),j)',j);
		 
		 %mean of hyper parameters
		 m0_        =   cell([1 1 n ((ndraw-ndraw0)/jumps)]);
		 m0i_       =   cell([1 1 n ((ndraw-ndraw0)/jumps)]);
		 %zeros(1,1,n,((ndraw-ndraw0)/jumps));
		 C0_ = cell([p p n ((ndraw-ndraw0)/jumps)]);
		 C0i_ = cell([p p n ((ndraw-ndraw0)/jumps)]);
		 
		m0p_ = zeros(p,1,(ndraw-ndraw0)/jumps);
		C0p_ = zeros(p,p,(ndraw-ndraw0)/jumps);
		
		  tt1{i} = 5*rand(1,size(y{i}));
		tt0{i}= 5 * rand(1,1);%zeros(1,n);
		
		LLmean      =  sum(LLtemp) + BassLogLLPlatform(yp(1:pT),F,pp,m0p_mean(:,:),C0p_mean(:,:),vp,wp,GTp(:,:),uTp(1:pT)');
		
		%disp([d' beta v w; mean(c_,2)']);
		
		% LINEAR Goodwill
%for  t =  2:T+1 tt1(1,t) =  d(1)*tt1(1,t-1) + uT(1,t-1) + ew(1,t-1); end;
%for  t =  2:T+1 tt1(2,t) =  d(2)*tt1(2,t-1) + uT(2,t-1) + ew(2,t-1); end; plot(tt1);
%a      =  rand(1,5); b = rand(1,5); alpha = [1.2; 1.05];

    %y(i, 1:T(i)) = fliplr(num(1:T(i),1)')'./1e3; %K download
    %x(i,1:T(i)) = ones(p,T(i));
%  usg(1:T(1,i),i)=fliplr(num(1:T(1,i),8)')'; %usage
%   strm(1:T(1,i),i)= fliplr((num(1:T(1,i),15))')';
%     srch(1:T(1,i),i)=fliplr(num(1:T(1,i),20)')'; %search data
%     version(1:T(1,i),i)= fliplr((num(1:T(1,i),19))')'; %versioning
%     Z(1:T(1,i),i)=fliplr((num(1:T(1,i),26))')'; %Weekend dummy
%     y(1:T(1,i),i)=y(1:T(1,i),i)./1e3; %y=log(y+1)
    %y(1:T(1,i),i)=y(1:T(1,i),i)-Xi*Z(1:T(1,i),i);
  %  usg(1:T(1,i),i)=usg(1:T(1,i),i)./1e6; %usg=log(usg)
  %  X(1:T(1,i),((k-1)*(i-1)+1):(k-1)*i)=[usg(1:T(1,i),i) strm(1:T(1,i),i)  strm(1:T(1,i),i).^2 version(1:T(1,i),i) srch(1:T(1,i),i)];
  %  uT(1:T(1,i),i)   = X(1:T(1,i),((k-1)*(i-1)+1):(k-1)*i)*beta(:,:,i);
  %uT(1:T(1,i),i)=diag(beta)*x(i,1:T(i));
  
   %clear all;
% load data;   % linear state equation equation - nerlove arrow
 
 %load data2;   % nonlinear state equation equation - nerlove arrow
 
 global Y1 MAD MSE 
 
 global Y1 MAD MSE
 
 tt1p pT tt0p
 
  Y1 =[]; MAD =[]; MSE =[];
  Y1 = zeros(max(T(:)),n);
  MAD=zeros(max(T(:)),n); MSE=zeros(max(T(:)),n); 
  
   disp('d is:');
     d
     disp('mt is:');
     mt
     disp('j is:')
     j
     disp('size of a is:')
     a
     forecast = ha(a); 
     disp('size of frecast is:')
     size(forecast)
     disp('size of Y1(t,j) is:')
     size(Y1(t,1))
	 
	 disp('t is')
 t
 disp('pT is:')
 pT
 disp('Tj is:')
 Tj
 disp('index is:')
 pT-Tj+t
 disp('tt1p is:')
 tt1p(pT-Tj+t)
 
  disp('t is')
 t
 disp('pT is:')
 pT
 disp('Tj is:')
 Tj
 disp('index is:')
 pT-Tj+t
 disp('tt1p is:')
 tt1p(pT-Tj+t)
 disp('f is:');
 f
 
      disp('d is:');
     d
     disp('mt is:');
     mt
     disp('j is:')
     j
     disp('size of a is:')
     a
 
      disp('size of frecast is:')
     size(forecast)
     disp('size of Y1(t,j) is:')
     size(Y1(t,1))
	 
	% Y1 = [];  MAD=[]; MSE=[];   % mt, Ct mean and variance of prior at t-1
	
	     %pause;
    %a      =   g*mt  + uT(:,t);                      % mean of prior at t-1
	
	 %forecast = F*a;  Y1(:,t)  = forecast;            % mean of 1-step ahead prediction
	 
	  F      =   Jap(a, t) ;            %b1,b2,a             % Ja Jacobian, EKF
	  forecast = hap(a, t) ;     % ha - function b1,b2,
	  
	 global unblncPnl n;
	 
	 global unblncPnl tt2 n;
	 
	 qinv   =   myinv(q);
	 e      =   platformError(y(t,:),forecast,t,unblncPnl,tt2,n); 
	 %/q
	 
	 hold on
	plot (yp);
	
	y = zeros(p,T); x = rand(T,1);y=[];
	
	qinv = solutions{1};

 
	%GT = repmat(GT,[1 1 n]);
	
	r*F'*(q\speye(size(q)));
	
	r*F'*pinv(q);
	
	 %pause;
    %a      =   g*mt  + uT(:,t);                      % mean of prior at t-1
	
	   %forecast = F*a;  Y1(:,t)  = forecast;            % mean of 1-step ahead prediction

	   % handling t=0 is not needed since I never call t=0; => it is needed since theoretically we need m_t-1
	   
	 
	 % Hap OLD
	function [h] = hap(tt1, t, unblncPnl, tt2, GTtemp, piaitemp, tt0temp, n) %a,b,
		% we needed t in order to corporate relevant add-ons only


		if size(find(unblncPnl>t,1),1)>0
			til = find(unblncPnl>t,1)-1;
		else
			til = n;
		end
		h  = zeros(til+1,1); %first one for platform and the rest are add-ons
		% make sure the first one is the platform
		h(1) = tt1; % for the real data of ffx add-on observation equation 
		% we need for moment zero because our data is from moment 1 (which is from state eq. of add-ons)
		parfor i=1:til;
			 temptt = tt2{unblncPnl(i,2)};
			if ((t-unblncPnl(i,1))==0) % for the case of zero it is different (we have to use previous element)
			   tt0tmp = tt0temp{unblncPnl(i,2)};
			   h(i+1) = [tt0tmp.^2/tt1 tt0tmp]*diag(GTtemp(:,:,unblncPnl(i,2)))+(piaitemp{unblncPnl(i,2)})*tt1;
			else
				h(i+1) = [temptt(t-unblncPnl(i,1)).^2./tt1 temptt(t-unblncPnl(i,1))]...
					*diag(GTtemp(:,:,unblncPnl(i,2)))+(piaitemp{unblncPnl(i,2)}).*tt1; 
			end;
		end;
		% above we also acounted for current moment of M_t in estimating n_it
		
		
		%JAP OLD
		function [Ja] = Jap(tt1, t, unblncPnl, tt2, GTtemp, piaitemp, tt0temp, n) %alpha,

		% we needed t in order to corporate relevant add-ons only
		% make sure the first one is the platform
		if size(find(unblncPnl>t,1),1)>0
			til = find(unblncPnl>t,1)-1;
		else
			til = n;
		end
		Ja  = zeros(til+1,1); %first one for platform and the rest are add-ons
		Ja(1) = 1; % for the real data of ffx add-on observation equation 
		% we need for moment zero because our data is from moment 1 (which is from state eq. of add-ons)      
		% since I am conditioning for n_it-1 then I should use the real data
		parfor i=1:til;
			 temptt = tt2{unblncPnl(i,2)};
			 d = diag(GTtemp(:,:,unblncPnl(i,2)));
			if ((t-unblncPnl(i,1))==0) % for the case of zero it is different (we have to use previous element)
			   tt0tmp = tt0temp{unblncPnl(i,2)};
			   Ja(i+1) =d(1)/(tt1.^2)*tt0tmp.^2 + piaitemp{unblncPnl(i,2)};
			else
			   Ja(i+1) =d(1)/(tt1.^2)*temptt(t-unblncPnl(i,1)).^2 +piaitemp{unblncPnl(i,2)};
			end;
		end;



 %[a(1)*tt1(1) - a(2)*tt1(2) - a(3)*tt1(1)^2 +  a(4)*tt1(2)^2 + a(5)*tt1(1)*tt1(2); ...
  %      b(1)*tt1(2) - b(2)*tt1(1) - b(3)*tt1(2)^2 +  b(4)*tt1(1)^2 + b(5)*tt1(1)*tt1(2)];
         

		% old platformError
		function [e] =  platformError(q,y,forecast,t,unblncPnl,tt2,n,r,F) %a,b,
		% we needed t in order to corporate relevant add-ons only
		% y here to calculate the error is only tt2 but with lead (rather than lag)

		if size(find(unblncPnl>t,1),1)>0
			til = find(unblncPnl>t,1)-1;
		else
			til = n;
		end
		e  = zeros(til+1,1); %first one for platform and the rest are add-ons

		e(1) = y - forecast(1);
		parfor i=1:til;
			temptt = tt2{unblncPnl(i,2)};
			e(i+1) = temptt(t-unblncPnl(i,1)+1) - forecast(i+1); %because it is about state equation
		end;
		
		% old relvar
		function [relvntvar] = relvar(v,t, unblncPnl, n) %alpha,
			% relvar is the relevant variance of the full platform diffusion system
				if size(find(unblncPnl>t,1),1)>0
				  til = find(unblncPnl>t,1)-1;
				else
					til = n;
				end
				relevent=til;
				temp = unblncPnl(1:relevent,2);
				relvntvar = v([1 temp'+1],[1 temp'+1]); % the first one for platform obs eq. the rest for add-on state eq.
			end
  

  % componenets of BEKFP that changed for the error of MATLAB
   F = Jap(a, t, unblncPnl, tt2, GTtemp, piaitemp, tt0temp, n, T);
       forecast = hap(a, t, unblncPnl, tt2, GTtemp, piaitemp, tt0temp, n, T);
       % hap  and Jap run in parallel : 
  funcs={@Jap,@hap};
       arguments={a, t, unblncPnl, tt2, GTtemp, piaitemp, tt0temp, n, T;...
              a, t, unblncPnl, tt2, GTtemp, piaitemp, tt0temp, n, T};
       solutions=cell(1,2);
       parfor i = 1:2
         solutions{i}=funcs{i}(arguments{i,:});
       end
       
       F = solutions{1};
       forecast = solutions{2};
	   
	    funcs={@myinv,@platformError};
     arguments={q,y(t,:),forecast,t,unblncPnl,tt2,n,r,F,T;...
           q,y(t,:),forecast,t,unblncPnl,tt2,n,r,F,T};
     solutions=cell(1,2);
     parfor i = 1:2
        solutions{i}=funcs{i}(arguments{i,:});
     end

     e = solutions{2};
     A      =   solutions{1};   
	 
	 % changed Jap
	 function [Ja] = Jap(tt1, t, unblncPnl, tt2, GTtemp, piaitemp, tt0temp, n, T) %alpha,

		if (t == T)
		   Ja = 1; % for this case there is no state equation for add-ons to use 
		else
		   % we needed t in order to corporate relevant add-ons only
			% make sure the first one is the platform
			if size(find(unblncPnl>(t+1),1),1)>0
				til = find(unblncPnl>(t+1),1)-1;
			else
				til = n;
			end
				Ja  = zeros(til+1,1); %first one for platform and the rest are add-ons
				Ja(1) = 1; % for the real data of ffx add-on observation equation 
				% we need for moment zero because our data is from moment 1 (which is from state eq. of add-ons)      
				% since I am conditioning for n_it-1 then I should use the real data
				parfor i=1:til;
					 temptt = tt2{unblncPnl(i,2)};
					 d = diag(GTtemp(:,:,unblncPnl(i,2)));
					 if ((t-unblncPnl(i,1))==-1) % for the case of zero it is different (we have to use previous element)
					   tt0tmp = tt0temp{unblncPnl(i,2)};
					   Ja(i+1) =d(1)/(tt1.^2)*tt0tmp.^2 + piaitemp{unblncPnl(i,2)};
					 else
						 Ja(i+1) =d(1)/(tt1.^2)*temptt(t-unblncPnl(i,1)+1).^2 +piaitemp{unblncPnl(i,2)};
					 end;
				end;
		end;


% Modified hap
		function [h] = hap(tt1, t, unblncPnl, tt2, GTtemp, piaitemp, tt0temp, n,T) %a,b,
		% we needed t in order to corporate relevant add-ons only

		if (t == T)
		   h = tt1; % for this case there is no state equation for add-ons to use 
		else
			if size(find(unblncPnl>(t+1),1),1)>0
				til = find(unblncPnl>(t+1),1)-1;
			else
				til = n;
			end
			h  = zeros(til+1,1); %first one for platform and the rest are add-ons
			% make sure the first one is the platform
			h(1) = tt1; % for the real data of ffx add-on observation equation 
			% we need for moment zero because our data is from moment 1 (which is from state eq. of add-ons)
			parfor i=1:til;
				 temptt = tt2{unblncPnl(i,2)};
				 
				 
				 
				 if ((t-unblncPnl(i,1))==-1) % for the case of zero it is different (we have to use previous element)
					tt0tmp = tt0temp{unblncPnl(i,2)};
					h(i+1) = [tt0tmp.^2/tt1 tt0tmp]*diag(GTtemp(:,:,unblncPnl(i,2)))+(piaitemp{unblncPnl(i,2)}).*tt1;
				 else
					   h(i+1) = [temptt(t-unblncPnl(i,1)+1).^2./tt1 temptt(t-unblncPnl(i,1)+1)]...
							*diag(GTtemp(:,:,unblncPnl(i,2)))+(piaitemp{unblncPnl(i,2)}).*tt1; 
				 end;
			end;
		end;

		
		% part of code not needed anymore
		        if size(find(unblncPnl>(t+1),1),1)>0
            til = find(unblncPnl>(t+1),1)-1;
        else
            til = n;
        end
		
		%      size(tt2((unblncPnl(1:til,2)-1)*T+t).^2./tt1)
%      
%      size(reshape(GTtemp(1,1,unblncPnl(1:til,2)),[til 1]))
%      
%      tt2((unblncPnl(1:til,2)-1)*T+t).^2./tt1.*reshape(GTtemp(1,1,unblncPnl(1:til,2)),[til 1])

    if size(find(unblncPnl>(t+1),1),1)>0
        til = find(unblncPnl>(t+1),1)-1;
    else
        til = n;
    end
	
	        
%         size(reshape(GTtemp(1,1,unblncPnl(1:til,2)),[til 1]))
%         
%         size((tt1.^2).*tt2((unblncPnl(1:til,2)-1)*T+t).^2)
%         (reshape(GTtemp(1,1,unblncPnl(1:til,2)),[til 1])./(tt1.^2).*tt2((unblncPnl(1:til,2)-1)*T+t).^2)
%         size( piaitemp(unblncPnl(1:til,2)))

 if size(find(unblncPnl>(t+1),1),1)>0
        til = find(unblncPnl>(t+1),1)-1;
    else
        til = n;
    end
	
	%      disp('start loop')
%      tic;

%      toc;
%        
%      disp('Jacobian')
%      tic;

%       toc;
%       disp('find break')
%          tic;

%      toc;
%      disp('calculating q')
%      tic;


%     toc;
%     disp('error calculation')
%     tic;

    
%     toc;
%     disp('inversion')
%     tic;

%      toc;
%       
%     disp('BEKFP');
%     tic;

%      toc;

%myinv(q,y(t,:),forecast,t,unblncPnl,tt2,n,r,F,T); ;   

  solutions{i}      =    Jap(a, t, unblncPnl, tt2, GTtemp, piaitemp,  T, til);
         F = solutions{1};
		 
		 hap(a, t, unblncPnl, tt2, GTtemp, piaitemp,  T, til)