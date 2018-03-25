
#library(bayesm)
#library(abind)
#library(mixtools)    # used for the EM mixture semi parameteric
#library(locfit)


#===============================
# Run non parametric regression
#===============================
# spregmix(thetacatj[,2] ~ CategoryHB)
# # following is for model selection
# result = regmixmodel.sel(CategoryHB, thetacatj[,2], w = NULL, k = 2, type = c("fixed","random", "mixed"))
# regmixEM.mixed(thetacatj, CategoryHB, w = NULL, sigma = NULL, arb.sigma = TRUE,
#                alpha = NULL, lambda = NULL, mu = NULL,
#                rho = NULL, R = NULL, arb.R = TRUE, k = 2,
#                ar.1 = FALSE, addintercept.fixed = FALSE,
#                addintercept.random = TRUE, epsilon = 1e-08,
#                maxit = 10000, verb = FALSE)
# mvnormalmixEM(thetacatj, lambda = NULL, mu = NULL, sigma = NULL, k = 2,
#               arbmean = TRUE, arbvar = TRUE, epsilon = 1e-08,
#               maxit = 10000, verb = FALSE)

# alpha: first parameter: nearest neighbor fraction, second: bandwidth
#result = locfit(thetacatj ~ CategoryHB + thetacatj, alpha=c(0, 0.2), deg=3)

# polymars(thetacatj, CategoryHB, maxsize, gcv = 4, additive = FALSE, 
#          startmodel, weights, no.interact, knots, knot.space = 3, ts.resp, 
#          ts.pred, ts.weights, classify, factors, tolerance, verbose = FALSE)