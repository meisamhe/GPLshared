#================================================================
# code for Variational Bayesian Dirichlet process (converted from MATLAB code)
# MATLAB original code by: Kenichi Kurihara's (https://sites.google.com/site/kenichikurihara/academic-software/variational-dirichlet-process-gaussian-mixture-model)
# converted R code by: Meisam Hejazi Nia
#================================================================

library(stats)

gamma_multivariate_ln= function(x,p) {

  # x: array(1,K) must be more than (p)/2
  # p: scalor
  
  # Gamma_p(x) = pi^(p(p-1)/4) prod_(j=1)^p Gamma(x+(1-j)/2)
  # log Gamma_p(x) = p(p-1)/4 log pi + sum_(j=1)^p log Gamma(x+(1-j)/2)
  
  K = length(x);
  gammaln_val = lgamma(t(matrix(t(rep(x,p)),ncol=p))+0.5*(1-matrix(rep(c(1:p),K),ncol=K))); # p by K
  val = p*(p-1)*0.25 * log(pi) + colSums(gammaln_val);
  
  return(val)
}

#============================================================================================

log_no_w = function(x){
  # this function is to give log without warning, in conversion the condition is ignored as R does not send warning
  
  # val = log(x)
  # log_no_w does not warn anything.
  
  # to know the msgid
  # log(0)
  # [msg, id] = lastwarn
  
  #warning('off', 'MATLAB:log:logOfZero');
  val = log(x);
  #warning('on', 'MATLAB:log:logOfZero');
  return(val)
  
}

#=========================================================================================

log_sum_exp = function(x,dim){
  # calculate maximum along a given dimension, demean from that max the rest then
  # y = log( sum( exp(x), dim ) )
  # y = log( sum( exp(x).*y, dim ) )
  # also sum it up with that max, only for the purpose of not encountering infinity in the main, 
  #but it does not have real advantage from programming point of view so in this R code I removed it
  #so I directly add exponent and then take log of sum

  # x can be -inf but cannot be +inf.
  x[is.infinite(x)]=1e300
  x[is.nan] = 1e300
  
  xexp = exp(x)
  
  #sanity check
  xexp[is.nan(xexp)]=1e300
  xexp[is.infinite(xexp)] = 1e300
  
  y=sum(apply(xexp, c(-dim), sum))
  
  return(y)
}

#================================================================================================
detln = function(X){
  # Y = logdet( X )
  # return a log determinant of X
  X[is.nan(X)] = 10
  X[is.infinite(X)] = 10
  
  d = chol(X);
  Y = sum(log(diag(d)))*2
  
  return(Y)
}

#================================================================================================

logmvtpdf = function(t,mu,f,Sigma){
  # log pdf of multivariate t-student dist.
  # t : D by N
  d = nrow(t)
  n = ncol(t)
  
  c = lgamma((d+f)*0.5) - (d*0.5)*log(f*pi) - lgamma(f*0.5) - 0.5*detln(Sigma);
  diff = t - matrix(rep(mu,n),ncol = n) # d by n
  logpdf = c - (f+d)*0.5 * log(1 + apply(diff*(chol2inv(chol(f*Sigma))%*%diff),1,sum));  
  return(logpdf) 
}

#======================================================================================================

mkopts_avdp = function(){
  
  opts = matrix(c("vdp",1,1,1,0,0,1,4,0.1,2,0.1,3),ncol=1)
  opts.names <- c("algorithm", "use_kd_tree","initial_K","do_greedy","do_split","do_merge","do_sort","initial_depth",
                    "max_target_ration", "recursive_expanding_depth","recursive_expanding_threshold","recursive_expanding_frequency")
  names(opts) <- opts.names
  

  return(opts)
}

#======================================================================================================

mkopts_bj = function(T){
  
  opts = matrix(c("bj",0,20,T,0,0,0,0),ncol=1)
  opts.names <- c("algorithm", "use_kd_tree","initial_K","do_greedy","do_split","do_merge","do_sort")
  names(opts) <- opts.names
  
 
  return(opts)
}

#======================================================================================================

mkopts_bjrnd = function(T){
  
  opts = matrix(c("bj",0,0,T,0,0,0,0),ncol=1)
  opts.names <- c("algorithm", "use_kd_tree","initial_K","do_greedy","do_split","do_merge","do_sort")
  names(opts) <- opts.names
  
  return(opts)
}

#====================================================================================================
mkopts_cdp = function(K){
  
  opts = matrix(c("cdp",0,0,K,0,0,0,0),ncol=1)
  opts.names <- c("algorithm", "use_kd_tree","initial_K","do_greedy","do_split","do_merge","do_sort")
  names(opts) <- opts.names
  
  return(opts)
}

#====================================================================================================
mkopts_csb = function(T){
  
  opts = matrix(c("csp",0,0,T,0,0,0,0),ncol=1)
  opts.names <- c("algorithm", "use_kd_tree","initial_K","do_greedy","do_split","do_merge","do_sort")
  names(opts) <- opts.names
  
  return(opts)
}
#====================================================================================================
mkopts_vb = function(K){
  
  opts = matrix(c("non_dp",0,K,0,0,0),ncol=1)
  opts.names <- c("algorithm", "use_kd_tree","initial_K","do_greedy","do_split","do_merge")
  names(opts) <- opts.names
  
  return(opts)
}
#====================================================================================================
mkopts_vdp = function(){
  
  opts = matrix(c("non_dp",0,1,1,0,0),ncol=1)
  opts.names <- c("algorithm", "use_kd_tree","initial_K","do_greedy","do_split","do_merge")
  names(opts) <- opts.names
  
  return(opts)
}
#====================================================================================================

normalize = function(m,dim){
  # return m normalized with 'dimension'
  #
  # e.g.
  # m : i by j by k by ...
  # m = sum(normalize(m,2), 2);
  # m(i, :, k, ...) = ones(1, J, 1, ...)
  
  dims = matrix(rep(1,length(dim(m)),nrow=1));
  dims[dim] = dim(m)[dim];
  m = m * 1/array(rep(apply(m,-dim,sum),prod(dims)),dim=dim(m))
  
  return(m)
}
#====================================================================================================
# A = covariance
power_method = function(A, startPoint=matrix(rep(1,nrow(A)),ncol=1), precisionPM = 1e-10){
  args = list(A=A,startPoint=startPoint,precisionPM=precisionPM);
  nargin = (!is.null(args[['A']]))+(!is.null(args[['startPoint']]))+(!is.null(args[['precisionPM']]))
  
  if (nargin==1){
    startPoint = matrix(rep(1,nrow(A)),ncol=1)
    precisionPM = 1e-10
  }
  if (nargin==2){
    precisionPM = 1e-10
  }

  # xp = A^p * x
  # x(p+1) = lambda * xp   when p is big enough
  # lambda = x(p+1)'*xp / xp'*xp
  diff=precisionPM+1;
  x=startPoint;
  n=sqrt(sum(x^2))+diff;
  i = 0;
  while (diff>precisionPM){
    i = i + 1;
    y=A%*%x;
    n2 = sqrt(sum(x^2));
    diff=abs(n2-n);
    n=n2;
    if (n< 1e-200){
      x = matrix(rep(0,length(A)),ncol=1)
      break
    }else{
      x = y/n
    }
    if (i<100){
      break
    }
  }
  n = sqrt(sum(x^2))
  if(n<1e-200){
    vec = matrix(rep(0,length(A)),ncol=1)
  }else{
    vec = x/n;
  }
  value = n
  return(list(vec=vec,value=value))
}

#====================================================================================================
# modified: corrected except for the kd-tree, as it needs much more thaught
#data=data
#opts =opts
mk_hp_prior = function(data, opts){
  
  hp_prior = list()
  
  if ("xi0" %in% names(opts)){
    hp_prior[['xi0']] = opts[['xi0']];
  }else{
    hp_prior[['xi0']] = 0.01
  }
  if ("eta_p" %in% names(opts)){
    eta_p = opts[['eta_p']];
  }else{
    eta_p= 1
  }
  if ("alpha" %in% names(opts)){
    hp_prior[['alpha']] = opts[['alpha']];
  }else{
    hp_prior[['alpha']] = 1
  }
  D=dim(data[['given_data']])[1]
  N=dim(data[['given_data']])[2]
  
  if (opts[['use_kd_tree']]>0){
    sum_xxlist = list()
    sum_xlist = list()
    for (i in 1:length(data[["kdtree"]])){
      sum_xxlist[length(sum_xxlist)+1]=data[["kdtree"]][[i]][["sum_xx"]]
      sum_xlist[length(sum_xlist)+1]=data[["kdtree"]][i][["sum_x"]]
    }
  
    sum_xx = apply(array(sum_xxlist,dim=c(D,D,length(data[["kdtree"]]))),3,sum);
    sum_x  = apply(matrix(sum_xlist,ncol=D),2,sum)
    covariance = sum_xx/N - crossprod(sum_x)/(N*N);
  }else{
    covariance = cov(t(data[["given_data"]]))
  }
  hp_prior[["m0"]] = apply(data[["given_data"]],1,mean)
  if (D>16)       {
    dummy   = power_method(covariance)$vec
    max_eig = power_method(covariance)$value
  }else{
    max_eig = max(eigen(covariance)$values)
  }
  hp_prior[["eta0"]]=eta_p*D +1
  hp_prior[["B0"]] = hp_prior[["eta0"]] *max_eig * diag(c(rep(1,D))) * hp_prior[["xi0"]]
  
  return(hp_prior)
}

#=========================================================================================

mk_q_of_z = function(data, hp_posterior, hp_prior, opts, log_lambda= mk_log_lambda(data, hp_posterior, hp_prior, opts)){
  # q_of_z: N*K
  
  args = list(data = data, hp_posterior = hp_posterior, hp_prior = hp_prior, opts = opts, log_lambda= log_lambda);
  nargin = (!is.null(args[['data']]))+(!is.null(args[['hp_posterior']]))+(!is.null(args[['hp_prior']]))+
    (!is.null(args[['opts']]))+ (!is.null(args[['log_lambda']]))
  
  if (nargin==4){
    log_lambda = mk_log_lambda(data, hp_posterior, hp_prior, opts);
  }
  q_of_z = exp(normalizeln(log_lambda, 1));
  
  if (opts[["weight"]]!=1){
    q_of_z = q_of_z * matrix(rep(opts[["weight"]],dim(q_of_z)[2]),ncol=dim(q_of_z)[2]*ncol(opts[["weight"]]))
  }else{
    q_of_z = q_of_z
  }
  
  return(list(q_of_z=q_of_z,data=data,log_lambda=log_lambda))
}
#=========================================================================================

normalizeln = function(M ,dimension){
  M = lpt2lcpt(M, dimension);
  return(M)
}
#=========================================================================================
lpt2lcpt = function(lpt,dimension){
  # make a log conditional probability table with log probability table
  # lpt is a matrix.
  # dimension must be either 1 or 2.
  # lcpt = log( exp(lpt) / sum(exp(lpt)) )
  #      = lpt - log(sum(exp(lpt)))
  
  the_other_dimension=-(dimension-1.5)+1.5;
  lpt=aperm(lpt,cbind(dimension,the_other_dimension));
  # now we can calculate as if dimension=1.

  log_sum_exp_lpt = log_sum_exp(lpt,2); # M x 1
  lcpt = lpt - matrix(rep(log_sum_exp_lpt,dim(lpt)[2]),ncol=dim(lpt)[2]);
  
  lcpt=aperm(lcpt,cbind(dimension,the_other_dimension));
  
  return (lcpt)
}

#=========================================================================================
mk_log_lambda = function(data, hp_posterior, hp_prior, opts){
  # one of the core functions
  
  # log_lambda: N*K
  # q(z_n=c|x_n) = lambda_n_c / sum_c lambda_n_c
  
  if (opts[['algorith']]=='vdp'){
    if ((abs(hp_posterior[["gamma"]][2,dim(hp_posterior[["gamma"]])[2]])-hp_prior[["alpha"]])>1e-5){
      cat(hp_posterior[["gamma"]][2,dim(hp_posterior[["gamma"]])[2]])
      cat(hp_prior[["alpha"]])
      diff = hp_piror[["alpha"]]-hp_posterior[["gamma"]][2,dim(hp_posterior[["gamma"]])[2]]
      stop("must be alpha")
    }
  }
  
  if (opts[["use_kd_tree"]]){
    N = length(data[["kdtree"]])
    D = dim(data[["kdtree"]][1][["sum_x"]])[1]
  }else{
    D = dim(data[["give_data"]])[1]
    N = dim(data[["give_data"]])[2] 
  }
  
  K = dim(hp_posterior[["eta"]])[2]
  psi_sum = apply(psigamma( matrix(rep(hp_posterior[["eta"]]+1,D),ncol=1) - matrix(rep(c(1:D),K), ncol=K))*0.5 , 1,sum); # 1 x K

  log_lambda = matrix(rep(0,N*K),ncol=K)
  
  if (opt[["use_kd_tree"]]){
    # create a list of sum_xx
    sum_xxlist = list()
    sum_xlist = list()
    Nlist = list()
    for (i in 1:length(data[["kdtree"]])){
      sum_xxlist[length(sum_xxlist)+1] = data[["kdtree"]][i][["sum_xx"]]
      sum_xlist[length(sum_xlist)+1] = data[["kdtree"]][i][["sum_x"]]
      Nlist[length(Nlist)]=data[["kdtree"]][i][["N"]]
    }
    t1 = array(sum_xxlist,dim=c(D,D,N))
    sum_x = array(rep(array(sum_xlist,dim=c(D,1,N)),D),dim=c(1,D,1))
    Na = array(rep(array(Nlist,dim=c(1,1,N)),D),dim=c(D,D,1))
  }

  if ((opts[["algorithm"]]=='csb') || opts[["algorithm"]]=='cdp'){
    E_log_p_of_z_given_other_z = mk_E_log_p_of_z_given_other_z(hp_posterior, hp_prior, opts);
  }
  
  for (c in 1:K){
    if (opts[["algorith"]]=='vdp'){
      E_log_p_of_z_given_other_z_c =  psigamma(hp_posterior[["gamma"]][1,c])- psigamma(apply(hp_posterior[["gamma"]][,c],1,sum))+
        apply(psigamma(hp_posterior[2,1:(c-1)]),2,sum) - psigamma(apply(hp_posterior[["gamma"]][,1:(c-1)],2,sum))
    }else{
      if (opts[["algorith"]]=='bj'){
        if (c<K){
          psigamma(hp_posterior[["gamma"]][1,c]) -
            psigamma(apply(hp_posterior[[gamma]][,c],1,sum))+
              apply(psigamma(hp_posterior[["gamma"]][2,1:(c-1)])-psigamma(apply(hp_posterior[["gamma"]][2,1:(c-1)],2,sum)),sum,2)
        }else{
          E_log_p_of_z_given_other_z_c = sum(psigamma(hp_posterior[["gamma"]][2,1:(c-1)])) -
                                               psigamma(apply(hp_posterior[["gamma"]][2,1:(c-1)],2,sum))
        }
        
      }else{
        if (opts[["algorith"]]=='non_dp'){
            # E[log pi] ; pi is the weight of mixtures.
            E_log_p_of_z_given_other_z_c = psigamma(hp_posterior[["tilde_alpha"]][c]) -
             psigamma(sum(hp_posterior[["tilde_alpha"]]));
          }else{
            if ((opts[["algorith"]]=='csb') || (opts[["algorith"]]=='cdp')) {
              E_log_p_of_z_given_other_z_c = t(E_log_p_of_z_given_other_z[,c]);
            }else{
                 stop("unknown algorithm")
            }
          }
      }
    }
    E_log_p_of_x = - 0.5*D*log(pi) - 0.5*detln(hp_posterior[["B"]][c]) + 0.5*psi_sum[c] - 0.5*D/(hp_posterior["xi"][c]);

    if (opts[["use_kd_tree"]]){
      t2 = sum_x*array(rep(hp_posterior[["m"]][,c],D*N),dim=c(D,length(hp_posterior[["m"]][,c]),N))
      term_dependent_on_n = (t1 - t2 - aperm(t2,c(2,1,3)))/Na + array(rep(crossproduct(t(hp_posterior["m"][,c])),N),dim=c(1,1,N))
      E_log_p_of_x = - apply(apply(array(rep(Precision,N),dim=c(1,1,N))*term_dependent_on_n,2,sum),1,sum) + E_log_p_of_x;
    }else{
      d = data[["given_data"]] - matrix(rep(hp_posterior[["m"]][,c],N),ncol=N);
      E_log_p_of_x = - sum(d*(Precision*d)) + E_log_p_of_x; # 1*N
    }
    log_lambda[,c] = E_log_p_of_x + E_log_p_of_z_given_other_z_c;
  }
  if (opts[["algorithm"]]=='vpd'){
    log_lambda[,dim(log(log_lambda))] = log_lambda[,dim(log(log_lambda))] - log(1- exp(psaigamma(hp_prior[["alpha"]]) - 
                                                                                         psigamma(1+hp_prior[["alpha"]])));
  }
  return(log_lambda)
}                       
#=========================================================================================

mk_free_energy <- function (data, hp_posterior,hp_prior, opts, 
                            fc= mk_E_log_q_p_eta(data, hp_posterior, hp_prior, opts), log_lambda){
  args = list(data = data, hp_posterior = hp_posterior, hp_prior = hp_prior, opts = opts, fc=fc, log_lambda= log_lambda);
  nargin = (!is.null(args[['data']]))+(!is.null(args[['hp_posterior']]))+(!is.null(args[['hp_prior']]))+
    (!is.null(args[['opts']]))+ (!is.null(args[['log_lambda']])) + (!is.null(args[['fc']]))
  if (nargin == 4){
    fc = mk_E_log_q_p_eta(data, hp_posterior, hp_prior, opts); # 1*K
    log_lambda = mk_log_lambda(data, hp_posterior, hp_prior, opts); # N*K
  }
  
  N = dim(log_lambda)[1]
  K = dim(log_lambda)[2]
  
  if ((opts[['algorithm']]=='vdp') || (opts[['algorithm']]=='bj')){
    #note when bj,  if full hp_posterior is given, len_gamma = K - 1.
    leng_gamma = dim(hp_posterior[['gamma']])[2]
    if ((opts[['algorithm']]=='bj') && len_gamma!=K-1){
      stop('invalid length')
    }
    E_log_p_of_V =lngamma(apply(hp_posterior[["gamma"]], 1,sum))- lngamma(1+hp_prior[["alpha"]]) -
      apply(lngamma(hp_posterior[["gamma"]]), 1,sum) + lngamma(hp_prior[["alpha"]]) +
     ((hp_posterior[["gamma"]][1,]-1)*(psigamma(hp_posterior[["gamma"]][1,])-psigamma(apply(hp_posterior[["gamma"]],1,sum)))) +
     ((hp_posterior[["gamma"]][2,])-hp_prior[["alpha"]])*(psigamma(hp_posterior[["gamma"]][2,])-psigamma(apply(hp_posterior[["gamma"]],1,sum)));

    extra_term = sum(E_log_p_of_V);
  }else{
    if (opts["algorithm"]=='non_dp'){
      E_log_p_of_pi = sum(lngamma(hp_prior[["alpha"]]/K) - lngamma(hp_posterior[["tilde_alpha"]])+ 
                            hp_posterior[["Nc"]]*(psigamma(hp_posterior[["tilde_alpha"]]) -
                              psigamma(sum(hp_posterior[["tilde_alpha"]])))) +
              lngamma(sum(hp_prior[["alpha"]]+dim(data)[2])) - lngamma(hp_prior[["alpha"]]);
      extra_term = E_log_p_of_pi;
    }else{
      if ((opts["algorithm"]=='cdp')|| (opts["algorithm"]=='csb')){
        E_log_p_of_z_given_other_z =  mk_E_log_p_of_z_given_other_z(hp_posterior, hp_prior, opts); # N x K
        q_of_z = mk_q_of_z(data,hp_posterior,hp_prior,opts,log_lambda)$q_of_z;
        #   q_of_z = hp_posterior.q_of_z;
        E_Nc = hp_posterior[["Nc"]];
        V_Nc = apply(q_of_z*(1-q_of_z), 1,sum); # 1 by K
        
        if (opts["algorithm"]=='cdp'){
          E_log_p_of_z = lngamma(hp_prior[["alpha"]]) - lngamma(N+hp_prior[["alpha"]]) +
           sum(lngamma(hp_prior[["alpha"]]/K + E_Nc)- 0.5*psigamma(1, hp_prior[["alpha"]]/K + E_Nc)*V_Nc - lngamma(hp_prior[["alpha"]]/K));
        }else{ #csb
          E_Nc_geq_to_i = apply(E_Nc, 2,cumsum);
          q_of_z_geq_to_i = apply(q_of_z, 2,cumsum);
          V_Nc_geq_to_i = apply(q_of_z_geq_to_i*(1-q_of_z_geq_to_i), 1,sum);
          
          E_Nc_greater_than_i = apply(E_Nc, 2,cumsum) - E_Nc;
          q_of_z_greater_than_i = q_of_z_geq_to_i - q_of_z;
          V_Nc_greater_than_i = apply(q_of_z_greater_than_i*(1-q_of_z_greater_than_i), 1, sum);
          
          tmp = lngamma(1 + E_Nc) - 0.5*psigamma(1, 1 + E_Nc)*V_Nc+ #E[log p(1+Nc)]
           (lngamma(1 + E_Nc_greater_than_i) -           # E[log p(1+N_{>c})]
              0.5*psigamma(1, 1 + E_Nc_greater_than_i)*V_Nc_greater_than_i) -
           (lngamma(1 + hp_prior[["alpha"]] + E_Nc_geq_to_i) - # E[log p(1+alpha+N_{>=c})]
              0.5*psigamma(1, 1 + hp_prior[["alpha"]] + E_Nc_geq_to_i)*V_Nc_geq_to_i);
          E_log_p_of_z = sum(tmp(1:(length(temp-1))));
        }
        extra_term = apply(apply(E_log_p_of_z_given_other_z*q_of_z, 2,sum), 1,sum) - E_log_p_of_z; 
      }else{
        stop('unknown algorithm')
      }
    }
  } 
 if (opts[["use_kd_tree"]]){
   kdtreelist_N = list()
   for (i in 1:length(data[["kdtree"]])){
     kdtreelist_N[length(kdtreelist_N)+1] = data[["kdtree"]][i][["N"]]
   }
   
   free_energy = extra_term + sum(fc) - crossprod(kdtreelist_N,log_sum_exp[log_lambda, 2]);
 }else{
   free_energy = extra_term + sum(fc) - apply(log_sum_exp[log_lambda, 2], 1,sum);
 }


  return(list(free_energy=free_energy,log_lambda=log_lambda))
}

#=========================================================================================
mk_E_log_q_p_eta = function (data, hp_posterior, hp_prior, opts){
  # returns E[ log q(eta)/p(eta) ]_q
  # fc : 1 by K
  D = dim(hp_posterior[["m"]])[1];
  K = dim(hp_posterior[["eta"]])[2];
  log_det_B = matrix(rep(0,K),ncol=K);
  for (c in 1:K){
    log_det_B[c] = detln(hp_posterior[["B"]][c]);
    d = hp_posterior[["m"]][,c]-hp_prior[["m0"]]; # D*1
    
    term_eta[1,c] = apply(apply(hp_posterior[["inv_B"]][,,c]*(hp_prior[["xi0"]]*crossprod(t(d),d)),1,sum),2,sum);
    term_eta[2,c] = apply(apply(hp_posterior[["inv_B"]][,,c]*hp_prior[["B0"]],1,sum),2,sum) - D;    
  }
  E_log_q_p_mean =  0.5*D*(hp_prior[["xi0"]]/hp_posterior[["xi"]] - log(hp_prior[["xi0"]]/hp_posterior[["xi"]]) - 1) +
   0.5*(hp_posterior[["eta"]])* term_eta[[1,]];   
  
  psi_sum = sum(psaigamma((matrix(rep(hp_posterior[["eta"]]+1,D),nrow=D) - matrix(rep(c(1:D),K),ncol=D))*0.5 ), 1); # 1*K
  E_log_q_p_cov = 0.5*hp_prior[["eta0"]]*(log_det_B-detln(hp_prior[["B0"]])) + 0.5*hp_posterior[["Nc"]]*psi_sum +
    + 0.5*(hp_posterior[["eta"]])* term_eta[2,] + gamma_multivariate_ln(hp_prior[["eta0"]]*0.5,D) - gamma_multivariate_ln(hp_posterior[["eta"]]*0.5,D);

  #debug
  if (sum(E_log_q_p_mean<-1.0e-8) > 0){
    cat(E_log_q_p_mean)
    stop('E_log_q_p_mean is negative.')
  }

  if (sum(E_log_q_p_cov<-1.0e-8) > 0){
    cat(E_log_q_p_cov)
    stop('E_log_q_p_cov is negative.')
  }
  fc = E_log_q_p_mean + E_log_q_p_cov;
  
  return(fc)
}

#===================================================================================================
# visisted
# (data, q_of_z, hp_prior, opts)
mk_hp_posterior = function(data, q_of_z, hp_prior, opts){
  # the last component of q_of_z represents the infinite rest of components
  # the last component is the prior.
  # q_of_z: N*K
  # q_of_z(:,end) is the rest of responsibilities.
  hp_posterior = list()
  threshold_for_N = 1.0e-200;
  K = dim(q_of_z)[2];
  if (opts["use_kd_tree"]>0){
    N = length(data[["kdtree"]]);
    D = dim(data[["kdtree"]][1][["sum_x"]])[1];
    
    Nlist = list()
    sum_xlist = list()
    sum_xxlist = list()
    
    for (i in 1:length(data[["kdtree"]])){
      Nlist[length(Nlist)+1] = data[["kdtree"]][i][["N"]]
      sum_xlist[length(sum_xlist)+1] = data[["kdtree"]][i][["N"]]
      sum_xxlist[length(sum_xxlist)+1] = data[["kdtree"]][i][["N"]]
    }
    Na = Nlist;
    
    if (opts[["algorithm"]]== 'vdp'){
      true_Nc = Na%*%q_of_z; # 1*K
      q_of_z[,dim(q_of_z)[2]] = 0;
    }
    Nc = Na%*%q_of_z; # 1*K
    sum_x = sum_xlist%*%q_of_z;    
  } else{
    D = dim(data[["given_data"]])[1]
    N = dim(data[["given_data"]])[2]
    if (opts[["algorithm"]]== 'vdp'){
      true_Nc = apply(q_of_z, 1,sum); # 1*K
      q_of_z[,dim(q_of_z)[2]] = 0;
    }
    Nc = sum(q_of_z, 1); # 1*K
    sum_x = data[["given_data"]] %*% q_of_z;
  }
  I = which((Nc>threshold_for_N)!=0,arr.ind = T)
  inv_Nc = matrix(rep(0,K),ncol=K);
  inv_Nc[I] = 1/Nc[I];
  hp_posterior[["eta"]] = hp_prior[["eta0"]] + Nc;
  hp_posterior[["xi"]] = hp_prior[["xi0"]] + Nc;
  means = sum_x * matrix(rep(inv_Nc,D),nrow= D); # D*K
  hp_posterior[["inv_B"]] = array(rep(0,D*D*K),dim=c(D,D,K));
  
  #goooooooooooooood until here
  if (opts[["use_kd_tree"]]>0){
     Nlist = list()
    sum_xlist = list()
    sum_xxlist = list()
    
    for (i in 1:length(data[["kdtree"]])){
      Nlist[length(Nlist)+1] = data[["kdtree"]][i][["N"]]
      sum_xlist[length(sum_xlist)+1] = data[["kdtree"]][i][["N"]]
      sum_xxlist[length(sum_xxlist)+1] = data[["kdtree"]][i][["N"]]
    }
    
    t1 = array(sum_xxlist, dim=c(D,D,N));
    for (c in 1:K){
      v0 = means[,c] - hp_prior[["m0"]];
      q_of_z_c = array(q_of_z[,c], dim = c(1, 1, N));
      S = apply(array(rep(q_of_z_c,D*D),dim=c(D,D,1))*t1, 3,sum) - Nc[c]*means[,c]*t(means[,c]);
      hp_posterior[["B"]][c] = hp_prior[["B0"]] + S + Nc[c]*hp_prior[["xi0"]]*crossprod(t(v0))/(hp_posterior[["xi"]][c]); # D*D
    }
  }else{
    if (opts[["collapsed_means"]]>0){
      quad_term = mk_quad_term(data, q_of_z, hp_prior, opts);
    }
    for (c in 1:K){
      if (opts[["collapsed_means"]]>0){
        hp_posterior[["B"]][c] = hp_prior[["B0"]]+(t(matrix(rep(q_of_z[,c],D),ncol=D))*data[["iven_data"]])%*%t(data[["given_data"]]) +
          quad_term[,,c];
      }else{
        v = data[["given_data"]] - matrix(rep(means[,c],N),ncol=N); # D*N
        v0 = means[,c] - hp_prior[["m0"]];
        hp_posterior[["B"]][c] = list(hp_prior[["B0"]] + (t(matrix(rep(q_of_z[,c],D),ncol=D))*v)%*%t(v)+
                                                        Nc[c]*hp_prior[["xi0"]]*crossprod(t(v0))/(hp_posterior[["xi"]][c])); # D*D
      }
      
    }   
  }
  #New Goooooooooooooooooooooooooooooooood point
  for (c in 1:K){
    hp_posterior[["inv_B"]][,,c] = make.positive.definite(matrix(hp_posterior[["B"]][[c]],ncol=D));
  }
  hp_posterior[["m"]] = (sum_x + matrix(rep(hp_prior[["xi0"]]*hp_prior[["m0"]],k),ncol=K))/ matrix(rep(Nc+hp_prior[["xi0"]],D),nrow=D);
  
  if (opts[["algorithm"]]== 'vdp'){
    # gamma: 2*K
    hp_posterior[["gamma"]] = matrix(rep(0,2*K),ncol=K);
    hp_posterior[["gamma"]][1,] = 1 + true_Nc;
    hp_posterior[["gamma"]][2,] = hp_prior[["alpha"]] + sum(true_Nc) - apply(true_Nc,2,cumsum);
    
  }else{
      if (opts[["algorithm"]]== 'bj'){
        hp_posterior[["gamma"]] = matrix(rep(0,2*(K-1)),ncol=K-1);
        hp_posterior[["gamma"]][1,] = 1 + Nc[1:(K-1)];
        hp_posterior[["gamma"]][2,] = hp_prior[["alpha"]] + sum(Nc) - apply(true_Nc[1:(K-1)],2,cumsum);  
      }else{
        if ((opts[["algorithm"]]== 'non_dp') || (opts[["algorithm"]]== 'cdp')){
          hp_posterior[["tilde_alpha"]] = hp_prior[["alpha"]]/K + Nc;
      }else{
        if (opts[["algorithm"]]== 'csb'){
          1
        }else{
          stop('unknown algorithm')
        }
      }
    }
  }
  hp_posterior[["Nc"]] = Nc; 
  if (opts[["algorithm"]]== 'vdp'){
    hp_posterior[["true_Nc"]] = true_Nc;
  }
  hp_posterior[["q_of_z"]] = q_of_z; # q_of_z is a N by K matrix where N is
  # #given_data or #nodes in a kd-tree.
   
  return(hp_posterior) 
}
#===================================================================================================
#K= opts[["initial_K"]]
# visited for non-kdtree and corrected
rand_q_of_z = function(data, K, opts){
  # q_of_z: N*K
  K = as.numeric(K)
  if (opts[["use_kd_tree"]]>0){
    N = length(data[["kdtree"]])
  }else{
    N = dim(data[["given_data"]])[2]
  }
  if (opts[["algorithm"]]=='vdp'){
    q_of_z = matrix(rep(0,N*(K+1)),nrow=N);
  }else{
    q_of_z = matrix(rep(0,N*(K)),ncol=K);
  }
  
  q_of_z[,1:K] = matrix(runif(N*K, min=0, max=1),ncol=N)
  
  q_of_z = normalize(q_of_z, 2);
  return(q_of_z)
}

#===================================================================================================
#given_data = given_data
#indices = c(1:N)
#given_data = partition[["given_data"]]
#indices = partition[["indices"]][positive_I]
mk_kdtree_partition = function (given_data, indices){
  partition = list()
  partition[["N"]] = length(indices);
  if (partition[["N"]] == 0){
    stop('indices must have at least one index.')
  }
  
  data_a = given_data[,indices];
  partition[["given_data"]] = given_data;
  partition[["indices"]] = indices;
  if (partition[["N"]]==1){
    partition[["sum_x"]] = data_a
  }else{
    partition[["sum_x"]] = apply(data_a, 1,sum); # D*1
  }
  mean = partition[["sum_x"]] / partition[["N"]]; # D*1
  partition[["mean"]] = mean;
  partition[["sum_xx"]] = crossprod(t(data_a)); # D*D
  partition[["sigma"]] = partition[["sum_xx"]] / partition[["N"]] - crossprod(t(mean));
  partition[["children"]] = list();
  return(partition)
}

#===================================================================================================

#data=partition[["given_data"]][,partition[["indices"]]]
#covariance=partition[["sigma"]]
#mean = partition[["mean"]])
divide_by_principal_component = function(data, covariance, mean){
  # selectes the principle component to break the kd-tree based on
  N = dim(data)[2];
  if (dim(data)[1] <= 16){
    V = eigen(covariance)$values
    D = eigen(covariance)$vectors
    eig_val=max(diag(D))
    principal_component_i = which.max(diag(D))
    principal_component = V[principal_component_i];
    resultPM = power_method(covariance)
    principal_component = resultPM$vec
    eig_val = resultPM$value
  }
  # demean the principle components
  direction = apply((data - matrix(rep(mean,N), ncol= N))*matrix(rep(principal_component, N), ncol=N), 2,sum);
  return(direction)
}
#===================================================================================================
#partition = partition
mk_children_of_partition = function(partition){
  children = list()
  if (partition[["N"]] == 1){
    children = partition;
    return(children)
  }
  dir = divide_by_principal_component(partition[["given_data"]][,partition[["indices"]]], partition[["sigma"]], partition[["mean"]]);
  positive_I = which((dir>=0)!=0,arr.ind = T)  ;
  negative_I = which((dir<0)!=0,arr.ind = T)  ;
  # i.e. if there is no positive and negative then refer back to itself
  if ((length(positive_I)) == 0 || (length(negative_I)) == 0){
    children = partition;
    return(children)
  }
  
  # break from positive and negative igen value point and put positive into one node and negative into another
  children[1] = list(mk_kdtree_partition(partition[["given_data"]], partition[["indices"]][positive_I])); 
  children[2] = list(mk_kdtree_partition(partition[["given_data"]], partition[["indices"]][negative_I]));
  
  return(children)
}
#===================================================================================================

# given_data = given_data
# depth = opts[["initial_depth"]]
init_kdtree_partitions = function(given_data, depth){
  depth = as.numeric(depth)
  D = dim(given_data)[1]
  N = dim(given_data)[2]
  root = mk_kdtree_partition(given_data, c(1:N));
  partitions = expand_recursively(root, depth);
  
  return(partitions)
}

#===================================================================================================
# partition = root
# depth = depth
# partition = children[[1]]
# depth = depth-1
expand_recursively = function(partition, depth){
  children = mk_children_of_partition(partition);
  if ((depth == 1) || length(children) == 1){
    partitions = children;
  }else{
    #cat('current going to run right depth includes:',depth-1,'\n')
    partitions1 = expand_recursively(children[[1]], depth-1);
    #cat('current going to run left depth includes:',depth-1,'\n')
    partitions2 = expand_recursively(children[[2]], depth-1);
    partitions = list(partitions1,partitions2);
  }
  return(partitions)
}

#===================================================================================================
free_energy_improved = function (free_energy, new_free_energy, warn_when_increasing, opts){
  diff = new_free_energy - free_energy;
  if (abs(diff/free_energy) < opts.threshold){
    bool = 0;
  }else{
    if(diff > 0){
      if (warn_when_increasing){
        if (abs(diff/free_energy) > 1.0e-3){
          stop('the free energy increased.  the diff is ',num2str(new_free_energy-free_energy))
        }else{
          warning('the free energy increased.  the diff is ',new_free_energy-free_energy)
        } 
      }
      bool = 0;
    }else{
      if (diff == 0){
        bool = 0
      }else{
        bool = 1;
      }
    }
  }
  return(bool)
}
#===================================================================================================
disp_status = function(free_energy, hp_posterior, opts){
  if (opts[["algorithm"]]== 'vdp'){
    Nc = hp_posterior[["true_Nc"]];
  }else{
    Nc = hp_posterior[["Nc"]];
  }
  cat('F=',free_energy, ';', '    NC=[',NC,'];')
  
}
#===================================================================================================
sort_q_of_z = function (data, q_of_z, opts){
  cat('sorting...')
  if (opts[["use_kd_tree"]]){
    Nlist = list()
    for (i in length(data[["kd_tree"]])){
      Nlist[length(Nlist)+1] = data[["kd_tree"]][i]["N"]
    }
    Nc = Nlist*q_of_z; # 1*K 
  }else{
    Nc = apply(q_of_z, 1,sum); # 1*K
  }
  if (opts[["algorithm"]]== 'vdp'){
    sortOutput = apply(Nc[1:(length(Nc)-1)],2,sort(method = "qu", index.return = TRUE, decreasing=TRUE))
    dummy=sortOutput$x
    I = sortOutput$ix
    I[length(I)+1] = length(Nc)
  }else{
    sortOutput = apply(Nc,2,sort(method = "qu", index.return = TRUE, decreasing=TRUE))
    dummy=sortOutput$x
    I = sortOutput$ix
  }
  
  q_of_z = q_of_z[,I];
  cat('sorting... done.')
  return(list(q_of_z=q_of_z,I=I))
}
#===================================================================================================
update_posterior2 = function(data, hp_posterior, hp_prior, opts, upkdtree = 0, ite = Inf, do_sort = 1){
  # update q_of_z: N*K
  cat('### updating posterior ...')
  free_energy = inf;
  args = list(data = data, hp_posterior = hp_posterior, hp_prior = hp_prior, opts = opts, upkdtree=upkdtree, ite= ite,do_sort=do_sort);
  nargin = (!is.null(args[['data']]))+(!is.null(args[['hp_posterior']]))+(!is.null(args[['hp_prior']]))+
    (!is.null(args[['opts']]))+ (!is.null(args[['ite']])) + (!is.null(args[['upkdtree']]))+(!is.null(args[['do_sort']]))
  
  if (nargin == 4){
    upkdtree = 0;
  }
  
  if (nargin < 6){
    ite = Inf;
  }
  
  if (nargin < 7){
    do_sort = 1;
  }
  i = 0;
  last_Nc = 0;
  start_sort = 0;
  while (1){
    i = i+1;
    output = mk_free_energy(data, hp_posterior, hp_prior, opts)
    new_free_energy = output$free_energy
    log_lambda = output$log_lambda
    disp_status(new_free_energy, hp_posterior, opts);
    
    if (((!is.inf(ite)) && (i>=ite))||(is.inf(ite) && free_energy_improved(free_energy, new_free_energy, 0, opts) == 0)){
      free_energy = new_free_energy;
      if (do_sort && opts.do_sort && ! start_sort){
        start_sort = 1;
      }else{
        break;
      }
    }
    last_Nc = hp_posterior[["Nc"]];
    free_energy = new_free_energy;
    outputmkqz = mk_q_of_z(data, hp_posterior, hp_prior, opts, log_lambda);
    q_of_z = outputmkqz$q_of_z
    data = outputmkqz$data
    freq = opts[["recursive_expanding_frequency"]];
    modeCur = apply(i,freq,function(x) { ux <- unique(x);ux[which.max(tabulate(match(x, ux)))]})
    if (opts[["use_kd_tree"]] && upkdtree && (freq==1 || modeCur)){
      eruc=expand_recursively_until_convergence(data, q_of_z, hp_posterior,  hp_prior, opts);
      data = eruc$data
      q_of_z = eruc$q_of_z
      
    }
    # check if the last component is small enough
    if ((opts[["algorithm"]]== 'vdp') && sum(q_of_z[,length(q_of_z)]) > 1.0e-20){
      q_of_z[,length(q_of_z)+1]= 0;
    }
    if (start_sort){
      q_of_z = sort_q_of_z(data, q_of_z, opts);
    }
    if ((opts[["algorithm"]]== 'vdp') && sum(q_of_z[,length(q_of_z)-1]) < 1.0e-10){
      q_of_z[,length(q_of_z)-1] = list();
    }
    hp_posterior = mk_hp_posterior(data, q_of_z, hp_prior, opts);
      }
    
    # disp_status(free_energy, hp_posterior, opts);
    cat('### updating posterior ... done.')
  
  return(list(free_energy = free_energy, hp_posterior = hp_posterior, data= data, q_of_z= q_of_z))
}
#===================================================================================================
expand_recursively_until_convergence2 = function(data, a,  q_of_z, hp_posterior, hp_prior, opts, depth){
  # q_of_z : N*K
  if (depth == 0){
    return(list(data=data, q_of_z = q_of_z))
  }
  if (!(data[["kdtree"]][a][["children"]])){
    children = mk_children_of_partition(data.kdtree(a));
    data.kdtree(a)[["children"]] = children;
  } else{
    children = data[["kdtree"]][a][["children"]];
  }
  
  if (length(children) == 1){
    return(list(data=data, q_of_z = q_of_z)) 
  }
  
  sub_data[["given_data"]] = data[["given_data"]];
  sub_data[["kdtree"]] = children;
  
  sub_q_of_z = mk_q_of_z(sub_data, hp_posterior, hp_prior, opts); # 2*K
  diff = sub_q_of_z - matrix(rep(q_of_z[a,],2), ncol = 2*ncol(q_of_z[a,]));
  if (apply(apply(diff*diff, 1,sum), 2,sum)/prod(dim(sub_q_of_z)) < opts[["recursive_expanding_threshold"]]){
    return (list(data=data, q_of_z = q_of_z))
  }
  b = length(data["kdtree"])+1;
  data[["kdtree"]][a] = children[1];
  data[["kdtree"]][b] = children[2];
  q_of_z[c(a,b),] = sub_q_of_z;
  outputeruc2=  expand_recursively_until_convergence2(data, a,q_of_z, hp_posterior, 
                                                      hp_prior, opts, depth-1);
  data = outputeruc2$data
  q_of_z = outputeruc2$q_of_z
  
  outputeruc2=  expand_recursively_until_convergence2(data, b, q_of_z, hp_posterior, 
                                                      hp_prior, opts, depth-1);
  data = outputeruc2$data
  q_of_z = outputeruc2$q_of_z
  
  return(list(data=data, q_of_z = q_of_z))
}
#===================================================================================================
expand_recursively_until_convergence = function (data,
                                                 q_of_z, hp_posterior, 
                                                 hp_prior, opts){
  kdtree_size = length(data[["kdtree"]]);
  for (a in 1:length(data[["kdtree"]])){
    outERUC2 = expand_recursively_until_convergence2(data, a, 
                                                     q_of_z, hp_posterior, 
                                                     hp_prior, opts, 
                                                     opts.recursive_expanding_depth);
    data = outERUC2$data
    q_of_z = outERUC2$q_of_z
  }
  
  outputM = apply(q_of_z,2,max)
  prob = outputM[1]
  best_c = outputM[2]
  
  cat('### building kd-tree done; #partition ', kdtree_size,' -> ',length(data["kdtree"]))
  
  return(list(data=data, q_of_z = q_of_z))
}

#===================================================================================================

expand_all_nodes = function (data, 
                             q_of_z, hp_posterior, 
                             hp_prior, 
                             target_partitions, opts){
  
  if (dim(target_partitions)[1] != 1){
    stop('target_partitions must be a row vector.')
  }
  
  new_data = data;
  for (a in target_partitions){
    if (!(data.kdtree(a)[["children"]])){
      children = mk_children_of_partition(data[["children"]][a]);
      data[["kdtree"]][a][["children"]] = children;
    }else{
      children = data[["kdtree"]][a][["children"]]
    }
    
    if (length(children) == 1){
    }
    new_data[["kdtree"]][a] = children[1];
    new_data.kdtree(end+1) = children[2];
    # while a <= length(data.kdtree)
  }
  
  updated_I = cbind(target_partitions,length(data[["kdtree"]])+1:length(new_data[["kdtree"]]));
  sub_data[["given_data"]] = data[["given_data"]];
  sub_data[["kdtree"]] = new_data[["kdtree"]][updated_I];
  sub_q_of_z = mk_q_of_z(sub_data, hp_posterior, hp_prior, opts);
  new_q_of_z = matrix(rep(0,length(new_data[["kdtree"]]),dim(q_of_z)[2]),ncol=dim(q_of_z)[2]);
  new_q_of_z[1:dim(q_of_z)[1],] = q_of_z;
  new_q_of_z[updated_I,] = sub_q_of_z;
  cat('### building kd-tree done; #partition ', num2str(length(data.kdtree)) ,
       ' -> ',num2str(length(new_data.kdtree)))
  
    return(list(new_data = new_data, new_q_of_z = new_q_of_z, updated_I = updated_I))
}

#===================================================================================================
split = function(c, data, q_of_z, 
                 hp_posterior, hp_prior, opts, update_kdtree = 1){
  
  # q_of_z: N*K  									  
  args = list(data = data, hp_posterior = hp_posterior, hp_prior = hp_prior, opts = opts, update_kdtree=update_kdtree, q_of_z= q_of_z,c=c);
  nargin = (!is.null(args[['data']]))+(!is.null(args[['hp_posterior']]))+(!is.null(args[['hp_prior']]))+
    (!is.null(args[['opts']]))+ (!is.null(args[['q_of_z']])) + (!is.null(args[['update_kdtree']]))+(!is.null(args[['c']]))
  if (nargin < 7) {
    update_kdtree = 1;
  }
  new_data = data;
  if ((opts[["use_kd_tree"]]) && (update_kdtree)) {
     dummy = apply(q_of_z,,2,max);
     indices =  apply(q_of_z,,2,which.max);
    target_partitions = t(which((indices==c)!=0,arr.ind = T))
    if (! target_partitions){
      m = data[["kdtree"]][target_partitions][["mean"]];
      log_p_of_m_given_c = mk_map_log_p_of_x_given_c(m, c, hp_posterior, opts); # 1*|target_partitions|  
      sortOutput = apply(log_p_of_m_given_c,2,sort(method = "qu", index.return = TRUE, decreasing=TRUE))
      dummy=sortOutput$x
      I = sortOutput$ix
      
      target_partitions = target_partitions(I[1:ceiling(length(I)*opts[["max_target_ratio"]])]);
      #   target_partitions = t(find(q_of_z[,c)>0.01));
      outputEAN = expand_all_nodes(new_data, q_of_z, hp_posterior, 
                                   hp_prior, target_partitions, opts);
      new_data = outputEAN$new_dat
      q_of_z = outputEAN$q_of_z
      updated_I = outputEAN$updated_I
      info[["updated_I"]] = updated_I;
    }else{
      info[["updated_I"]] = list();
    }
  }
  if (opts[["init_of_split"]]== 'pc'){  # principal eigenvector
    if (opts[["use_kd_tree"]]){
      meanList = list()
      for (i in 1:length(new_data[["kdtree"]])){
        meanList[length(meanList)+1]=new_data[["kdtree"]][i][["mean"]]
      }    
      arg1_data = meanList;
    }else{
      arg1_data = new_data[["given_data"]];
    }
    dir = divide_by_principal_component(arg1_data, 
                                        hp_posterior[["B"]][c]/hp_posterior[["eta"]][c], 
                                        hp_posterior[["m"]][,c]);
    q_of_z_c1 = matrix(rep(0,dim(q_of_z)[1]),ncol=1);
    q_of_z_c2 = q_of_z[,c];
    I = which((dir>=0)!=0,arr.ind = T)
    q_of_z_c1[I] = q_of_z[I,c];
    q_of_z_c2[I] = 0;
  }else{
    q_of_z_c = q_of_z[,c];
    if (opts[["init_of_split"]]=='rnd'){  # random
      r = matrix(runif(dim(q_of_z)[1]),ncol=1);
    }else {if (opts[["init_of_split"]]== 'rnd_close'){  # make close clusters
      r = 0.5 + (matrix(runif(dim(q_of_z)[1]),ncol=1)-0.5)*0.01;
    }else{if (opts[["init_of_split"]]=='close_f'){  # one is almost zero.
      r = 0.98 + matrix(runif(dim(q_of_z)),ncol=1)*0.01;
    }else{
      init_of_split = opts[["init_of_split"]]
      stop('unknown option')
    }}}
    q_of_z_c1 = q_of_z_c*r;
    q_of_z_c2 = q_of_z_c*(1-r);
  }
  new_q_of_z = matrix(rep(0,dim(q_of_z)[1]*(dim(q_of_z)[2]+1)), ncols=dim(q_of_z)[2]+1);
  new_q_of_z[,cbind(1:(dim(new_q_of_z)[2]-2),dim(new_q_of_z)[2])] = q_of_z;
  new_q_of_z[,c] = q_of_z_c1;
  new_c = dim(new_q_of_z)[2] - 1;
  new_q_of_z[,new_c] = q_of_z_c2;
  info[["new_c"]] = new_c;
  
  return(list(new_data=new_data, new_q_of_z=new_q_of_z, info=info))										  
}

#===================================================================================================
mk_map_log_p_of_x_given_c = function(data, clusters, hp_posterior, opts){
  # clusters: e.g [1:K]
  D = dim(data)[1];
  N = dim(data)[2];
  K = length(clusters);
  log_p_of_x_given_c = matrix(rep(0,K*N),ncol=N);
  for (i in 1:K){
    c = clusters[i];
    m = hp_posterior[["m"]][,c];
    precision = hp_posterior[["inv_B"]][,,c]*hp_posterior[["eta"]][c];
    d = data - matrix(rep(m,N), ncol=N*ncol(m));
    log_p_of_x_given_c[i,] = (-D*0.5)*log(2*pi)+0.5*detln(precision)-0.5*sum(d*(precision*d),1);
  }
  return(log_p_of_x_given_c)
}
#===================================================================================================
split_merge=function(data, hp_posterior, hp_prior, opts){
  # split: 
  # tdp: if an empty cluster exists, split is available.
  #      otherwise, make a new empty cluster. =>  K<-K+1.
  # non-dp: if 
  
  c_max = 3;
  outputUP2= update_posterior2(data, hp_posterior, hp_prior, opts, 0, opts[["ite"]]);
  free_energy = outputUP2$free_energy
  hp_posterior = outputUP2$hp_posterior 
  while (1){
    K = dim(hp_posterior[["m"]])[2];
    new_free_energy = Inf;
    ### split
    if (! opts[["do_split"]]){
      break
    }
    
    cat('### start splitting')
    outputSO=sortOutput = apply(hp_posterior[["Nc"]],sort(method = "qu", index.return = TRUE, decreasing=TRUE))
    dummy=sortOutput$x;     candidates_for_splliting = sortOutput$ix
    indx = which((hp_posterior[["Nc"]][candidates_for_splliting]<1)!=0,arr.ind = T)
    candidates_for_splliting[indx] = list();
    q_of_z = mk_q_of_z(data, hp_posterior, hp_prior, opts); # N*K
    for (c in candidates_for_splliting[1:min(c_max, length(candidates_for_splliting))]){
      cat('### start splitting k=',c, '...')
      outputSplit= split(c, data, q_of_z, hp_posterior, hp_prior, opts);
      new_data = outputSplit$new_data
      new_q_of_z = outputSplit$new_q_of_z
      new_hp_posterior = mk_hp_posterior(new_data, new_q_of_z, hp_prior, opts);
      outputUP2= update_posterior2(new_data, new_hp_posterior,hp_prior, opts, 1);
      new_free_energy=outputUP2$free_energy
      new_hp_posterior = utputUP2$hp_posterior 
      new_data=outputUP2$data
      if (free_energy_improved(free_energy, new_free_energy, 0, opts)){
        cat('### splitting k=',c,' improved the free energy.  ',' -> ',new_free_energy)
        break
      }else{
        cat('### splitting k=',c,' did not improve the free energy.')
      }
    }
    cat('### end splitting')
    if (free_energy_improved(free_energy, new_free_energy, 0, opts)){
      free_energy = new_free_energy;
      hp_posterior = new_hp_posterior;
      data = new_data;
    }
    
    if (!opts[["do_merge"]]){
      break
    }
    
    ### merge
    cat('### start merging')
    q_of_z = mk_q_of_z(data, hp_posterior, hp_prior, opts); # N*K
    candidates_for_merging = mkcandidates_to_merge(t(q_of_z)); # 2*#pairs
    for (i in 1:pmin(c_max, dim(candidates_for_merging)[2])){
      pair = candidates_for_merging[,i];
      c1 = pair[1]; c2 = pair[2];
      cat('### start merging c1=', c1,', c2= ', c2,'...')
      new_q_of_z = q_of_z;
      new_q_of_z[,c1] = new_q_of_z[,c1] + new_q_of_z[,c2];
      new_q_of_z[,c2] = matrix(rep(0,dim(new_q_of_z)[1]),ncol=1);
      new_hp_posterior = mk_hp_posterior(data, new_q_of_z, hp_prior, opts);
      outputUP2= update_posterior2(data, new_hp_posterior,hp_prior, opts);
      new_free_energy=outputUP2$free_energy
      new_hp_posterior = outputUP2$hp_posterior
      if (free_energy_improved(free_energy, new_free_energy, 0, opts)){
        cat('### merging c1=#d, c2=#d improved the free energy.  #0.5g -> #0.5g',
            c1, c2, free_energy, new_free_energy)
        break
      }else{
        cat('### merging c1=#d, c2=#d did not improve the free energy.', c1, c2)
      }
    }
    
    cat('### end merging')
    if (free_energy_improved(free_energy, new_free_energy, 0, opts)){
      free_energy = new_free_energy;
      hp_posterior = new_hp_posterior;
    }

  break
  }# while 1

  disp_status(free_energy, hp_posterior, opts);
  
  
  return(list(free_energy=free_energy, hp_posterior=hp_posterior, data=data))
}
#===================================================================================================
find_best_splitting = function(data, hp_posterior,  hp_prior, opts){
  c_max = 10;
  K = dim(hp_posterior[["m"]])[2];
  candidates = which((hp_posterior[["Nc"]]>2)!=0,arr.ind = T);
  if (!candidates){
    free_energy = 0;
    c = -1;
    return(list(free_energy=free_energy, hp_posterior=hp_posterior, data=data, c=c))
  }
  q_of_z = mk_q_of_z(data, hp_posterior, hp_prior, opts);
  new_free_energy = ones(rep(1,max(candidates)),ncol=max(candidates))*Inf;
  #####################
  fc = mk_E_log_q_p_eta(data, hp_posterior, hp_prior, opts);
  log_lambda = mk_log_lambda(data, hp_posterior, hp_prior, opts);
  #####################
  for (c in  candidates[1:min(c_max, length(candidates))]){
    cat('splitting ',c,'...')
    outputSplit= split(c, data, q_of_z, hp_posterior, hp_prior, opts, 1);
    new_data[c] = outputSplit$new_data
    new_q_of_z = outputSplit$new_q_of_z
    info = outputSplit$info
    ######################################
    new_c = info[["new_c"]];
    relating_n = which((apply(new_q_of_z[,c(c,new_c)],2,sum) > 0.5)!=0,arr.ind = T)
    if (!relating_n){}
    new_K = dim(new_q_of_z)[2];
    sub_q_of_z = new_q_of_z[relating_n, c(c,new_c,new_K)];
    if (opts[["use_kd_tree"]]){
      sub_data[["kdtree"]] = new_data[c][["kdtree"]][relating_n];
    }else{
      sub_data[["given_data"]] = new_data[c][["given_data"]][,relating_n]; 
    }
    sub_hp_posteior = mk_hp_posterior(sub_data, sub_q_of_z, hp_prior, opts);
    outputUP2 = update_posterior2(sub_data, sub_hp_posteior, hp_prior, opts, 0, 10, 0);
    sub_f = outputUP2$free_energy
    sub_hp_posteior = outputUP2$hp_posterior
    dummy = outputUP2$data
    sub_q_of_z = outputUP2$sub_q_of_z
    
    if (dim(sub_q_of_z)[2] < 3){}
    input = which((apply(sub_q_of_z,1,sum)<1.0e-10)!=0,arr.ind = T)
    if (length(input) > 1){}
    new_log_lambda = log_lambda;
    if (opts[["use_kd_tree"]]){
      updated_data[["kdtree"]] = new_data[c][["kdtree"]][info[["updated_I"]]];
      new_log_lambda[info[["updated_I"]],] = mk_log_lambda(updated_data, hp_posterior, hp_prior, opts);
    }
    
    sub_log_lambda = mk_log_lambda(new_data[c], sub_hp_posteior, hp_prior, opts);
    insert_indices = cbind(c,new_c,new_K:(new_K+dim(sub_q_of_z)[2]-3));
    new_log_lambda[,insert_indices] = sub_log_lambda;
    new_fc = fc;
    new_fc[insert_indices] = mk_E_log_q_p_eta(sub_data, sub_hp_posteior, hp_prior, opts);
    new_free_energy[c] = mk_free_energy(new_data[c], sub_hp_posteior, hp_prior, opts, new_fc, new_log_lambda);
    new_q_of_z[relating_n,] = 0;
    new_q_of_z[relating_n,insert_indices] = sub_q_of_z;
    new_q_of_z_cell[c] = new_q_of_z;
  }
  
  free_energy = min(new_free_energy);
  c = which.min(new_free_energy)
  if (is.inf(free_energy)){
    c = -1;
    return(list(free_energy=free_energy, hp_posterior=hp_posterior, data=data, c=c))
  }
  
  data = new_data[c];
  hp_posterior = mk_hp_posterior(data, new_q_of_z_cell[c], hp_prior, opts);
  
  return(list(free_energy=free_energy, hp_posterior=hp_posterior, data=data, c=c))
}
#===================================================================================================
greedy = function(data, hp_posterior, hp_prior, opts){
  
  free_energy = mk_free_energy(data, hp_posterior, hp_prior, opts);
  disp_status(free_energy, hp_posterior, opts);
  while (1){
    cat('finding the best one....')
    outputFBS= find_best_splitting(data,  hp_posterior, hp_prior, opts);
    new_free_energy=outputFBS$free_energy
    new_hp_posterior=outputFBS$hp_posterior
    new_data=outputFBS$data
    c=outputFBS$c
    
    if (c == -1){
      break
    }
    
    cat('finding the best one.... done.  component ',c,' was split.')
    disp_status(new_free_energy, new_hp_posterior, opts);
    outputUP2= update_posterior2(new_data, new_hp_posterior,hp_prior, opts, 1, opts[["ite"]]);
    
    new_free_energy = outputUP2$free_energy 
    new_hp_posterior = outputUP2$hp_posterior
    new_data= outputUP2$data
    
    if (free_energy_improved(free_energy, new_free_energy, 0, opts) == 0){break}
    
    free_energy = new_free_energy;
    hp_posterior = new_hp_posterior;
    data = new_data;
  }
  
  disp_status(free_energy, hp_posterior, opts);
  
  
  return(list(free_energy=free_energy, hp_posterior=hp_posterior, data=data))
}
#===================================================================================================
mk_non_kdtree_q_of_z = function(data, q_of_z){
  nonkdtree_q_of_z = matrix(rep(0,dim(q_of_z)[2]*dim(data[["given_data"]])[2]), dim(q_of_z)[2]); # N*K
  for (a in 1:length(data[["kdtree"]])){
    nonkdtree_q_of_z[data[["kdtree"]](a)[["indices"]],] = 
      matrix(rep(q_of_z[a,],length(data[["kdtree"]][a][["indices"]])), ncol=dim(q_of_z[a,])[2]); 
  }
  return(nonkdtree_q_of_z)
}
#===================================================================================================
sequential_importance_sampling= function(data, hp_prior, opts){
  hist_hp_posterior = list()
  hist_free_energy = list()
  cat('start SIS.')
  N = dim(data[["given_data"]])[2];
  for (r in 1:opts[["sis"]]){
    hist[r] = list()
    I = randperm(N);
    #   I = I(1:ceil(N*0.1));
    data_r[["given_data"]] = data[["given_data"]][,I];
    ###################################
    #   data_r_sub[["given_data"]] = data_r[["given_data"]][,1);
    #   q_of_z = ones(1,opts[["initial_K"]]) / opts[["initial_K"]];
    #   hp_posterior = mk_hp_posterior(data_r_sub, q_of_z, hp_prior, opts);
    #   for n = 1:N
    #     data_r_sub[["given_data"]] = data_r[["given_data"]][,1:n);
    #     q_of_z = mk_q_of_z(data_r_sub, hp_posterior, hp_prior, opts);
    #     q_of_z = sort_q_of_z(data, q_of_z, opts);  
    #     hp_posterior = mk_hp_posterior(data_r_sub, q_of_z, hp_prior, opts);
    #   end
    ###################################
    q_of_z = list();
    for (n in 1:dim(data_r[["given_data"]])[2]){
      data_r_sub[["given_data"]] = data_r[["given_data"]][,1:n];
      q_of_z[n,] = matrix(rep(1,opts[["initial_K"]]),ncol= opts[["initial_K"]]) / opts[["initial_K"]];
      hp_posterior = mk_hp_posterior(data_r_sub, q_of_z, hp_prior, opts);
      q_of_z = mk_q_of_z(data_r_sub, hp_posterior, hp_prior, opts);
      #     q_of_z = sort_q_of_z(data, q_of_z, opts);  
    }
    ###################################
    hist_hp_posterior[length(hist_hp_posterior)+1] = hp_posterior;
    hist_free_energy[length(hist_free_energy)+1] = mk_free_energy(data, hp_posterior, hp_prior, opts);
    min_f = min(hist_free_energy);
    best_r = which.min(hist_free_energy)
    hp_posterior = hist_hp_posterior(best_r);
    cat('SIS: ',r,';  best f = ',min_f,';  best Nc = ',hp_posterior[["Nc"]])   
  }
  cat('SIS done.')
  q_of_z = mk_q_of_z(data, hp_posterior, hp_prior, opts);
  return(q_of_z)
}

#===================================================================================================
#
# p_TSB(z_test|Z)
#
# \begin{align*}
# p_{\text{TSB}}(Z) =& 
# \alpha^{T-1}
# \prod_{i<T}
# \frac
# {\Gamma(1+N_i) \Gamma(\alpha + N_{>i})}
# {\Gamma(1+\alpha+N_{\geq i})}
# \\
# p_{\text{TSB}}(z_{test}=t,Z) = &
# \left(
# \frac{1+N_t}{1+\alpha+N_{\geq t}}
# \right)^{\mathbb{I}(t<T)}
# \left\{
# \prod_{j<t}\frac
# {\alpha + N_{>j}}
# {1+\alpha+N_{\geq j}}
# \right\}
# \alpha^{T-1}
# \prod_{i<T}
# \frac
# {\Gamma(1+N_i) \Gamma(\alpha + N_{>i})}
# {\Gamma(1+\alpha+N_{\geq i})}
# \\
# p_{\text{TSB}}(z_{test}=t|Z) = &
# \left(
# \frac{1+N_t}{1+\alpha+N_{\geq t}}
# \right)^{\mathbb{I}(t<T)}
# \prod_{j<t}\frac
# {\alpha + N_{>j}}
# {1+\alpha+N_{\geq j}}
# \end{align*}
#===============================================================================================
mk_E_pi = function(hp_posterior, hp_prior, opts){
  if ((opts[["algorithm"]]== 'cdp') || (opts[["algorithm"]]=='non_dp')){
    E_pi = hp_posterior[["tilde_alpha"]] / sum(hp_posterior[["tilde_alpha"]]);
  }else{
    if(opts[["algorithm"]]=='bj'){
      second_term = cbind(0,apply(log(hp_posterior[["hp_posterior"]][2,]) - log(sum(hp_posterior[["hp_posterior"]])),2,cumsum)); # 1 by K
      E_pi = exp(cbind(log(hp_posterior[["hp_posterior"]][1,]) 
                       - log(apply(hp_posterior[["hp_posterior"]],1,sum))
                       + second_term[c(1:length(second_term)-1)]
                       , second_term(length(second_term)))); # 1 by K
    }else{
      if (opts[["algorithm"]]=='vdp'){
        opts_tmp = opts;
        opts[["tmp"]][["algorithm"]] = 'bj';
        E_pi = mk_E_pi(hp_posterior, hp_prior, opts_tmp);
        E_pi(length(E_ip)) = pmax(1 - sum(E_pi(1:length(E_pi-1))), 0);
      }else{
        if (opts[["algorithm"]]=='csb'){
          N = dim(hp_posterior[["q_of_z"]])[1]
          K = dim(hp_posterior[["q_of_z"]])[2]
          a = 1 + hp_posterior[["Nc"]]; # 1 by K
          b = hp_prior[["alpha"]] + N - apply(hp_posterior[["Nc"]], 2,cumsum); # 1 by K
          first_term = a / (a+b);
          first_term(length(first_term)) = 1;
          second_term = cumprod(b/(a+b)) / (b/(a+b));
          E_pi = first_term * second_term;
        }else{
          stop('not supported algorithm')
        }
      }
    }
  }
  return(E_pi)
  
}
#===============================================================================================
mk_E_Nc_minus_n= function(q_of_z){
  # returns E[Nc^-n]; the expected value of Nc-n; N by K
  #         V[Nc^-n]; the variance of Nc-n;       N by K
  # q_of_z : N by K
  N = dim(q_of_z)[1];
  E_Nc_minus_n = matrix(rep(apply(q_of_z, 1,sum)*N), ncol=ncol(q_of_z)) - q_of_z;
  tmp = q_of_z*(1-q_of_z);
  V_Nc = apply(tmp, 1,sum);
  V_Nc_minus_n = matrix(rep(V_Nc,N), ncol=ncol(V_Nc)) - tmp;
  
  return(E_Nc_minus_n=E_Nc_minus_n, V_Nc_minus_n=V_Nc_minus_n)
}
#===============================================================================================

mk_E_log_p_of_z_given_other_z= function(hp_posterior, hp_prior, opts){
  # returns E[log p(z_n|Z^-n)]_q(Z^-n)
  # E_log_p_of_z_given_other_z : N by K
  q_of_z = hp_posterior[["q_of_z"]];
  N = dim(q_of_z)[1];
  K = dim(q_of_z)[2];
  outputmkENcMn = mk_E_Nc_minus_n(q_of_z); # N by K
  E_Nc_minus_n=outputmkENcMn$E_Nc_minus_n
  V_Nc_minus_n=outputmkENcMn$V_Nc_minus_n
  use_variance = 1;
  if (opts[["algorithm"]]=='cdp'){
    if (use_variance){
      E_log_p_of_z_given_other_z = 
        log(E_Nc_minus_n + hp_prior[["alpha"]]/K) 
      - 0.5*V_Nc_minus_n/((E_Nc_minus_n+hp_prior[["alpha"]]/K)^2) 
      - log(N - 1 + hp_prior[["alpha"]]);
    }else{
      E_log_p_of_z_given_other_z = 
        log(E_Nc_minus_n + hp_prior[["alpha"]]/K) 
      - log(N - 1 + hp_prior[["alpha"]]);
    }
  }else{
    if (opts[["algorithm"]]== 'csb'){
      E_Nc_minus_n_cumsum_geq = rev(apply(fliplr(E_Nc_minus_n), 2,cumsum));
      q_of_z_cumsum_geq = rev(apply(rev(q_of_z), 2,cumsum));
      dummy = q_of_z_cumsum_geq*(1-q_of_z_cumsum_geq);
      v_Nc_cumsum_geq = matrix(rep(apply(dummy, 1,sum),N),ncol=ncol(apply(dummy, 1,sum))) - dummy;
      E_Nc_minus_n_cumsum = E_Nc_minus_n_cumsum_geq - E_Nc_minus_n;
      q_of_z_cumsum = q_of_z_cumsum_geq - q_of_z;
      dummy = q_of_z_cumsum*(1-q_of_z_cumsum);
      v_Nc_cumsum = matrix(apply(dummy, 1,sum), ncol=ncol(apply(dummy, 1,sum))) - dummy;
      if (use_variance){
        first_term = 
          (log(1+E_Nc_minus_n) 
           - 0.5*V_Nc_minus_n/((1+E_Nc_minus_n)^2) 
           - log(1+hp_prior[["alpha"]]+E_Nc_minus_n_cumsum_geq) 
           + 0.5*v_Nc_cumsum_geq/((1+hp_prior[["alpha"]]+E_Nc_minus_n_cumsum_geq)^2));
        first_term[,end] = 0;
        dummy = log(hp_prior[["alpha"]]+E_Nc_minus_n_cumsum) 
        - 0.5*v_Nc_cumsum/((hp_prior[["alpha"]]+E_Nc_minus_n_cumsum)^2) 
        - log(1+hp_prior[["alpha"]]+E_Nc_minus_n_cumsum_geq) 
        + 0.5*v_Nc_cumsum_geq/((1+hp_prior[["alpha"]]+E_Nc_minus_n_cumsum_geq)^2);
        second_term = apply(dummy, 2,cumsum) - dummy;
      }else{
        first_term = log(1+E_Nc_minus_n) - log(1+hp_prior[["alpha"]]+E_Nc_minus_n_cumsum_geq);
        first_term[,end] = 0;
        dummy = log(hp_prior[["alpha"]]+E_Nc_minus_n_cumsum) 
        - log(1+hp_prior[["alpha"]]+E_Nc_minus_n_cumsum_geq);
        second_term = apply(dummy, 2,cumsum) - dummy;
      }
      E_log_p_of_z_given_other_z = first_term + second_term;
    }else{
      stop('unsupported algorithm');
    } 
  }
  
  # Gaussian approximation may not give a proper distribution.
  # note. E[log p] is not need to be proper
  
  return(E_log_p_of_z_given_other_z)
}
#===============================================================================================
mk_quad_term = function(data, q_of_z, hp_prior, opts){
  # calculate the quad_term in marginalizing out means
  # quad_term : D by D by K
  #
  N = dim(q_of_z)[1];
  K = dim(q_of_z)[2];
  D = dim(data[["given_data"]])[1];
  Nc = apply(q_of_z, 1,sum); # 1 by K
  xi = Nc + hp_prior[["xi0"]];
  f0 = 1 / (xi^2);
  f1 = - 2 / (xi^3);
  f2 = 3 / (xi^4);
  v = q_of_z*(1 - q_of_z); # N by K
  c = v*((1-q_of_z)^2 + q_of_z^2);
  q = v*((1-q_of_z)^3 + q_of_z^3);
  p_x = data[["given_data"]] * q_of_z; # D by K
  v_x = data[["given_data"]] * v;      # D by K
  c_x = data[["given_data"]] * c;      # D by K
  v_p_x = data[["given_data"]] * (q_of_z + v); # D by K
  c_p_x = data[["given_data"]] * (q_of_z + c); # D by K
  for (t in 1:K){
    first_term = f0(t)%*% 
      ((matrix(rep(t(v[,t]),D), ncol=ncol(t(v[,t])))*data[["given_data"]])%*%t(data[["given_data"]])+
         crossprod(t(p_x[,t])));
    second_term = f1(t) %*%matrix(rep(t(c[,t]),D), ncol=ncol(t(c[,t])))%*%crossprod(t(data[["given_data"]]))+ 
      crossprod(t(v_p_x[,t])) - crossprod(t(v_x[,t])) - crossprod(t(p_x[,t]));
    tmp = q[,t] - 3*v[,t]^2 + v[,t]*sum(v[,t]);
    third_term = f2(t) *matrix(rep(t(tmp),D),ncol=ncol(t(tmp)))*crossprod(t(data[["given_data"]]))+ 
      crossprod(t(c_p_x[,t])) - crossprod(t(c_x[,t])) - crossprod(t(p_x[,t]))+ 2*crossprod(t(v_x[,t]))+
      sum(v[,t])*crossprod(t(p_x[,t]));
    quad_term[,,t] = first_term + second_term + third_term; 
  }
  return(quad_term)
}

#===============================================================================================
log_T_dist = function(X, m, sigma, f){
  # X is a D by n matrix
  D= dim(X)[1];
  n = dim(X)[2];
  diff = X-matrix(rep(m,n),nrow=nrow(m));
  log_prob = lngamma((f+D)/2) - D/2*log(f*pi) -
    lngamma(f/2) - 0.5*detln(sigma) -
    (f+D)/2*log(1 + apply( diff * (solve((f*sigma),diff)), 1,sum));
  return(log_prob)
}
#===============================================================================================
log_predictive_dist = function(data, q_of_z, hp_posterior, hp_prior, opts){
  
  if (opts[["use_kd_tree"]]){
    N = length(data[["kdtree"]]);
    D = dim(data[["kdtree"]][1][["sum_x"]])[1];
    Na = list()
    sum_x = list()
    for ( i in 1: length(data[["kdtree"]])){
      Na[length(Na)+1] = data[["kdtree"]][i][["N"]]
      sum_x[length(sum_x)+1] = data[["kdtree"]][i][["sum_x"]]
    }
    
    if (opts[["algorithm"]]== 'vdp'){
      true_Nc = Na*q_of_z; # 1*K
      q_of_z[,end] = 0;
    }
    
    Nc = Na*q_of_z; # 1*K
    sum_x = sum_x%*% q_of_z;
  }else{
    N = dim(data[["given_data"]])[1];
    D = dim(data[["given_data"]])[2];
    if (opts[["algorithm"]]== 'vdp'){
      true_Nc = apply(q_of_z, 1,sum); # 1*K
      q_of_z[,ncol(q_of_z)] = 0;
    }
    Nc = apply(q_of_z, 1,sum); # 1*K
    sum_x = data[["given_data"]] * q_of_z;
  }
  
  E_pi = mk_E_pi(hp_posterior, hp_prior, opts);
  toRepeat = hp_prior[["xi0"]]*hp_prior[["m0"]]
  m = (sum_x + matrix(rep(toRepeat,dim(sum_x,2)), nrow=nrow(toRepeat))) / matrix(rep(Nc,D), ncol=ncol(Nc));
  indx2set= which((Nc==0)!=0,arr.ind = T)
  E_pi(indx2set) = 0;
  n = dim(opts[["test_data"]])[2]
  log_prob = matrix(rep(0,dim(m)[2]*n), ncol=n);
  for (c in 1:dim(m)[2]){
    f = hp_posterior[["eta"]][c] + 1 - D;
    sigma = hp_posterior[["B"]][c] * (hp_posterior[["xi"]][c]+1) / hp_posterior[["xi"]][c] / f;
    if (E_pi[c] > 0){
      log_prob[c,] = log(E_pi[c]) + log_T_dist(opts[["test_data"]], m[,c], sigma, f);
    }else{
      log_prob[c,] = -Inf;
    }
  }
  log_prob = log_sum_exp(log_prob,1);
  return(log_prob)
}
#===============================================================================================
mk_log_likelihood = function(data, hp_posterior, hp_prior, opts){
  D= dim(data[["given_data"]])[1];
  N =  dim(data[["given_data"]])[2];
  K = dim(hp_posterior[["m"]])[2];
  log_likelihood = zeros(rep(0,N*K),ncol=N);
  E_pi = mk_E_pi(hp_posterior, hp_prior, opts);
  
  for (c in 1:K){
    mu = hp_posterior[["m"]][,c];
    f = hp_posterior[["eta"]][c] + 1 - D;
    Sigma = (hp_posterior[["xi"]][c]+1) / hp_posterior[["xi"]][c] / f * hp_posterior[["B"]][c];
    log_likelihood[c,] = log_no_w(E_pi[c]) + logmvtpdf(data[["given_data"]], mu, f, Sigma);
  }
  
  log_likelihood = log_sum_exp(log_likelihood, 1); # 1 by N
  log_likelihood = apply(log_likelihood, 2,sum);
  
  return(log_likelihood)
}
#===============================================================================================

#given_data = X
# opts = opts
vdpgm = function(given_data, opts = list()){
  #
  # function [results] = vdpgm(given_data, opts)
  #
  results = list()
  args = list(given_data = given_data, opts=opts);
  nargin = (!is.null(args[['given_data']]))+(!is.null(args[['opts']]))
  start_time = proc.time();
  if (nargin == 1){
    opts = list();
  }
  if ((typeof(given_data)[1]=="CsparseMatrix") || (typeof(given_data)[1]=="TsparseMatrix")||
        (typeof(given_data)[1]=="RsparseMatrix") || (typeof(given_data)[1]=="ddenseMatrix")){
    stop('please send the full matrix and not the sparse version.....Thank You!')
  }
  if (!("algorithm" %in% names(opts))){
    # algorithm can be one of 'vdp', 'bj', 'cdp', 'csb' and 'non_dp'
    # vdp : variational DP
    # bj : Blei and Jordan
    # cdp : collapsed Dirichlet prior
    # csb : collapsed stick-breaking
    # non_dp : variational Bayes for Gaussian mixtures
    opts[["algorithm"]] = 'vdp';
  }
  if (!("collapsed_means" %in% names(opts))){
    opts[["collapsed_means"]] = 0;
  }
  if (!("do_sort" %in% names(opts))){
    opts[["do_sort"]] = '0';
  }
  if (!("get_q_of_z" %in% names(opts))){
    opts[["get_q_of_z"]] = 0;
  }
  if (!("weight" %in% names(opts))){
    opts[["weight"]] = 1;
  }
  if (!("get_log_likelihood" %in% names(opts))){
    opts[["get_log_likelihood"]] = 0;
  }
  if (!("use_kd_tree" %in% names(opts))){
    opts[["use_kd_tree"]] = 1;
  }
  if (!("threshold" %in% names(opts))){
    opts[["threshold"]] = 1.0e-5;
  }
  if (!("sis" %in% names(opts))){
    opts[["sis"]] = 0;
  }
  if (!("initial_depth" %in% names(opts))){
    opts[["initial_depth"]] = 3;
  }
  if (!("initial_K" %in% names(opts))){
    opts[["initial_K"]] = 1;
  }
  if (!("ite" %in% names(opts))){
    opts[["ite"]] = Inf;
  }
  if (!("do_split" %in% names(opts))){
    opts[["do_split"]] = 0;
  }
  if (!("do_merge" %in% names(opts))){
    opts[["do_merge"]] = 0;
  }
  if (!("do_greedy" %in% names(opts))){
    opts[["do_greedy"]] = 1;
  }
  if (!("max_target_ratio" %in% names(opts))){
    opts[["max_target_ratio"]] = 0.5;
  }
  if (!("init_of_split" %in% names(opts))){
    # 'pc', 'rnd', 'rnd_close' or 'close_f'
    opts[["init_of_split"]] = 'pc';
  }
  if (!("recursive_expanding_depth" %in% names(opts))){
    opts[["recursive_expanding_depth"]] = 2;
  }
  if (!("recursive_expanding_threshold" %in% names(opts))){
    opts[["recursive_expanding_threshold"]] = 1.0e-1;
  }
  if (!("recursive_expanding_frequency" %in% names(opts))){
    opts[["recursive_expanding_frequency"]] = 3;
  }
  if (("seed" %in% names(opts))){
    set.seed(opts[["seed"]], kind = NULL, normal.kind = NULL)
  }else{
    seed = .Random.seed;
    results[["seed"]] = seed;
  }
  data = list()
  data[["given_data"]] = given_data;
  if (opts[["use_kd_tree"]]>0){
    partitions = init_kdtree_partitions(given_data, opts[["initial_depth"]]);
    data[["kdtree"]] = partitions;
  }
  # the hyperparameters of priors
  hp_prior = mk_hp_prior(data, opts);
  
  if (("hp_posterior" %in% names(opts))){
    opts[["use_kd_tree"]] = 0
    if (opts[['get_q_of_z']]){
      results[["q_of_z"]] = mk_q_of_z(data, opts[["hp_posterior"]], opts[["hp_prior"]], opts);
    }
    if ((opts[['get_log_likelihood']])){
      results[["log_likelihood"]] = mk_log_likelihood(data, opts[["hp_posterior"]], opts[["hp_prior"]], opts);
    }
    if (!("test_data" %in% names(opts))){
      results[["predictive_posterior"]] = log_predictive_dist(data, opts[["q_of_z"]], opts[["hp_posterior"]], 
                                                              opts[["hp_prior"]], opts);
    }
    return(results)
  }
  if (opts[["sis"]] > 0){
    q_of_z = sequential_importance_sampling(data, hp_prior, opts);
  }else{
    if ('q_of_z' %in% names(opts)){
      q_of_z = opts[["q_of_z"]];
    }else{
      q_of_z = rand_q_of_z(data, opts[["initial_K"]], opts);
    }
  }
  
  hp_posterior = mk_hp_posterior(data, q_of_z, hp_prior, opts);
  if (!is.null(opts[["do_greedy"]])){
    gOutput= greedy(data, hp_posterior, hp_prior, opts);
    free_energy= gOutput$free_energy
    hp_posterior= gOutput$hp_posterior
    data = gOutput$data
  }else{
    smOutput= split_merge(data, hp_posterior, hp_prior, opts);
    free_energy= smOutput$free_energy
    hp_posterior= smOutput$hp_posterior
    data = smOutput$data
  }
  
  results[["algorithm"]] = opts[["algorithm"]];
  results[["elapsed_time"]] = proc.time() - start_time; #elapsed time
  results[["free_energy"]] = free_energy;
  results[["hp_prior"]] = hp_prior;
  results[["hp_posterior"]] = hp_posterior;
  results[["K"]] = length(hp_posterior[["eta"]]);
  results[["opts"]] = opts;
  
  if (opts[["get_q_of_z"]]){
    results[["q_of_z"]] = mk_q_of_z(data, hp_posterior, hp_prior, opts);
    if (opts[["use_kd_tree"]]){
      results[["q_of_z"]] = mk_non_kdtree_q_of_z(data, results[["q_of_z"]]);
    }
  }
  
  if (opts[["get_log_likelihood"]]){
    results[["log_likelihood"]] = mk_log_likelihood(data, hp_posterior, hp_prior, opts);
  }
  
  
  return(results)
}
#===============================================================================================



# read sample data of characteristics of category 
sampleFilePath = 'C:/Users/MeisamHe/Desktop/Desktop/Projects/RegretInAuction/VariationalBayesian/vdpgm/testData.csv'
num =read.csv(file=sampleFilePath,head=FALSE,sep=",")

X = t(num);
opts = mkopts_bj(10);   # for the algorithm 4 with T=10 

# test the program and make sure it works in Octav and Matlab
result = vdpgm(X, opts);







