### Logistic regression with a linear boundary
# Generate data
n <- 1000
x1 <- 8*(matrix(runif(n), n, 1, byrow=TRUE) - 1/2) + matrix(rnorm(n, 0, 2), n, 1, byrow=TRUE)
x2 <- 6*(matrix(runif(n), n, 1, byrow=TRUE) - 1/2) + 1 + matrix(rnorm(n, 0, 2), n, 1, byrow=TRUE)
Y = rep(0, n);
for (i in 1:n){
  x = 3 + 2*x1[i] + (-1)*x2[i] + rnorm(1, 0, 3)
  if (x >= 0){
    Y[i] = 0
  }
  if (x < 0){
    Y[i] = 1
  }
}
class1 = which(Y==0)
class2 = which(Y==1)
# Looking at y versus x1
plot(x1, Y, cex = .2, ylim = c(-0.3, 1.3))
# Looking at y versus x2
plot(x2, Y, cex = .2, ylim = c(-0.3, 1.3))
# Looking at x1 versus x2
plot(x1, x2, cex = .2)
# Looking at y versus x1 and x2
plot(x1, x2, col=2+Y, cex=.2)

# Fit a logistic regression
Data <- as.data.frame(cbind(x1, x2, Y))
colnames(Data) <- c("X1", "X2", "Y")
log_model <- glm(Y ~., family=binomial(link='logit'), data=Data)
summary(log_model)
b <- log_model$coefficients
# Looking at the fitted separable line
plot(x1, x2, col=2+Y, cex=.2, ylim=c(-8, 10), xlim=c(-10, 10), xlab="x1", ylab="x2")
par(new=TRUE)
seq = seq(-6, 6, .01)
plot(seq, -b[1]/b[3] - b[2]/b[3]*seq, cex=.1, col='black', , ylim=c(-8, 10), xlim=c(-10, 10), xlab="", ylab="")

### Logistic regression with a quadratic boundary
n <- 1000
x1 <- 8*(matrix(runif(n), n, 1, byrow=TRUE) - 1/2) + matrix(rnorm(n, 0, 2), n, 1, byrow=TRUE)
x2 <- 6*(matrix(runif(n), n, 1, byrow=TRUE) - 1/2) + 1 + matrix(rnorm(n, 0, 2), n, 1, byrow=TRUE)
Y = rep(0, n);
for (i in 1:n){
  x = 3 + (-4)*x1[i] + x1[i]^2 + (-1)*x2[i] + rnorm(1, 0, 1)
  if (x >= 0){
    Y[i] = 0
  }
  if (x < 0){
    Y[i] = 1
  }
}
class1 = which(Y==0)
class2 = which(Y==1)
# Looking at y versus x1
plot(x1, Y, cex = .2, ylim = c(-0.3, 1.3))
# Looking at y versus x2
plot(x2, Y, cex = .2, ylim = c(-0.3, 1.3))
# Looking at x1 versus x2
plot(x1, x2, cex = .2)
# Looking at y versus x1 and x2
plot(x1, x2, col=2+Y, cex=.2)

# Fit a logistic regression
Data <- as.data.frame(cbind(x1, x2, Y))
colnames(Data) <- c("X1", "X2", "Y")
log_model <- glm(Y ~., family=binomial(link='logit'), data=Data)
summary(log_model)
b <- log_model$coefficients
# Looking at the fitted separable line
plot(x1, x2, col=2+Y, cex=.2, ylim=c(-8, 10), xlim=c(-10, 10), xlab="x1", ylab="x2")
par(new=TRUE)
seq = seq(-6, 6, .01)
plot(seq, -b[1]/b[3] - b[2]/b[3]*seq, cex=.1, col='black', , ylim=c(-8, 10), xlim=c(-10, 10), xlab="", ylab="")

# Fit a logistic regression with quadratic terms
Data <- as.data.frame(cbind(x1, x1^2, x2, Y))
colnames(Data) <- c("X1", "X1^2", "X2", "Y")
log_model <- glm(Y ~., family=binomial(link='logit'), data=Data)
summary(log_model)
b <- log_model$coefficients
summary(b)
# Looking at the fitted separable line
plot(x1, x2, col=2+Y, cex=.2, ylim=c(-8, 10), xlim=c(-10, 10), , xlab="x1", ylab="x2")
par(new=TRUE)
seq = seq(-6, 6, .01)
plot(seq, -b[1]/b[4] - b[2]/b[4]*seq - b[3]/b[4]*seq^2, cex=.1, col='black', ylim=c(-8, 10), xlim=c(-10, 10), xlab="", ylab="")






