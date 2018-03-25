#install.packages("Rcpp")
#install.packages("fastGHQuad")
library(fastGHQuad)
# Get quadrature rules
rule10  <- gaussHermiteData(10)
rule100 <- gaussHermiteData(100)

# Estimating normalizing constants
g <- function(x) 1/(1+x^2/10)^(11/2) # t distribution with 10 df

#===============================================================================
#Meisam's function : conlusion: it needs specific form of function that I lack => use adaptive below
f <- function(x) 2x # t distribution with 10 df
aghQuad(f, 0, 1,  rule100)
#===================================================================================
aghQuad(g, 0, 1.1,  rule10)
aghQuad(g, 0, 1.1,  rule100)
# actual is
1/dt(0,10)

# Can work well even when the approximation is not exact
g <- function(x) exp(-abs(x)) # Laplace distribution
aghQuad(g, 0, 2,  rule10)
aghQuad(g, 0, 2,  rule100)
# actual is 2

# Estimating expectations
# Variances for the previous two distributions
g <- function(x) x^2*dt(x,10) # t distribution with 10 df
aghQuad(g, 0, 1.1,  rule10)
aghQuad(g, 0, 1.1,  rule100)
# actual is 1.25

# Can work well even when the approximation is not exact
g <- function(x) x^2*exp(-abs(x))/2 # Laplace distribution
aghQuad(g, 0, 2,  rule10)
aghQuad(g, 0, 2,  rule100)
# actual is 2

#======================================================================
# adaptive method for one dimensional integral
#=====================================================================
integrate(dnorm, -1.96, 1.96)
integrate(dnorm, -Inf, Inf)

#============================
# Meisam's test: works perfectly
#============================
meisam <- function(x) {x^2}
integrate(meisam, lower = 0, upper = 1)


## a slowly-convergent integral
integrand <- function(x) {1/((x+1)*sqrt(x))}
integrate(integrand, lower = 0, upper = Inf)

## don't do this if you really want the integral from 0 to Inf
integrate(integrand, lower = 0, upper = 10)
integrate(integrand, lower = 0, upper = 100000)
integrate(integrand, lower = 0, upper = 1000000, stop.on.error = FALSE)

## some functions do not handle vector input properly
f <- function(x) 2.0
try(integrate(f, 0, 1))
integrate(Vectorize(f), 0, 1)  ## correct
integrate(function(x) rep(2.0, length(x)), 0, 1)  ## correct

## integrate can fail if misused
integrate(dnorm, 0, 2)
integrate(dnorm, 0, 20)
integrate(dnorm, 0, 200)
integrate(dnorm, 0, 2000)
integrate(dnorm, 0, 20000) ## fails on many systems
integrate(dnorm, 0, Inf)   ## workss

#===========================================================
# code of adaptive quadrature
#==========================================================-
simpson <- function(fun, a, b, n=100) {
  # numerical integral using Simpson's rule
  # assume a < b and n is an even positive integer
  h <- (b-a)/n
  x <- seq(a, b, by=h)
  if (n == 2) {
    s <- fun(x[1]) + 4*fun(x[2]) +fun(x[3])
  } else {
    s <- fun(x[1]) + fun(x[n+1]) + 2*sum(fun(x[seq(2,n,by=2)])) + 4 *sum(fun(x[seq(3,n-1, by=2)]))
  }
  s <- s*h/3
  return(s)
}
quadrature <- function(fun, a, b, tol=1e-8) {
  # numerical integration using adaptive quadrature
  
  quadrature_internal <- function(S.old, fun, a, m, b, tol, level) {
    level.max <- 100
    if (level > level.max) {
      cat ("recursion limit reached: singularity likely\n")
      return (NULL)
    }
    S.left <- simpson(fun, a, m, n=2) 
    S.right <- simpson(fun, m, b, n=2)
    S.new <- S.left + S.right
    print(paste(a,m,b,'\n'))
    if (abs(S.new-S.old) > tol) {
      S.left <- quadrature_internal(S.left, fun, a, (a+m)/2, m, tol/2, level+1)
      S.right <- quadrature_internal(S.right, fun, m, (m+b)/2, b, tol/2, level+1)
      S.new <- S.left + S.right
    }
    return(S.new)
  }
  
  level = 1
  S.old <- (b-a) * (fun(a) + fun(b))/2
  S.new <- quadrature_internal(S.old, fun, a, (a+b)/2, b, tol, level+1)
  return(S.new)
}

#============================
# Meisam's test: works perfectly
#============================
meisam <- function(x) {x^2}
quadrature(meisam, 0,1)
