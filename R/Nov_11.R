###### Simple Example
X <- seq(0, 4, .001)
n = length(X)
Y = rep(0, n)
for (i in 1:n){
  Y[i] = rgamma(1, shape=9, scale = 4 - (X[i]-2)^2) + rnorm(1, mean=0, sd=2) + 10
  #Y[i] = rnorm(1, mean = 4 - (X[i]-2)^2, sd=1) + rnorm(1, mean=0, sd=2) + 10
}
Data <- as.data.frame(cbind(X, X^2, Y))
colnames(Data) = c("X", "X^2", "Y")
p = dim(Data)[2]
plot(X, Y, cex=.2)
upper_bound = max(Y)+5

# Fitting a Gamma GLM
gamma_mod <- glm(Y ~., family=Gamma(link='identity'), data=Data)
summary(gamma_mod)
plot(X, Y, cex=.2, ylim=c(0, upper_bound))
par(new=TRUE)
plot(X, gamma_mod$fitted.values, cex=.2, ylim=c(0, upper_bound), col="red", ylab="", title("Gamma model"))

# Fitting a Normal GLM
normal_mod <- glm(Y ~., family=gaussian(link='identity'), data=Data)
summary(normal_mod)
plot(X, Y, cex=.2, ylim=c(0, upper_bound))
par(new=TRUE)
plot(X, normal_mod$fitted.values, cex=.2, ylim=c(0, upper_bound), col="red", ylab="", title("Normal model"))

# Constructing the CI's for observations
# Normal model
sigma_hat = sqrt(sum((Y - normal_mod$fitted.values)^2)/(n-p))
plot(X, Y, cex=.2, ylim=c(0, upper_bound))
par(new=TRUE)
plot(X, normal_mod$fitted.values, cex=.2, ylim=c(0, upper_bound), col="red", ylab="", title("Normal model"))
par(new=TRUE)
plot(X, normal_mod$fitted.values + 1.96*sigma_hat, cex=.2, ylim=c(0, upper_bound), col="orange", ylab="")
par(new=TRUE)
plot(X, normal_mod$fitted.values - 1.96*sigma_hat, cex=.2, ylim=c(0, upper_bound), col="orange", ylab="")

# Gamma model
dev_bar = gamma_mod$deviance/n
v = (6+2*dev_bar)/(dev_bar*(6+dev_bar))
sigma_hat = sqrt(gamma_mod$fitted.values^2/v);
plot(X, Y, cex=.2, ylim=c(0, upper_bound))
par(new=TRUE)
plot(X, gamma_mod$fitted.values, cex=.2, ylim=c(0, upper_bound), col="red", ylab="", title("Gamma model"))
par(new=TRUE)
plot(X, gamma_mod$fitted.values + 1.96*sigma_hat, cex=.2, ylim=c(0, upper_bound), col="orange", ylab="")
par(new=TRUE)
plot(X, gamma_mod$fitted.values - 1.96*sigma_hat, cex=.2, ylim=c(0, upper_bound), col="orange", ylab="")

###### More Complicated Example
X <- seq(0, 4, .001)
n = length(X)
Y = rep(0, n)
for (i in 1:n){
  Y[i] =  sin(3*X[i]) + rnorm(1, mean=0, sd=sin(3*X[i])/10+.1) + 3
  #Y[i] = sin(3*X[i]) + rnorm(1, mean=0, sd=1) + 5
}
#Data <- as.data.frame(cbind(X, X^2, Y))
#Data <- as.data.frame(cbind(X, X^2, X^3, X^4, X^5, Y))
Data <- as.data.frame(cbind(X, X^2, X^3, X^4, X^5, X^6, X^7, Y))

p = dim(Data)[2]
plot(X, Y, cex=.2)
upper_bound = max(Y) + 1
lower_bound = min(Y)-1

# Fitting a Gamma GLM
gamma_mod <- glm(Y ~., family=Gamma(link='identity'), data=Data)
summary(gamma_mod)
plot(X, Y, cex=.2, ylim=c(lower_bound, upper_bound))
par(new=TRUE)
plot(X, gamma_mod$fitted.values, cex=.2, ylim=c(lower_bound, upper_bound), col="red", ylab="", title("Gamma model"))

# Fitting a Normal GLM
normal_mod <- glm(Y ~., family=gaussian(link='identity'), data=Data)
summary(normal_mod)
plot(X, Y, cex=.2, ylim=c(lower_bound, upper_bound))
par(new=TRUE)
plot(X, normal_mod$fitted.values, cex=.2, ylim=c(lower_bound, upper_bound), col="red", ylab="", title("Normal model"))

# Constructing the CI's for observations
# Normal model
sigma_hat = sqrt(sum((Y - normal_mod$fitted.values)^2)/(n-p))
plot(X, Y, cex=.2, ylim=c(lower_bound, upper_bound))
par(new=TRUE)
plot(X, normal_mod$fitted.values, cex=.2, ylim=c(lower_bound, upper_bound), col="red", ylab="", title("Normal model"))
par(new=TRUE)
plot(X, normal_mod$fitted.values + 1.96*sigma_hat, cex=.2, ylim=c(lower_bound, upper_bound), col="orange", ylab="")
par(new=TRUE)
plot(X, normal_mod$fitted.values - 1.96*sigma_hat, cex=.2, ylim=c(lower_bound, upper_bound), col="orange", ylab="")

# Gamma model
dev_bar = gamma_mod$deviance/n
v = (6+2*dev_bar)/(dev_bar*(6+dev_bar))
sigma_hat = sqrt(gamma_mod$fitted.values^2/v);
plot(X, Y, cex=.2, ylim=c(lower_bound, upper_bound))
par(new=TRUE)
plot(X, gamma_mod$fitted.values, cex=.2, ylim=c(lower_bound, upper_bound), col="red", ylab="", title("Gamma model"))
par(new=TRUE)
plot(X, gamma_mod$fitted.values + 1.96*sigma_hat, cex=.2, ylim=c(lower_bound, upper_bound), col="orange", ylab="")
par(new=TRUE)
plot(X, gamma_mod$fitted.values - 1.96*sigma_hat, cex=.2, ylim=c(lower_bound, upper_bound), col="orange", ylab="")



