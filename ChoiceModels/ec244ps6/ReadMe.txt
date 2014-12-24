The file mxlhb.m (and accompanying .m files) estimates a mixed logit model using hierarchical Bayes (HB) procedures. This code is on my website, if you ever want to retrieve it after the course is over. The data are the same as in problem set 4. The mixed logits that were estimated with maximum simulated likelihood in problem set 4 will be re-estimated with HB in this problem set, along with a generalization to full covariance among the random coefficients.

Utility takes thew form U=F*Z+C*X+e where e is extreme value, F are fixed coefficients on variables Z, and C are random coefficient on variables X. The random coefficients take the form C=T(B) where B~N(A,D) and T is a transformation. For example, if a coefficient is distributed lognormally, then C=exp(B) is the transformation. C is the individual-level coefficients, B is the individual-level latent normal terms, A is the mean of the latent normal terms, and D is the variance of the latent normal terms. 
There are fives sets of paramaters: 
(1) the fixed coefficients, held in vector F.
(2) the population means of the latent normals that underly the random coefficients, held in vector A. 
(3) the population variance of the latent normals that underly the random coefficients, held in matrix D.
(4) the latent normal terms for each person, held in matrix B, with each row containing the latent terms for one person.
(5) the coefficients for each person, held in matrix C, with each row containing the coefficients for one person. 
Of course, if the coefficients are normally distributed, then C=B and A and D are the mean and covariance of the coefficients.
 
The procedure uses Gibbs sampling in the following way: 
(1) Given a value of A, D, and F , a draw from the conditional posterior of each person's coefficients is taken using the M-H algorithm. This gives a draw of B conditional on A,D,F. The corresponding draw of C is obtained by the transformation C=T(B).
(2) Given the value of B, D and F, a draw is taken from the conditional posterior of the population means. This posterior is normal with mean equal to the mean over rows of B and covariance equal to D/N where N is sample size. This gives a draw of A conditional on B,D,F.
(3) Given the value of A, B, and F, a draw is taken from the conditional posterior of the population covariance. This posterior is inverted Wishert. This gives a draw of D conditional on A,B,F.
(4) Given the values of A,D, and B, a draw of the fixed coefficients is taken using the M-H algorithm. This gives a draw of F conditional on A,D, and B.

The program allows the user to specify whether D is diagonal (ie, the random coefficients are uncorrelated with each other) or full. The program also allows the user to specify: how many draws to take during burn-in (ie prior to convergence), how many draws to skip before saving one, and the number of saved draws to take. The program currently uses 10,000 draws for burn-in, keeps every 10th draws after burn-in (ie, skips 9 before saving one), and takes a total of 1000 saved draws after burn-in. The means of these draws are printed to the output file (ie, the mean of the draws of A, mean of the draws of D, the mean over people (ie over rows) of the mean of the draws of B, and the mean of the draws of F.) If the user wants, the means of the draws of A, D, B, and F are written to the file specified in FOUTPUT. Note that the mean of B is a matrix that gives, for each person, the mean of the draws of 
the coefficients for that person.

1. Go over mxlhb.m and make sure you understand what it does. The file ReadMeCodes.txt describes the relations among the various .m files that are called directly or indirectly by mxlhb.m. The code is currently set up to run the same model as in part 4 of problem set 5, namely, a model with a fixed price coefficient and independent normal coefficients for the other attributes. Check that your output matches myrunKT.out, and go over the elements of the output to be sure that you understand what all of them are. 

2. During the iterations, the code prints out the current draw of A and the mean over people of the current draw of B and C. Explain why the mean over people of the current draw of B differs, sometimes greatly, from the current draw of A.  

3. In the "Results" printout, "Est/Mean" is short-hand for the mean of draws of that parameter over all retained draws after burn-in. This mean is a classical estimator of the parameter. "SE/StDv" is short-hand for the standard deviation of the draws of that paramater, which from a classical perspective is the standard error of the estimator. How do the estimates and standard errors compare with those obtained in problem set 4 using maximum simulated likelihood? Note that the diagonal elements of D are variances, while the maximum likelihood estimates are for standard deviations. Note also that operating cost was scaled to tens of dollars for the max. likelihood code, but is not scale for this HB code.

4. For the random coefficients, the jumping distance in the M-H algorithm is determined by RHO, which is adjusted internally such that the percent accepts stays near 0.3.  Look through the iteration log to see how the acceptance rate and RHO change over iterations.

5. For the fixed coefficients, the jumping distance in the M-H algorithm is determined by RHOF, which is set by the user and remains the same for all iterations (since there is no very good way of adjusting it internally.) In mxlhb.m, it is currently set at RHOF=0.01. Look through the iteration log to see what the acceptance rate is. You would like the acceptance to be around 0.3. If it is too high, then you will need to re-start the run with a higher RHOF; and if it is too low, then you will need to re-start the run with a lower RHOF. To see the effect of RHOF, re-run the model with RHOF=0.1. Does the acceptance rate tend to be above or below 0.3?

6. Change RHOF back to 0.01. The code currently estimates a diagonal D (ie, the random coefficients are constrained to be uncorrelated.) The model is therefore specified the same as in problem set 5, which had uncorrelated random coefficients. With hierarchical Bayes, it is as easy to estimate correlated coefficients as uncorrelated ones. Change FULLCV to allow a full covariance matrix and rerun. Do any the coefficients seem to be highly correlated? Does this pattern of correlation among the coefficients seem reasonable? 

7. Now change the specification to have lognormal coefficients for price, operating cost, range, and the performance variances, and normal coefficients for the electric and hybrid dummies. Be sure to change the signs of the price and operating cost variables, so that the lognormal gives the correctly signed coefficients. Also, you might want to use the original starting values rather than zeros, to hasten convergence. This model corresponds to part 7 in problem set 4, except that now the coefficients are all correlated. Do the estimated correlations seem reasonable?


 
 

