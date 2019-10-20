# Comparing alpha and log(1/(1-alpha))
a <- seq(.005, .1, .001)
y <- log(1/(1-a))
plot(a, type="l", col='red', ylab="alpha")
lines(y, type="l", col='blue')

# Computing p-values for N independent hypothesis tests
N <- 100
n <- 10
alpha <- .05
p_values <- rep(0, N)
for (i in 1:N){
  # Testing the following
  # H0: lambda >= 2 vs. H1: lambda < 2
  true_lambda <- 1.5
  lambda0 <- 2
  X <- rpois(n, true_lambda)
  T <- (mean(X) - lambda0)/(sqrt(mean(X)/n))
  p_value <- pnorm(T)
  p_values[i] <- p_value
}

# Single Test
plot(1:N, p_values, cex=.4, ylab="p-value",  xlab="Sample", title("Single Test"))
lines(1:N, rep(alpha, N), col='red')

# Bonferroni Test
plot(1:N, p_values, cex=.4, ylab="p-value", xlab="Sample", title("Single Test"))
lines(1:N, rep(alpha/N, N), col='red')

# BH Test
sorted_p_values = sort(p_values)
plot(1:N, sorted_p_values, cex=.4, ylab="p-value", xlab="Sample", title("Single Test"))
lines(1:N, alpha*(1:N)/N, col='red')


