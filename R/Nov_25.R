##### Generate Data: Time Series
T <- 100
X <- seq(1, T, 1)
#Y <- 3*sin(2*pi*X/T)
Y <- (X-10)*(X-40)^2*(X-70)*(X-90)*(X+5)^(1/2)/10^6 + rnorm(length(X), 0, abs(X-50)*4)
Y_nonoise <- (X-10)*(X-40)^2*(X-70)*(X-90)*(X+5)^(1/2)/10^6
plot(X, Y, type='l', col='black', ylim=c(-500, 1300))
par(new=TRUE)
plot(X, Y_nonoise, type='l', col='red', ylim=c(-500, 1300), ylab="")

##### Find coefficients of fourier transforms
K = 50
output <- compute_y_hat(X, Y, T, K);
Y_hat <- output[1:T]
a <- output[(T+1):(T+K)]
b <- output[(T+K+1):(T+2*K)]
plot(X, Y, type='l', col='black', ylim=c(-500, 1300))
par(new=TRUE)
plot(X, Y_hat, type='l', col='red', ylim=c(-500, 1300), ylab="")

##### Spectral Analysis
plot(1/2*(a^2 + b^2), type='l', xlab='freq', ylab='variance explained')

##### Using test data to verify results
T <- 100
X <- seq(1, T, 1)
Y_test <- (X-10)*(X-40)^2*(X-70)*(X-90)*(X+5)^(1/2)/10^6 + rnorm(length(X), 0, abs(X-50)*4)
plot(X, Y_test, type='l', col='black', ylim=c(-500, 1300))
par(new=TRUE)
plot(X, Y_hat, type='l', col='red', ylim=c(-500, 1300), ylab="")

##### Fit using just one of sine/cosine functions
T <- 100
X <- seq(1, T, 1)
Y <- 3*cos(2*pi*X/T) + 5*sin(4*pi*X/T);
plot(X, Y, type='l', ylim=c(-10, 10))

# Just cosine
X_des <- cbind(rep(1, length(X)))
K <- 50;
for (k in 1:K){
  X_des = cbind(X_des, cos(2*pi*k*X/T))
}

# Just cosine
X_des <- cbind(rep(1, length(X)))
K <- 40;
for (k in 1:K){
  X_des = cbind(X_des, sin(2*pi*k*X/T))
}

# Both sine and cosine
X_des <- cbind(rep(1, length(X)))
K <- 4;
for (k in 1:K){
  X_des = cbind(X_des, sin(2*pi*k*X/T))
  X_des = cbind(X_des, cos(2*pi*k*X/T))
}

# Fitting the model
beta <- solve(t(X_des)%*%X_des) %*% t(X_des) %*% Y
Y_hat = X_des %*% beta
plot(X, Y, type='l', col='black', ylim=c(-10, 10))
par(new=TRUE)
plot(X, Y_hat, type='l', col='red', ylim=c(-10, 10), ylab="")

##### Functions
compute_fourier_coeff <- function(X, Y, T, k){
  out1 <- 2/T*sum(Y*sin(2*pi*k*X/T));
  out2 <- 2/T*sum(Y*cos(2*pi*k*X/T));
  c(out1, out2)
}

compute_y_hat <- function(X, Y, T, K){
  Y_hat <- 1/T*sum(Y)*rep(1, length(X))
  a = rep(0, K)
  b = rep(0, K)
  for (k in 1:K){
    coeff = compute_fourier_coeff(X, Y, T, k)
    a[k]= coeff[1]
    b[k]= coeff[2]
    Y_hat = Y_hat + a[k]*sin(2*pi*k*X/T) + b[k]*cos(2*pi*k*X/T)
  }
  c(Y_hat, a, b)
}






