# Generating X from poisson distibution
true_lambda <- 1.9
n <- 100 # size of X
X <- rpois(n, true_lambda)

# Testing the following
# H0: lambda > 2 vs. H1: lambda <= 2
lambda0 <- 2
alpha <- 0.05
cat(sprintf("****************************"))

# Using Wald test:
T_wald <- (mean(X) - lambda0)/(sqrt(mean(X)/n))
z_alpha_wald <- qnorm(alpha)
p_value_wald <- pnorm(T_wald)

# Using Maximum Likelihood Ratio test:
l_MLE <- -n*mean(X) + log(mean(X))*sum(X)
l_constrained <- l_MLE
if (lambda0 > mean(X)){
  l_constrained <- -n * lambda0 + log(lambda0)*sum(X)
}
T_MLRT <- 2*(l_MLE - l_constrained)
p_value_MLRT <- 1 - pchisq(T_MLRT, 1)

# Using Bootstrap in Wald test:
B <- 100
means <- rep(0, B)
for (b in 1:B){
  Y <- sample(X, n, replace=TRUE)
  means[b] <- mean(Y)
}
lambda_hat <- mean(means)
se_hat <- sd(means)
T_boot <- (lambda_hat - lambda0)/se_hat
z_alpha_boot <- qnorm(alpha)
p_value_boot <- pnorm(T_boot)

# performing tests and showing the result
if (T_wald < z_alpha_wald){
  cat(sprintf("Wald test rejects H0,  p_value = %.3f\n", p_value_wald))  
}
if (T_wald >= z_alpha_wald){
  cat(sprintf("Wald test doesn't reject H0,  p_value = %.3f\n", p_value_wald))  
}
if (T_MLRT > qchisq(1-alpha, 1)){
  cat(sprintf("MLRT test rejects H0, p_value = %.5f\n", p_value_MLRT))
}
if (T_MLRT <= qchisq(1-alpha, 1)){
  cat(sprintf("MLRT test doesn't reject H0, p_value = %.5f\n", p_value_MLRT))
}
if (T_boot < z_alpha_boot){
  cat(sprintf("Wald test (Bootstrap) rejects H0,  p_value = %.3f\n", p_value_boot))  
}
if (T_boot >= z_alpha_boot){
  cat(sprintf("Wald test (Bootstrap) doesn't reject H0,  p_value = %.3f\n", p_value_boot))  
}
