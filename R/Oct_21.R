##### Linear Model Testing (alpha = 0.01)
n <- 1000;
k <- 15;
b <- matrix(c(2, 1, 2, rep(-.1, k)), k+3, 1, byrow = TRUE)
p <- dim(b)[1]
X <- matrix(runif(n*(k+2)), n, k+2, byrow=TRUE)
X <- cbind(matrix(rep(1, n), n, 1, byrow=TRUE), X)
Y <- X%*%b + matrix(rnorm(n, 0, .5), n, 1, byrow=TRUE)

# Do you see any linear pattern below?
plot(X[,2], Y, cex=.4)
plot(X[,3], Y, cex=.4)
plot(X[,4], Y, cex=.4)

# Fitting linear model manually
b_hat <- solve(t(X) %*% X) %*% t(X) %*% Y
Y_hat <- X %*% b_hat
RSS <- sum((Y_hat - Y)^2)
sigma_hat <- sqrt(RSS/(n-(p+1)))
Cov_b_hat <- solve(t(X) %*% X) * (sigma_hat^2)
se_b_hat <- sqrt(diag(Cov_b_hat))

# Single Hypothesis Testing (Wald Tests)
# H0: b=0  vs  H1: b!=0
p_values <- 1-pnorm(abs(b_hat)/se_b_hat)

# F test (MLRT method)
# H0: Y = b0 + x1*b1  vs. Y = b0 + x1*b1 + x2*b2 + ... + xk*bk
RSS1 <- RSS
d1 <- n - (p+1)

# Fitting the model in H0
X_new <- X[, 1:3]
b_hat_new <- solve(t(X_new) %*% X_new) %*% t(X_new) %*% Y
p_new <- dim(b_hat_new)[1]
Y_hat_new <- X_new %*% b_hat_new
RSS0 <- sum((Y_hat_new - Y)^2)
d0 = n - (p_new+1)

# Compute F p-value
F <- ((RSS0 - RSS1)/(d0-d1))/(RSS1/d1)
p_value_new <- 1-pf(F, d0-d1, d1)
print(p_values)
print(p_value_new)

##### Extended version Linear Models
n <- 100
X <- 5*matrix(runif(n), n, 1, byrow=TRUE)
Y <- 3 + 2*X + 4*X^2 + matrix(rnorm(n, 0, .5), n, 1, byrow=TRUE)
plot(X, Y, cex=.4)

# Fitting linear model manually
X_des <- cbind(matrix(rep(1, n), n, 1, byrow=TRUE), X)
b_hat <- solve(t(X_des) %*% X_des) %*% t(X_des) %*% Y
Y_hat <- X_des %*% b_hat
plot(X, Y, cex=.4, ylim=range(-20, 120),)
par(new=TRUE)
plot(X, Y_hat, cex=.4, col='red', ylim=range(-20, 120))

# Use extended version
X_des <- cbind(matrix(rep(1, n), n, 1, byrow=TRUE), X, X^2)
b_hat <- solve(t(X_des) %*% X_des) %*% t(X_des) %*% Y
Y_hat <- X_des %*% b_hat
plot(X, Y, cex=.4, ylim=range(-20, 120), ylab="")
par(new=TRUE)
plot(X, Y_hat, cex=.4, col='red', ylim=range(-20, 120))

