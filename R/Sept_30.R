# Initializing 
true_mu <- 0
true_sigma <- 1
n <- 10
B <- 1000
sigma2_list = rep(0, B)
s2_list = rep(0, B)

# Computing two different estimators of true-sigma
for (b in 1:B){
  X = rnorm(n, mean = true_mu, sd = true_sigma)
  sigma2_list[b] = sum((X - mean(X))^2)/n
  s2_list[b] = sum((X - mean(X))^2)/(n-1)
}

# Computing bias, variance and MSE for sigma2
bias = mean(sigma2_list) - true_sigma^2
variance = mean((sigma2_list - mean(sigma2_list))^2)
MSE = bias^2 + variance
cat(sprintf("******* sigma2 *******\nBias = %f\nVariance = %f\nMSE = %f\n", bias, variance, MSE))

# Computing bias, variance and MSE for s2
bias = mean(s2_list) - true_sigma^2
variance = mean((s2_list - mean(s2_list))^2)
MSE = bias^2 + variance
cat(sprintf("******* s2 *******\nBias = %f\nVariance = %f\nMSE = %f\n", bias, variance, MSE))

