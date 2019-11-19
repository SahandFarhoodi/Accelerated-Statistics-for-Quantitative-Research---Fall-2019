#install.packages("astsa")
#library(help="astsa")
library(astsa)
austres
plot(austres, xlab="Year", ylab="Residents")
d_austres <- diff(log(austres))
plot(d_austres, xlab="yearh", ylab="difference in number of residents")
mod <- arima(d_austres, order=c(1,0,0))
mod
mod$aic

plot(d_austres, xlab="yearh", ylab="difference in number of residents", ylim=c(0, 0.006))
par(new=TRUE)
plot(d_austres + mod$residuals, ylim=c(0, 0.006), col="red")

acf(d_austres)
pacf(d_austres)

### Oscillation 
p <- 2
n <- 100
X_ar = rep(0, n)
X_ar[1:p] = c(1, -1)
phi <- c(.5, -.5) # exponential decay
for (t in 1:length(X_ar)){
  if (X_ar[t] == 0){
    X_ar[t] = t(phi)%*%X_ar[(t-p):(t-1)] + rnorm(1, 0, .5);
  }
}
plot(X_ar, type='l')
mod <- arima(X_ar, order=c(3,0,0))
plot(X_ar, ylim=c(-7, 7), type='l')
par(new=TRUE)
plot(X_ar + mod$residuals, ylim=c(-7, 7), col="red", type='l')
acf(X_ar)
pacf(X_ar)

# Exponential decay
p <- 4
n <- 100
X_ar = rep(0, n)
X_ar[1:p] = c(3, -3)
phi <- c(-.5, -.1, -.1, .4) # exponential increasing
for (t in 1:length(X_ar)){
  if (X_ar[t] == 0){
    X_ar[t] = t(phi)%*%X_ar[(t-p):(t-1)] + rnorm(1, 0, .05);
  }
}
plot(X_ar, type='l')
mod <- arima(X_ar, order=c(5,0,0))
plot(X_ar, ylim=c(-4, 4), type='l')
par(new=TRUE)
plot(X_ar + mod$residuals, ylim=c(-4, 4), col="red", type='l')

acf(X_ar)
pacf(X_ar)

# Exponential increasing
p <- 5
n <- 100
X_ar = rep(0, n)
X_ar[1:p] = c(3, -3)
phi <- c(-.5, .7, -.2, .3, .4) # exponential increasing
for (t in 1:length(X_ar)){
  if (X_ar[t] == 0){
    X_ar[t] = t(phi)%*%X_ar[(t-p):(t-1)] + rnorm(1, 0, .05);
  }
}
plot(X_ar, type='l')
mod <- arima(X_ar, order=c(5,0,0))
plot(X_ar, ylim=c(-600, 600), type='l')
par(new=TRUE)
plot(X_ar + mod$residuals, ylim=c(-600, 600), col="red", type='l')

acf(X_ar)
pacf(X_ar)

# A combination of decay and oscillation
p <- 5
n <- 100
X_ar = rep(0, n)
X_ar[1:p] = c(3, -3)
phi <- c(-.5, -.1, -.1, .5, .4)
for (t in 1:length(X_ar)){
  if (X_ar[t] == 0){
    X_ar[t] = t(phi)%*%X_ar[(t-p):(t-1)] + rnorm(1, 0, .05);
  }
}
plot(X_ar, type='l')
mod <- arima(X_ar, order=c(11,0,0))
plot(X_ar, ylim=c(-4, 4), type='l')
par(new=TRUE)
plot(X_ar + mod$residuals, ylim=c(-4, 4), col="red", type='l')
acf(X_ar)
pacf(X_ar)


