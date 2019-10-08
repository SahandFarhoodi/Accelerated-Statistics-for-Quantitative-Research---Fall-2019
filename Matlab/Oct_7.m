% Generating X from poisson distribution
true_lambda = 1;
n = 10; % size of X
X = poissrnd(true_lambda, 1, n);

% Testing the following:
% H0: lambda > 2 vs. H1: lambda <= 2 
lambda0 = 2;
alpha = 0.05;
disp("**************************************");

% Using Wald test:
T = (mean(X) - lambda0)/(sqrt(mean(X)/n));
z_alpha = norminv(alpha);
p_value = normcdf(T);
if T < z_alpha
   fprintf("Wald test rejects H0,  p_value = %.3f\n", p_value)
end
if T >= z_alpha
   fprintf("Wald test does not reject H0, p_value = %.2f\n", p_value)
end

% Using Maximum Likelihood Ratio test:
l_MLE = -n * mean(X) + log(mean(X))*sum(X);
l_constrained = l_MLE;
if lambda0 > mean(X)
    l_constrained = -n * lambda0 + log(lambda0)*sum(X);
end
T = 2*(l_MLE - l_constrained);
p_value = 1-chi2cdf(T, 1);
if T > chi2inv(1-alpha, 1)
   fprintf("MLRT test rejects H0, p_value = %.5f\n", p_value);
end
if T <= chi2inv(1-alpha, 1)
   fprintf("MLRT test does not reject H0, p_value = %.3f\n", p_value);
end

% Using Bootstrap in Wald test:
B = 100;
means = zeros(B, 1);
for b = 1:B
    Y = datasample(X, n);
    means(b) = mean(Y);
end
lambda_hat = mean(means);
se_hat = std(means);
T = (lambda_hat - lambda0)/se_hat;
z_alpha = norminv(alpha);
p_value = normcdf(T);
if T < z_alpha
   fprintf("Wald test (Bootstrap) rejects H0, p_value = %.3f\n", p_value)
end
if T >= z_alpha
   fprintf("Wald test (Bootstrap) does not reject H0, p_value = %.2f\n", p_value)
end






