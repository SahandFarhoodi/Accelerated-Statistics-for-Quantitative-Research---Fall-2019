%% CLT - IID
num = 10000;
means = zeros(1, num);
n = 100;
for k = (1:num)
  %X = randn(1, n);
  X = rand(1, n);
  means(k) = mean(X);
end
histogram(means, 20);

%% CLT - not IID
num = 10000;
means = zeros(1, num);
n = 10000;
for k = (1:num)
  %X = randn(1, n);
  X = rand(1, n);
  Y = zeros(1, n-1);
  for i = (1:n-1)
    Y(i) = X(i) + X(i+1);
  end
  means(k) = mean(Y);
end
histogram(means, 20);

%% Delta Method
num = 10000;
means = zeros(1, num);
n = 10000;
for k = (1:num)
  X = 1/exp(randn(n, 1));
  means(k) = mean(X);
end
histogram(means, 20);

%% Find the largest increasing sequence
A = [2, 3, 5, 6, 4, 7, 8, 9, 10, 20, 1, 3, 5];
best_found = 0;
curr_len = 1;
best_ind = 1
for i = 2:length(A)
    if A(i) > A(i-1)
        curr_len = curr_len + 1;
    end
    if A(i) <= A(i-1)
        curr_len = 1;
    end
    if curr_len > best_found
        best_found = curr_len;
        best_ind = i
    end
end
disp(best_found)
best_ind
disp(A(best_ind - best_found + 1: best_ind))

%% Problem 1
num = 1000;
n = 2;
theta = 5;
pi = exp(-theta);
pi_hats = zeros(num, 1);
for k = 1:num
    X = poissrnd(theta, n, 1);
    X_bar = mean(X);
    pi_hat = exp(-X_bar);
    pi_hats(k) = pi_hat;
end

Bias = mean(pi_hats) - pi
Var = mean((pi_hats - mean(pi_hats)).^2)

E = exp(-theta)*theta/(2*n)
V = exp(-2*theta)*(theta/n - theta^2/(4*n^2))

%% Problem 5
num = 100;
X = zeros(num, 1);
for k = 1:num
    p = binornd(1, 0.4);
    if p == 1
        X(k) = normrnd(3, 1);
    end
    if p == 0
        X(k) = normrnd(6, 1);
    end
end
%%
% Part (a)
binwidth = [0.1, 0.5, 0.7, 0.9, 1.2, 1.5];
for k = 1:6
    subplot(2, 3, k)
    limits = [0, max(X)+1];
    histogram(X, 'BinWidth', binwidth(k), 'BinLimits', limits)
    xlabel("h = " + string(binwidth(k)))
end

%%
% Part (b)
binwidth = 0.7;
start_point = [0, 0.05, 0.1, 0.15, 0.2, 0.25];
for k = 1:6
    subplot(2, 3, k)
    limits = [start_point(k), max(X)+1];
    histogram(X, 'BinWidth', binwidth, 'BinLimits', limits)
    xlabel("x0 = " + string(start_point(k)))
end














