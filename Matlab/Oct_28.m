%% Linear model extended version -- quadratic
n = 100;
X = 5*rand(n, 1);
Y = 3 + 2*X + 4*X.^2 + normrnd(0, 1, n, 1);
plot(X, Y, '.');

% Fitting linear model manually
X_des = [ones(size(X, 1), 1), X];
b_hat = (X_des'*X_des)\X_des'*Y;
Y_hat = X_des*b_hat;
figure;
plot(X, Y, '.'); hold on; plot(X, Y_hat, '.'); hold off;
legend('true values', 'estimated values');

% Use extended version
X_des = [ones(size(X, 1), 1), X, X.^2];
b_hat = (X_des'*X_des)\X_des'*Y;
Y_hat = X_des*b_hat;
figure;
plot(X, Y, '.'); hold on; plot(X, Y_hat, '.'); hold off;
legend('true values', 'estimated values');

%% Model Selection
%Generating Data 
n = 100;
X = 2*pi*(rand(n, 1)-1/2);
Y = 1 + 2*X + 4*sin(X) -2*cos(X)+normrnd(0, 1, n, 1);
plot(X, Y, '.');

%% Fitting linear model
fprintf("Model: Y ~ 1 + X\n")
X_des = [ones(size(X, 1), 1), X];
b_hat = (X_des'*X_des)\X_des'*Y;
Y_hat = X_des*b_hat;
figure;
plot(X, Y, '.'); hold on; plot(X, Y_hat, '.'); hold off;
legend('true values', 'estimated values');
title('Y ~ 1 + X')
% Computing leave-one-out cross validation error
cross_val_1 = 0;
for i = 1:n
    X_des_new = X_des;
    X_des_new(i, :) = [];
    Y_new = Y;
    Y_new(i) = [];
    b_hat = (X_des_new'*X_des_new)\X_des_new'*Y_new;
    y_hat = X_des(i, :) * b_hat;
    cross_val_1 = cross_val_1 + (Y(i) - y_hat)^2;
end
fprintf("RSS = %.3f\n", sum((Y-Y_hat).^2))
fprintf("AIC = %.3f\n", -sum((Y-Y_hat).^2)-size(b_hat, 1))
fprintf("BIC = %.3f\n", -sum((Y-Y_hat).^2)-size(b_hat, 1)/2*log(n))
fprintf("Leave-one-out error = %.3f\n", cross_val_1)

%% Fitting extended model with cos(X)
fprintf("Model: Y ~ 1 +  X + cos(X)\n")
X_des = [ones(size(X, 1), 1), X, cos(X)];
b_hat = (X_des'*X_des)\X_des'*Y;
Y_hat = X_des*b_hat;
figure;
plot(X, Y, '.'); hold on; plot(X, Y_hat, '.'); hold off;
legend('true values', 'estimated values');
title('Y ~ 1 + X + cos(X)')
% Computing leave-one-out cross validation error
cross_val_1 = 0;
for i = 1:n
    X_des_new = X_des;
    X_des_new(i, :) = [];
    Y_new = Y;
    Y_new(i) = [];
    b_hat = (X_des_new'*X_des_new)\X_des_new'*Y_new;
    y_hat = X_des(i, :) * b_hat;
    cross_val_1 = cross_val_1 + (Y(i) - y_hat)^2;
end
fprintf("RSS = %.3f\n", sum((Y-Y_hat).^2))
fprintf("AIC = %.3f\n", -sum((Y-Y_hat).^2)-size(b_hat, 1))
fprintf("BIC = %.3f\n", -sum((Y-Y_hat).^2)-size(b_hat, 1)/2*log(n))
fprintf("Leave-one-out error = %.3f\n", cross_val_1)

%% Fitting extended model with sin(X)
fprintf("Model: Y ~ 1 + X + sin(X)\n")
X_des = [ones(size(X, 1), 1), X, sin(X)];
b_hat = (X_des'*X_des)\X_des'*Y;
Y_hat = X_des*b_hat;
figure;
plot(X, Y, '.'); hold on; plot(X, Y_hat, '.'); hold off;
legend('true values', 'estimated values');
title('Y ~ 1 + X + sin(X)')
% Computing leave-one-out cross validation error
cross_val_1 = 0;
for i = 1:n
    X_des_new = X_des;
    X_des_new(i, :) = [];
    Y_new = Y;
    Y_new(i) = [];
    b_hat = (X_des_new'*X_des_new)\X_des_new'*Y_new;
    y_hat = X_des(i, :) * b_hat;
    cross_val_1 = cross_val_1 + (Y(i) - y_hat)^2;
end
fprintf("RSS = %.3f\n", sum((Y-Y_hat).^2))
fprintf("AIC = %.3f\n", -sum((Y-Y_hat).^2)-size(b_hat, 1))
fprintf("BIC = %.3f\n", -sum((Y-Y_hat).^2)-size(b_hat, 1)/2*log(n))
fprintf("Leave-one-out error = %.3f\n", cross_val_1)

%% Fitting extended model with both sin(X) and cos(X)
fprintf("Model: Y ~ 1 + X + sin(X) + cos(X)\n")
X_des = [ones(size(X, 1), 1), X, sin(X), cos(X)];
b_hat = (X_des'*X_des)\X_des'*Y;
Y_hat = X_des*b_hat;
figure;
plot(X, Y, '.'); hold on; plot(X, Y_hat, '.'); hold off;
legend('true values', 'estimated values');
title('Y ~ 1 + X + sin(X) + cos(X)')
% Computing leave-one-out cross validation error
cross_val_1 = 0;
for i = 1:n
    X_des_new = X_des;
    X_des_new(i, :) = [];
    Y_new = Y;
    Y_new(i) = [];
    b_hat = (X_des_new'*X_des_new)\X_des_new'*Y_new;
    y_hat = X_des(i, :) * b_hat;
    cross_val_1 = cross_val_1 + (Y(i) - y_hat)^2;
end
fprintf("RSS = %.3f\n", sum((Y-Y_hat).^2))
fprintf("AIC = %.3f\n", -sum((Y-Y_hat).^2)-size(b_hat, 1))
fprintf("BIC = %.3f\n", -sum((Y-Y_hat).^2)-size(b_hat, 1)/2*log(n))
fprintf("Leave-one-out error = %.3f\n", cross_val_1)

%% Fitting extended model with both sin(X) and cos(X) and X^2
fprintf("Model: Y ~ 1 + X + X^2 + sin(X) + cos(X)\n")
X_des = [ones(size(X, 1), 1), X, X.^2, sin(X), cos(X)];
b_hat = (X_des'*X_des)\X_des'*Y;
Y_hat = X_des*b_hat;
figure;
plot(X, Y, '.'); hold on; plot(X, Y_hat, '.'); hold off;
legend('true values', 'estimated values');
title('Y ~ 1 + X + X^2 + sin(X) + cos(X)')
% Computing leave-one-out cross validation error
cross_val_1 = 0;
for i = 1:n
    X_des_new = X_des;
    X_des_new(i, :) = [];
    Y_new = Y;
    Y_new(i) = [];
    b_hat = (X_des_new'*X_des_new)\X_des_new'*Y_new;
    y_hat = X_des(i, :) * b_hat;
    cross_val_1 = cross_val_1 + (Y(i) - y_hat)^2;
end
fprintf("RSS = %.3f\n", sum((Y-Y_hat).^2))
fprintf("AIC = %.3f\n", -sum((Y-Y_hat).^2)-size(b_hat, 1))
fprintf("BIC = %.3f\n", -sum((Y-Y_hat).^2)-size(b_hat, 1)/2*log(n))
fprintf("Leave-one-out error = %.3f\n", cross_val_1)

% forward stepwise regression will choose models as follows:
% Y ~ 1
% Y ~ 1 + X
% Y ~ 1 + X + sin(X)
% Y ~ 1 + X + sin(X) + cos(X)
% Stop

% backward stepwise regression will choose models as follows:
% Y ~ 1 + X + X^2 + sin(X) + cos(X) 
% Y ~ 1 + X + sin(X) + cos(X)
% Stop

