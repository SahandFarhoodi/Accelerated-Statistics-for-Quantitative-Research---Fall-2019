# Generate Data
n <- 10
mu <- 2
sigma <- 1
Y <- cbind(rep(0, n), rep(0, n))
for (i in 1:n){
  p <- rbinom(1, 1, .5)
  if (p >= 1/2){
    Y[i, ] <- c(rnorm(1, 0, 1), 1)
  }
  if (p < 1/2){
    Y[i, ] <- c(rnorm(1, mu, sigma), 2)
  }
}
Y[, 1] <- round(Y[, 1], 2)

# Look at data
plot(Y[Y[, 2] == 1, 2], Y[Y[, 2] == 1, 1], cex = .3, col='red', xlim=c(0, 3), ylim=c(-2,4), xlab="class", ylab="value")
par(new=TRUE)
plot(Y[Y[, 2] == 2, 2], Y[Y[, 2] == 2, 1], cex = .3, col='blue', xlim=c(0, 3), ylim=c(-2,4), xlab="", ylab="")

# Fit a model that clusters first and then estimates mu and sigma
labels = kmeans(Y, 2);
k_means <- kmeans(Y[,1], 2)
Y_1 = Y[k_means$cluster == 1, ]
Y_2 = Y[k_means$cluster == 2, ]
if (min(Y_1[, 1]) >= min(Y_2[, 1])){
  temp <- Y_2
  Y_2 <- Y_1
  Y_1 <- temp
}
plot(rep(1, dim(Y_1)[1]), Y_1[, 1], cex = .3, col='red', xlim=c(0, 3), ylim=c(-2,4), xlab="class", ylab="value")
par(new=TRUE)
plot(rep(2, dim(Y_2)[1]), Y_2[, 1], cex = .3, col='blue', xlim=c(0, 3), ylim=c(-2,4), xlab="class", ylab="value")
mu_hat = mean(Y_2[, 1])
sigma_hat = sd(Y_2[, 1])

# Use a likelihood based method (with and without bayesian approach)
mu_range = seq(-5, 5, .01)
strt_sigma = .001
sigma_range = seq(strt_sigma, 3, .1)
ll = matrix(rep(0, length(mu_range)*length(sigma_range)), nrow = length(sigma_range))
for (i in 1:length(mu_range)){
  print(i)
  curr_mu <- mu_range[i];
  curr_mu <- round(curr_mu, 2);
  for (j in 1:length(sigma_range)){
    curr_sigma = sigma_range[j]
    for (k in 1:n){
      y <- Y[k, 1];   
      ll[j, i] <- ll[j, i] + log(1/2*dnorm(y, 0, 1) + 1/2*dnorm(y, curr_mu, curr_sigma))
    }
    ll[j, i] <- ll[j, i] + log(dnorm(curr_mu, 0, 2) + dgamma(curr_sigma^2, shape=2, scale=1))
  }
}
image(ll, xlab="mu", ylab="sigma")
hat_ind <- which(ll == max(ll), arr.ind = TRUE)
sigma_hat <- sigma_range[hat_ind[1]]
mu_hat <- mu_range[hat_ind[2]]

# Looking at priors
plot(sigma_range, dgamma(sigma_range, shape=10, scale=1/9))
plot(mu_range, dnorm(mu_range, 0, 2))





