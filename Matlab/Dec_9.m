%% Generate data
n = 10;
mu = 2;
sigma = 1;
Y = zeros(n, 2);
for i = 1:n
    p = binornd(1, 1/2);
    if p >= 1/2
        Y(i, :) = [normrnd(0, 1), 1];
    end
    if p < 1/2
        Y(i, :) = [normrnd(mu, sigma), 2];
    end
end
Y(:, 1) = round(Y(:, 1), 2);

%% Look at data
%figure;
plot(Y((Y(:, 2) == 1), 2), Y((Y(:, 2) == 1), 1), 'r.');
hold on;
plot(Y((Y(:, 2) == 2), 2), Y((Y(:, 2) == 2), 1), 'b.');
xlim([0, 3])
hold off;

%% Fit a model that clusters first and then estimates mu and sigma
labels = kmeans(Y, 2);
[m, argmin] = min(Y(:, 1));
if labels(argmin) == 2
    labels = 3 - labels;
end
Y_1 = Y(labels == 1, :);
Y_2 = Y(labels == 2, :);
%figure;
plot(Y_1(:,2), Y_1(:,1), 'r.');
hold on;
plot(Y_2(:,2), Y_2(:,1), 'b.');
xlim([0, 3])
hold off;
mu_hat = mean(Y_2(:, 1));
sigma_hat = std(Y_2(:, 1));
fprintf("mu_hat = %.3f, sigma_hat = %.3f\n", mu_hat, sigma_hat)


%% Use a likelihood based method (with and without bayesian approach)
mu_range = -5:.01:5;
strt_sigma = .0000001;
sigma_range = strt_sigma:.01:3;
ll = zeros(length(sigma_range), length(mu_range));
for i = 1:length(mu_range)
    curr_mu = mu_range(i);
    curr_mu = round(curr_mu, 2);
    for j = 1:length(sigma_range)    
        curr_sigma = sigma_range(j);
        for k = 1:n
            y = Y(k, 1); 
            ll(j, i) = ll(j, i) + log(1/2*normpdf(y, 0, 1) + 1/2*normpdf(y, curr_mu, curr_sigma));
        end
        ll(j, i) = ll(j, i) + log(normpdf(curr_mu, 0, 3)) + log(gampdf(curr_sigma^2, 2, 1));
    end
end
% Look at the likelihood computed for different mu and sigma's
figure;
imagesc(mu_range, sigma_range, ll);
colorbar();

[sigma_hat_ind, mu_hat_ind] = find(ll == max(max(ll)));
sigma_hat = sigma_range(sigma_hat_ind)
mu_hat = mu_range(mu_hat_ind)

%% Look at priors for sigma
sigma_prior = zeros(size(sigma_range));
for j = 1:length(sigma_range)
    curr_sigma = sigma_range(j);
    sigma_prior(j) = gampdf(curr_sigma^2, 2, 1);
end
plot(sigma_range, sigma_prior)

%% Look at priors for mu
mu_prior = zeros(size(mu_range));
for j = 1:length(mu_range)
    curr_mu = mu_range(j);
    mu_prior(j) = normpdf(curr_mu, 0, 3);
end
plot(mu_range, mu_prior)








