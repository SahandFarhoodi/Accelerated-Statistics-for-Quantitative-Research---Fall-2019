%% Simple Example
X = (0:.001:4)';
n = size(X, 1);
Y = gamrnd(9, 4-(X-2).^2) + normrnd(0, 2, n, 1) + 10;
%Y = normrnd(4-(X-2).^2, 1) + normrnd(0, 2, n, 1) + 10;
plot(X, Y, '.');
title('Data');
design_mat = [ones(size(X, 1), 1), X, X.^2];
p = size(design_mat, 2);

% Fitting a Gamma GLM
[b_gamma, dev_gamma, stats_gamma] = glmfit(design_mat, Y, 'gamma', 'link', 'identity', 'constant', 'off');
mu_hat_gamma = design_mat*b_gamma;
figure;
plot(X, Y, '.');
hold on;
plot(X, mu_hat_gamma, 'LineWidth', 2);
title('Gamma model');
hold off;

% Fitting a Normal GLM
[b_normal, dev_normal, stats_normal] = glmfit(design_mat, Y, 'normal', 'constant', 'off');
mu_hat_normal = design_mat*b_normal;
figure;
plot(X, Y, '.');
hold on;
plot(X, mu_hat_normal, 'LineWidth', 2);
title('Normal model');
hold off;

% Constructing the CI's for observations
% Normal model
Y_hat = design_mat*b_normal;
sigma_hat = sqrt((sum((Y-Y_hat).^2))/(n-p));
figure;
plot(X, Y, '.');
hold on;
plot(X, mu_hat_normal, 'LineWidth', 2);
plot(X, mu_hat_normal + 1.96*sigma_hat, 'LineWidth', 2);
plot(X, mu_hat_normal - 1.96*sigma_hat, 'LineWidth', 2);
title('Normal model');
hold off;

% Gamma model
v = (6+2*dev_gamma/n)/(dev_gamma/n*(6+dev_gamma/n));
sigma_hat = sqrt(mu_hat_gamma.^2/v);
figure;
plot(X, Y, '.');
hold on;
plot(X, mu_hat_gamma, 'LineWidth', 2);
plot(X, mu_hat_gamma + 1.96*sigma_hat, 'LineWidth', 2);
plot(X, mu_hat_gamma - 1.96*sigma_hat, 'LineWidth', 2);
title('Gamma model');
hold off;

%% More Complicated Example
X = (0:.001:4)';
n = size(X, 1);
%Y = sin(3*X) + normrnd(0, 1, n, 1) + 10;
Y = sin(3*X) + normrnd(0, sin(3*X)/10 + .1, n, 1) + 3;
plot(X, Y, '.');
title('Data');
design_mat = [ones(size(X, 1), 1), X, X.^2, X.^3, X.^4, X.^5, X.^6, X.^7];
p = size(design_mat, 2);

% Fitting a Gamma GLM
[b_gamma, dev_gamma, stats_gamma] = glmfit(design_mat, Y, 'gamma', 'link', 'identity', 'constant', 'off');
mu_hat_gamma = design_mat*b_gamma;
figure;
plot(X, Y, '.');
hold on;
plot(X, mu_hat_gamma, 'LineWidth', 2);
title('Gamma model');
hold off;

% Fitting a Normal GLM
[b_normal, dev_normal, stats_normal] = glmfit(design_mat, Y, 'normal', 'constant', 'off');
mu_hat_normal = design_mat*b_normal;
figure;
plot(X, Y, '.');
hold on;
plot(X, mu_hat_normal, 'LineWidth', 2);
title('Normal model');
hold off;
 
% Constructing the CI's for observations
% Normal model
Y_hat = design_mat*b_normal;
sigma_hat = sqrt((sum((Y-Y_hat).^2))/(n-p));
figure;
plot(X, Y, '.');
hold on;
plot(X, mu_hat_normal, 'LineWidth', 2);
plot(X, mu_hat_normal + 1.96*sigma_hat, 'LineWidth', 2);
plot(X, mu_hat_normal - 1.96*sigma_hat, 'LineWidth', 2);
title('Normal model');
hold off;

% Gamma model
Y_hat = design_mat*b_normal;
v = (6+2*dev_gamma/n)/(dev_gamma/n*(6+dev_gamma/n));
sigma_hat = sqrt(mu_hat_gamma.^2/v);
figure;
plot(X, Y, '.');
hold on;
plot(X, mu_hat_gamma, 'LineWidth', 2);
plot(X, mu_hat_gamma + 1.96*sigma_hat, 'LineWidth', 2);
plot(X, mu_hat_gamma - 1.96*sigma_hat, 'LineWidth', 2);
title('Gamma model');
hold off;


