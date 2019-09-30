# CLT - IID
num <- 10000
means <- rep(0, num)
n <- 10000
for (k in 1:num){
  #X <- rnorm(n, mean=0, sd=1)
  X <- runif(n)
  means[k] <- mean(X)
}
hist(means, breaks=20)

# CLT - Not IID
num <- 1000
means <- rep(0, num)
n = 100
for (k in 1:num){
  #X = rnorm(n, mean=0, sd=1)
  X <- runif(n)
  Y <- rep(0, n-1)
  for (i in 1:n-1){
    Y[i] <- X[i] + X[i+1]
  }
  means[k] <- mean(Y)
}
hist(means, breaks=20)

# Delta Method
num <- 1000
means <- rep(0, num)
n <- 100
for (k in 1:num){
  X <- rnorm(n, mean=3, sd=1)
  means[k] <- exp(mean(X))
}
hist(means, breaks<-20)

# Find the largest increasing sequence
A <- c(2, 3, 5, 6, 4, 7, 8, 9, 10, 20, 1, 3, 5);
best_found <- 0
curr_len <- 1
for (i in 2:length(A)){
  if (A[i] > A[i-1]){
    curr_len <- curr_len + 1; q
  }
  else{
    curr_len <- 1;
  }
  if (curr_len > best_found){
    best_found <- curr_len;
  }
}
best_found
