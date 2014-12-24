We will estimated mixed logit models in this problem set. The code is available to the public from my website, and so if you ever want to retrieve it again after this course is over, you can get it from my wesbite under "software."

The data represent consumers' choices among vehicles in stated preference experiments. The data are from a study that I did for Toyota and GM to assist them in their analysis of the potential marketability of electric and hybrid vehicles, back before hybrids were introduced.   
 
In each choice experiment, the respondent was presented with three vehicles, with the price and other attributes of each vehicle described. The respondent was asked to state which of the three vehicles he/she would buy if the these vehicles were the only ones available in the market. There are 100 respondents in our dataset (which, to reduce estimation time, is a subset of the full dataset which contains 500 respondents.) Each respondent was presented with 15 choice experiments, and most respondents answered all 15. The attributes of the vehicles were varied over experiments, both for a given respondent and over respondents. The attributes are: price, operating cost in dollars per month, engine type (gas, electric, or hybrid), range if electric (in hundreds of miles between recharging), and the performance level of the vehicle (high, medium, or low). The performance level was described in terms of top speed and acceleration, and these descriptions did not vary for each level; for example, "High" performance was described as having a top speed of 100 mpg and 12 seconds to reach 60 mpg, and this description was the same for all "high" performance vehicles. 

1. Read the code mxlmsl.m and make sure you understand what all the options do. You can ignore the other .m files that the code uses; you only need to know these codes if you want to change the basic structure of the code to provide more or different options than the code currently contains. 

2. It is always best to start with a standard logit model. To save you time, I have created code mxlmsllogit.m which contains the appropriate revisions to mxlmsl.m. Just run it and examine the output, which should match myrunlogitKT.out.

a. Do the estimated coefficients have the expected signs?
b. What is the estimated willingness to pay for a $1 per month reduction in operating cost? Note that price is in tens of thousands of dollars, and operating cost is in tens of dollars.
c. The variable "medhiperf" = 1 if the vehicle has either medium or high performance and =0 if the vehicle has low performance. The variable "hiperf" = for high performance and =0 for medium or low performance. So, a vehicle with high performance has a 1 for both of these variables. The estimated "utility" from each performance level is therefore 0 for low performance. 0.3841 for medium performance, and 0.3841+0.1099=0.4940 for high performance. Or, stated incrementally, the estimates imply that going from low to medium performance increases "utility" by 0.3841, while going from medium to high performance increases utility by 0.1099. These estimates imply diminishing marginal utility of performance. 
d. There are three engine types, with alternative specific constants entered for two of them (with the gas engine normalized to zero.) What do the estimated constants imply about consumers' preferences for electric and hybrid vehicles relative to gas? 

3. Operating cost is scaled to be in tens of dollars. The optimizer operates most effectively when the diagonal of the hessian has about the same order of magnitude for all parameters, which can usually be accomplished by scaling variables such that their coefficients are about the same order of magnitude. To see the effect of scaling, remove the scaling of operating cost, such that operating cost enters as dollars rather than tens of dollars. How many more iterations does the optimizer take to converge when operating cost is in dollars compared to when operating cost is in tens of dollars? For standard logit, the difference is run time is immaterial, since estimation is so quick in any case. But when running mixed logit and other models that require simulation, the difference can be considerable. It is always helpful, therefore, to run standard logit models to get the scaling right, since checking various scales is quick in standard logit, and then to use that scaling when you turn to mixed logit.

4. Now estimate a mixed model with a fixed price coefficient and normal coefficients for all other attributes. This is probably the most common mixed logit specification. The code mxlmsl.m is set up to run this model. Run it and examine the output, which should match myrunKT.out.

a. Each random coefficient is distributed N(B,W^2) where B and W are estimated. Eg, the operating cost coefficient is estimated to have a mean of -0.1355 and standard deviation of 0.3382, such that the variance is 0.3382^2=0.114. Note, however, that the estimated W can be negative, as occurs for two of the coefficients. The negative sign in these cases is simply ignored, and the standard deviation is the estimate without the negative sign. Here's the reason: the parameter that is being estimated is not actually the standard deviation; rather it is W such that W^2=variance.  W and -W give the same variance, and hence are equivalent. Also, since the standard deviation is defined as the square root of the variance, they give the same standard deviation. The advtantage of estimating W instead of estimating a standard deviation is that the optimization routine does not need to embody constraints to keep the parameter positive. Another way to see the issue is that a random variable that is N(B,W^2) is created as B+w*mu where mu is standard normal, or equivalently as B-W*mu: both result in a term with mean B and standard deviation W. An implication of this parameterization is that the starting values of W should not be set at 0, but rather at some value slightly away from zero. The reason is this: Since W and -W are equivalent, the true LL is symmetric around W=0 and hence is flat at W=0. (The simulated LL is not exactly symmetric due to simulation noise.) If W=0 were used as the starting values, the gradient would be zero and the optimization routine would have no guidance on the direction to move. (If you want, you can change the starting value for W to zero, and rerun the model. You'll see that it has a smaller improvement in the first iteration and takes more iterations to converge. 

b. What is the estimated distribution of willingness to pay for a 1 dollar reduction in operating cost? An advantage of having a fixed price coefficient is that this distribution can be derived fairly easily. (If, in contrast, the price coefficient is random, the willingness to pay is the ratio of two random terms, which is more difficult to deal with.)

c. What share of the population is estimated to dislike reductions in operating cost? To like high performance less than medium performance? Are these results reasonable?


5.Let's explore the effects of simulation noise. The seed is currently set at SEED1=14239. Change the seed to other values to see the effect of different random draws on the estimation results. Try three or four seeds, to get a sense of how much change there is. 

6. How let's return to specification issues. We have seen that the use of normal distributions creates unrealistic results for coefficients that should be the same sign for all people. Change the distributions for the operating cost, range, and the performance, to be lognormal instead of normal. So that we all get the same results, set SEED1 = 14239. Also, this is important: the lognormal distribution has support only on the positive side of zero. So, if you want to use a lognormal distribution for an undesirable attribute (for which all people have negative coefficients), then you need to reverse the sign of the variable. The lognormal distribution will give positive coefficients for the negative of the undesirable attribute, which is the same as negative coefficient for the undesirable attribute itself. This means, that, in the data setup, right after 
XMAT=load('data.txt');
you need to add
XMAT(:,5)= -XMAT(:,5);
so that the operating cost variable becomes the negative of operating cost. Then change IDV to specify lognormals for operating cost, range, and the performance variances.

a. Does this model fit the data better or worse than the model with normal distributions, based on the log-likelihood value?

b. What are the estimated mean and standard deviation of the willingness to pay for operating cost reductions? How do they compare to those from the model with normal distributions?

7. Now allow the price coefficient to have a lognormal coefficient. Be sure to change the sign of price in XMAT. What is the estimated distribution for willingness to pay for operating cost reductions?

8. Try other specification and find the model that you think is best. 



For your information (nothing you need to do): 
You might at some point want to do something different from what this code allows. You can revise the various .m files appropriately for other specifications. To do so, you need to know a bit about the structure of the code and what each .m file does. Here is a basic description, which you can read now or wait until (if ever) you actually want to make a change.

mxlmsl.m sets-up the specification and then calls doit.m, which is actually the main organizing component of the code.
Doit.m does the following:
1. calls check.m, which checks the data, 
2. creates variables that are used in estimation,
3. calls makedraws.m, which creates the draws based on the user-specifications in mxlmsl.m
4. sets the options for matlab's optimization routine (in the "option" statement)
5. calls matlab's optimizer fminunc, telling it to use loglik.m to calculate the function that is being minimized and its gradient.
6. after convergence, calculates the standard errors of the estimates and prints out results.

The optimizer is told to use loglik.m to calculate the log-likelihood (LL) and gradient. However, loglik.m simply partitions the parameters into sets (fixed coefficients, and B and W for random coefficients) and calls llgrad2.m, which actually calculates the LL and gradient for each observation.  

So, in short:
The LL and gradient are calculated in llgrad2.m. 
The draws are created in makedraws.m.
The options for matlab's optimizer are set in doit.m

If you want to make changes in how the LL is calculated from the parameters, then you revise llgrad2.m.
If you want to make changes in how the draws are created, then you revise makedraws.m
