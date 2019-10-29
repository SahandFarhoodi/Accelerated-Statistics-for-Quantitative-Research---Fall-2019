#### Linear model extended version - quadratic
n <- 100
X <- 5*matrix(runif(n), n, 1, byrow=TRUE)
Y <- 3 + 2*X + 4*X^2 + matrix(rnorm(n, 0, 2), n, 1, byrow=TRUE)
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

#### Model Selection
# Generating Data
n <- 100
X <- 2*pi*matrix(runif(n)-1/2, n, 1, byrow=TRUE)
Y <- 1 + 2*X + 4*sin(X) - 2*cos(X) + matrix(rnorm(n, 0, 1), n, 1, byrow=TRUE)
plot(X, Y, cex=.4)

Performance <- data.frame(matrix(NA, nrow = 4, ncol = 5))
colnames(Performance) = c("1+X", "1+X+cos(X)", "1+X+sin(X)", "1+X+sin(X)+cos(X)", "1+X+X^2+sin(X)+cos(X)")
rownames(Performance) = c("RSS", "AIC", "BIC", "Cross-valid")

# Fitting linear model
X_des <- cbind(matrix(rep(1, n), n, 1, byrow=TRUE), X)
b_hat <- solve(t(X_des) %*% X_des) %*% t(X_des) %*% Y
Y_hat <- X_des %*% b_hat
plot(X, Y, cex=.4, ylab="", ylim=range(-12, 13))
par(new=TRUE)
plot(X, Y_hat, cex=.4, ylab="Y", ylim=range(-12, 13), title("Y ~ 1 + X"), col='red')
# Computing leave-one-out cross validation error
cross_val_1 <- 0
for (i in 1:n){
  X_des_new <- X_des[-i,]
  Y_new <- Y[-i]
  b_hat <- solve(t(X_des_new) %*% X_des_new) %*% t(X_des_new) %*% Y_new
  y_hat <- X_des[i,] %*% b_hat
  #print(cross_val_1)
  print((Y[i] - y_hat)^2)
  cross_val_1 = cross_val_1 + (Y[i] - y_hat)^2
  #print(length(cross_val_1))
}
RSS <- sum((Y - Y_hat)^2)
AIC <- -sum((Y - Y_hat)^2) - length(b_hat)
BIC <- -sum((Y - Y_hat)^2) - length(b_hat)/2*log(n)
Performance[,1] = c(RSS, AIC, BIC, cross_val_1)

# Fitting extended model with cos(X)
X_des <- cbind(matrix(rep(1, n), n, 1, byrow=TRUE), X, cos(X))
b_hat <- solve(t(X_des) %*% X_des) %*% t(X_des) %*% Y
Y_hat <- X_des %*% b_hat
plot(X, Y, cex=.4, ylab="", ylim=range(-12, 13))
par(new=TRUE)
plot(X, Y_hat, cex=.4, ylab="Y", ylim=range(-12, 13), title("Y ~ 1 + X"), col='red')
# Computing leave-one-out cross validation error
cross_val_1 <- 0
for (i in 1:n){
  X_des_new <- X_des[-i,]
  Y_new <- Y[-i]
  b_hat <- solve(t(X_des_new) %*% X_des_new) %*% t(X_des_new) %*% Y_new
  y_hat <- X_des[i,] %*% b_hat
  #print(cross_val_1)
  print((Y[i] - y_hat)^2)
  cross_val_1 = cross_val_1 + (Y[i] - y_hat)^2
  #print(length(cross_val_1))
}
RSS <- sum((Y - Y_hat)^2)
AIC <- -sum((Y - Y_hat)^2) - length(b_hat)
BIC <- -sum((Y - Y_hat)^2) - length(b_hat)/2*log(n)
Performance[,2] = c(RSS, AIC, BIC, cross_val_1)

# Fitting extended model with sin(X)
X_des <- cbind(matrix(rep(1, n), n, 1, byrow=TRUE), X, sin(X))
b_hat <- solve(t(X_des) %*% X_des) %*% t(X_des) %*% Y
Y_hat <- X_des %*% b_hat
plot(X, Y, cex=.4, ylab="", ylim=range(-12, 13))
par(new=TRUE)
plot(X, Y_hat, cex=.4, ylab="Y", ylim=range(-12, 13), title("Y ~ 1 + X"), col='red')
# Computing leave-one-out cross validation error
cross_val_1 <- 0
for (i in 1:n){
  X_des_new <- X_des[-i,]
  Y_new <- Y[-i]
  b_hat <- solve(t(X_des_new) %*% X_des_new) %*% t(X_des_new) %*% Y_new
  y_hat <- X_des[i,] %*% b_hat
  #print(cross_val_1)
  print((Y[i] - y_hat)^2)
  cross_val_1 = cross_val_1 + (Y[i] - y_hat)^2
  #print(length(cross_val_1))
}
RSS <- sum((Y - Y_hat)^2)
AIC <- -sum((Y - Y_hat)^2) - length(b_hat)
BIC <- -sum((Y - Y_hat)^2) - length(b_hat)/2*log(n)
Performance[,3] = c(RSS, AIC, BIC, cross_val_1)

# Fitting extended model with cos(X) and sin(X)
X_des <- cbind(matrix(rep(1, n), n, 1, byrow=TRUE), X, cos(X), sin(X))
b_hat <- solve(t(X_des) %*% X_des) %*% t(X_des) %*% Y
Y_hat <- X_des %*% b_hat
plot(X, Y, cex=.4, ylab="", ylim=range(-12, 13))
par(new=TRUE)
plot(X, Y_hat, cex=.4, ylab="Y", ylim=range(-12, 13), title("Y ~ 1 + X"), col='red')
# Computing leave-one-out cross validation error
cross_val_1 <- 0
for (i in 1:n){
  X_des_new <- X_des[-i,]
  Y_new <- Y[-i]
  b_hat <- solve(t(X_des_new) %*% X_des_new) %*% t(X_des_new) %*% Y_new
  y_hat <- X_des[i,] %*% b_hat
  #print(cross_val_1)
  print((Y[i] - y_hat)^2)
  cross_val_1 = cross_val_1 + (Y[i] - y_hat)^2
  #print(length(cross_val_1))
}
RSS <- sum((Y - Y_hat)^2)
AIC <- -sum((Y - Y_hat)^2) - length(b_hat)
BIC <- -sum((Y - Y_hat)^2) - length(b_hat)/2*log(n)
Performance[,4] = c(RSS, AIC, BIC, cross_val_1)

# Fitting extended model with cos(X) and sin(X) and X^2
X_des <- cbind(matrix(rep(1, n), n, 1, byrow=TRUE), X, X^2, cos(X), sin(X))
b_hat <- solve(t(X_des) %*% X_des) %*% t(X_des) %*% Y
Y_hat <- X_des %*% b_hat
plot(X, Y, cex=.4, ylab="", ylim=range(-12, 13))
par(new=TRUE)
plot(X, Y_hat, cex=.4, ylab="Y", ylim=range(-12, 13), title("Y ~ 1 + X"), col='red')
# Computing leave-one-out cross validation error
cross_val_1 <- 0
for (i in 1:n){
  X_des_new <- X_des[-i,]
  Y_new <- Y[-i]
  b_hat <- solve(t(X_des_new) %*% X_des_new) %*% t(X_des_new) %*% Y_new
  y_hat <- X_des[i,] %*% b_hat
  #print(cross_val_1)
  print((Y[i] - y_hat)^2)
  cross_val_1 = cross_val_1 + (Y[i] - y_hat)^2
  #print(length(cross_val_1))
}
RSS <- sum((Y - Y_hat)^2)
AIC <- -sum((Y - Y_hat)^2) - length(b_hat)
BIC <- -sum((Y - Y_hat)^2) - length(b_hat)/2*log(n)
Performance[,5] = c(RSS, AIC, BIC, cross_val_1)

### Forward stepwise regression will choose models as follows:
# Y ~ 1
# Y ~ 1 + X
# Y ~ 1 + X + sin(X)
# Y ~ 1 + X + sin(X) + cos(X)
# Stop

### backward stepwise regression will choose models as follows:
# Y ~ 1 + X + X^2 + sin(X) + cos(X) 
# Y ~ 1 + X + sin(X) + cos(X)
# Stop


