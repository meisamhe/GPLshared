This problem set explores probit models. We will use data on the mode choices of 453 commuters. Four modes are available: (1) car alone, (2) carpool, (3) bus, and (4) rail. For each commuter, the dataset contains the cost and time on each mode. 

1. Read probit.m and make sure that you understand the various options. This program estimates a full covariance matrix subject to normalization. Since there are four alternative the covariance matrix for utilities is 4x4. However, normalizations for level and scale reduces the number of free covariance parameters. First, since only differences in utility matter, only the covariance matrix for utility differences can be identified. The code takes differences against the first alternative, such that the covariance matrix of utility differences is 3x3 for: carpool minus car, bus minus car, and train minus car. Since the scale of utility is indeterminant, the scale is normalized by setting the top-left element of this 3x3 covariance matrix to 1. Finally, in order to assure that the covariance matrix is positive definite, the Choleski factor of the covariance matrix is estimated, rather than the covariance matrix itself, since any low-triangular matrix multiplied by its transpose gives a positive definite matrix. The parameters to be estimated are the elements of a Choleski factor L that takes the form:

		1	0	0
		k1	k2	0
		k3	k4	k5

where the top-left element is 1 to assure that the top-left element of L*L' is 1. That is, five covariance parameters are estimated. The covariance matrix for the three utility differences is then Omega=L*L'. The covariance matrix of the four utilities is Omega with a row of zeros added to the top and a column of zeros added to the left.

Run probit.m as it is and check your output against myrunKT.out to be sure everything is working correctly. The output gives that covariance matrix for utility differences (differenced against the first alternative) that is implied by the estimates of the Choleski factor. What, if anything, can you say about the degree of heteroskedasticity and correlation over alternatives? For comparison, what would the covariance matrix be if there were no heteroskedasticity or correlation (ie, iid errors for each alternative)? Can you tell whether the covariance is higher between car alone and carpool or between bus and rail? [I agree: it is hard -- if not impossible -- to meaningfully interpret the covariance parameters when all free parameters are estimated. However, the substitutiuon patterns that the estimates imply can be observed by forecasting with the model; we do this in part 5 below. Also, when structure is placed on the covariance matrix, the estimates are usually easier to interpret; this is explored in part 6.]

2. The run used 100 draws with the seed is set at 1324. Change the seed to 1325 and rerun the model. (Even though the seed is just one digit different, the random draws are completely different.) See how much the estimates change? How large is the change relative to the standard errors of the estimates? Of course, you are only getting two estimates, and so you are not estimating the true simulation variance very well. But the two estimates will give you an indication of how.

3. The smoothed accept-reject simulator was used for estimation. Try using the accept-reject simulator for estimation. What is the reason for the results you get?

4. Now use the GHK simulator and repeat part 2 (ie change the seed to see how much effect it has.) Do the estimates seem to change more or less with GHK relative to smoothed accept-reject. 

5. We want to examine the impact of a large tax on driving alone. Raise the cost of the car alone mode by 50% (do this within probit.m below where the data are entered). Set the starting values for B and C to the estimates you obtained in part 1 (the first run.)  Use the code to predict without estimation (PREDICT=2.) Is the substitution proportional, as a logit model would predict? Which mode has the greatest percent increase in demand? What is the percent change in share for each mode? 

6. Now, lets go back to estimation. As stated above, probit.m estimates the entire set of identified covariance parameters. Often when running probit models you will want to impose some structure on the covariance matrix instead of estimating all identifiable parameters. You might want to do this because there are too many covariance parameters to estimate meaningfully. For example, with 8 alternatives, there are 28 identified covariance parameters. Even if the number of parameters is not an issue, you might have some reason to believe that a particular structure is appropriate. For example, with panel data, the covariance matrix of unobserved utility over time might have an AR1 structure.  We want to be able to revise the estimation program to allow for various structures imposed on the covariance matrix.

Suppose that you are primarily interested in the carpool mode. You suspect that you might not be capturing many of the relevant issues for carpooling such that the unincluded factors would have a relatively large variance. You also expect a correlation between some of the unobserved factors for carpool and those for car alone. You are not so concerned about the transit modes and are willing to assume that their unobserved factors are iid. You specify a covariance matrix with the following structure:

	1	r	0	0
	r	m	0	0
	0	0	1	0
	0	0	0	1 

That is, you want to estimate the variance of carpool utility (relative to the variance for the other modes) and the covariance of carpool with car alone, under the maintained assumption that the transit modes have the same variance as car alone and are independent. 

Revise the code to estimate m and r rather than the full covariance matrix, To do this, you'll need to make changes to these files:

1. In probit.m, change C to consist of only two elements: the starting values of m and r. So, C will have a length of 2 instead of 5.
2. In check.m, change the statement that checks the size of C, since now size(C,2)==2 is appropriate instead of size(C,2) == (NALT*(NALT-1)/2)-1, which is 5 in our original model.
3. In loglik.m, which calculates the log-likelihood, revise the way that the utility errors are created from the parameters. This is the only tricky part!  
4. If you want, you can also change predict.m appropriately. Or you can just not predict with the new specification. 

Just so we can all compare results, use seed2=1324, SIMTYPE=2, and NDRAWS=100, like in the original probit.m.

Based on the estimation results: (i) How large is the variance of the unobserved factors relating to carpool, relative to the variances for the other modes? (ii) What is the correlation between the unobserved utility of carpool and car alone? 
