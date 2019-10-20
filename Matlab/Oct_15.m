% Comparing alpha and log(1/(1-alpha))
a = (0.01:0.005:0.1);
y = log(1./(1-a));
plot(a); hold on; plot(y); hold off;

% Computing p-values for N independent hypothesis tests
N = 100;
n = 10;
alpha = 0.05;
p_values = zeros(N, 1);
for i = 1:N
    % Testing the following:
    % H0: true_lambda >= lambda0 vs. H1: true_lambda < lambda0 
    true_lambda = 1.7;
    lambda0 = 2;
    X = poissrnd(true_lambda, 1, n);
    T = (mean(X) - lambda0)/(sqrt(mean(X)/n));
    p_value = normcdf(T);
    p_values(i) = p_value;
end

% Single Test
plot(1:N, p_values, '.')
hold on;
plot(1:N, alpha*ones(N, 1))
hold off;
title('Single Tests')
xlabel('Sample')
ylabel('P-value')

% Bonferroni Test
plot(1:N, p_values, '.')
hold on;
plot(1:N, alpha/N*ones(N, 1))
hold off;
title('Bonferroni Tests')
xlabel('Sample')
ylabel('P-value')

% BH Test
[sorted_p_values, ind]= sort(p_values);
plot(1:N, sorted_p_values, '.')
hold on;
plot(1:N, alpha/N*(1:N))
hold off;
title('BH Tests')
xlabel('Sample')
ylabel('P-value')

