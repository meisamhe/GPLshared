   % from BLPReg
   
          % [diffdistold  diffdistrib ((floor(diffdistrib*1e4) == floor(diffdistold*1e4))) conv(:)]
       % pause
       
       % [min(abs(de1(:)-de(:))) median(abs(de1(:)-de(:))) mean(abs(de1(:)-de(:))) max(abs(de1(:)-de(:)))]
       % [de1-de log(shares)-log(shares_e)]
       % pause;
        %median(de1(:)-de(:))
%         if (i>40000) % for genetic algorithm
%             penalty = -Inf;
%             break;
%         end;

    %k      =  max(abs(de1(:)-de(:)));
   % [min(abs(de1(:)-de(:))) median(abs(de1(:)-de(:))) mean(abs(de1(:)-de(:))) max(abs(de1(:)-de(:)))]
   % pause
    %k = sort(abs(de1(:)-de(:)));
    %diffdistrib = k; % distribution of the difference
	
	 %|| (all(conv(:))==0);
	 
	    % conv = (floor(diffdistrib*1e3) == floor(diffdistold*1e3));
		
		% k = k(ceil(0.9999*size(k,1)));
		
		%gamma: the discount factor
	%P1: price for first period
	%P2: price for 2nd period
	%lambda: Availability of second period
	%arranging matrixes
	%J: number of products under study = 106 in hour example
	%T: number of periods =2 in hour example
	%heterogeneous beta includes beta_ip, beta_ir, alpha_ip
	
	    diffdistold = diffdistrib;
		
		penalty  =  0;
diffdistrib = dd(:);
conv = diffdistrib;
diffdistold = ones(J*T,1);


% assume independance of error of share
sherror = log(shares)-  log(shares_e);
sherrvar = var(sherror(:));
SherrLKLHD=   - 0.5*T*J*log(2*pi*sherrvar) -   .5*sum(sherror(:).^2/sherrvar);
%sherror =reshape(sherror,J,2);

+ penalty

 Indx
    size(de(Indx,1))
    size(bpd*P1(Indx))