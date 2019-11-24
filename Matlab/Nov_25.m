%% Generate Data: Time Series
T = 100;
X = 1:1:T;
%Y = 3*sin(2*pi*X/T);
Y = (X-10) .* (X-40).^(2) .* (X-70) .* (X-90) .* (X+5).^(1/2)/10^6 + normrnd(0, abs(X-50)*4, size(X));
Y_nonoise = (X-10) .* (X-40).^(2) .* (X-70) .* (X-90) .* (X+5).^(1/2)/10^6;
figure;
plot(X, Y);
hold on;
plot(X, Y_nonoise);
hold off;


%% Find coefficients of fourier transforms
[Y_hat, a, b] = compute_y_hat(X, Y, T, 6);
figure;
plot(X, Y);
hold on;
plot(X, Y_hat)
hold off;
legend('Data', 'Estimation')

%% Spectral Analysis
plot(1/2*(a.^2 + b.^2))
xlabel('freq')
ylabel('variance explained')
title('Spectral Analysis')

%% Using test data to verify results
T = 100;
X_test = 1:1:T;
%Y = 3*sin(2*pi*X/T);
Y_test = (X_test-10) .* (X_test-40).^(2) .* (X_test-70) .* (X_test-90) .* (X_test+5).^(1/2)/10^6 + normrnd(0, abs(X_test-50)*4, size(X_test));
plot(X, Y_test);
hold on;
plot(X, Y_hat)
hold off;
legend('Test Data', 'Estimation')

%% Fit using just onf of sine/cosine functions
T = 100;
X = 1:1:T;
Y = 3*cos(2*pi*X/T) + 5*sin(4*pi*X/T);

% Just cosine
X_des = [ones(size(X'))];
K = 90;
for k = 1:K
    X_des(:, k+1) = cos(2*pi*k*X/T);
end

% Just sine
X_des = [ones(size(X'))];
K = 90;
for k = 1:K
    X_des(:, k+1) = sin(2*pi*k*X/T);
end

% Both sine and cosine
X_des = [ones(size(X'))];
K = 90;
for k = 1:K
    X_des(:, 2*k-1) = sin(2*pi*k*X/T);
    X_des(:, 2*k) = cos(2*pi*k*X/T);
end

beta = (X_des'*X_des)\X_des'*Y';
Y_hat = X_des*beta;
plot(X, Y);
hold on;
plot(X, Y_hat)
hold off;
legend('Data', 'Estimation')

%% Functions
function [out1, out2] = compute_fourier_coeff(X, Y, T, k)
    out1 = 2/T*sum(Y.*sin(2*pi*k*X/T));
    out2 = 2/T*sum(Y.*cos(2*pi*k*X/T));
end

function [Y_hat, a, b] = compute_y_hat(X, Y, T, K)
    Y_hat = 1/T*sum(Y) * ones(size(X));
    a = zeros(K, 1);
    b = zeros(K, 1);
    for k = 1:K
        [ak, bk] = compute_fourier_coeff(X, Y, T, k);
        a(k) = ak;
        b(k) = bk;
        Y_hat = Y_hat + ak*sin(2*pi*k*X/T) + bk*cos(2*pi*k*X/T);
    end
end


