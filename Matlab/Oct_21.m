% Linear Model Testing
n = 1000;
k = 15;
b = [2; 1; 2; -.1*ones(k, 1)];
p = size(b, 1); % number of predictors
X = rand(n, k+2);
X = [ones(size(X, 1), 1), X];
Y = X*b + normrnd(0, .5, n, 1);

% Do you see any linear pattern below?
plot(X(:, 2), Y, '.'); % Y versus x2
plot(X(:, 3), Y, '.'); % Y versus x3
plot(X(:, 4), Y, '.'); % Y versus x4

% Fitting linear model manually
b_hat = (X'*X)\X'*Y;
Y_hat = X*b_hat;
RSS = sum((Y - Y_hat).^2);
sigma_hat = sqrt(RSS/(n-(p+1)));
Cov_b_hat = inv(X'*X)*(sigma_hat^2);
se_b_hat = sqrt(diag(Cov_b_hat));

% Single Hypothesis Testing (Wald Tests)
% H0: b=0  vs  H1: b!=0
p_values = 1-normcdf(abs(b_hat)./se_b_hat);

% F test (MLRT method)
% H0: Y = b0 + x1*b1  vs. Y = b0 + x1*b1 + x2*b2 + ... + xk*bk
RSS1 = RSS;
d1 = n-(p+1);
% Fitting the model in H0
X_new = X(:, 1:3);
b_hat_new = (X_new'*X_new)\X_new'*Y;
p_new = size(b_hat_new, 1);
Y_hat_new = X_new*b_hat_new;
RSS0 = sum((Y - Y_hat_new).^2);
d0 = n - (p_new+1);
% Computing F p-value
F = ((RSS0 - RSS1)/(d0-d1))/(RSS1/d1);
p_value_new = 1-fcdf(F, d0-d1, d1);

% Results:
p_values
p_value_new






