%% Logistic regression with a linear boundary
% Generate data
n = 1000;
X = rand(n, 2);
X(:, 1) = (X(:, 1) - 1/2)*8 + normrnd(0, 1, n, 1);
X(:, 2) = (X(:, 2) - 1/2)*6 + 1 + normrnd(0, 1, n, 1);
Y = zeros(size(X, 1), 1);
for i = 1:size(X, 1)
    x = 3 + X(i, 1)*2 + X(i, 2)*(-1) + normrnd(0, 1);
    if x >= 0
        Y(i) = 0;
    end
    if x < 0
        Y(i) = 1;
    end
end
class1 = find(Y == 0);
class2 = find(Y == 1);
% Looking at y versus x1
plot(X(:, 1), Y, '.')
ylim([-.3, 1.3])
% Looking at y versus x2
plot(X(:, 2), Y, '.')
ylim([-.3, 1.3])
% Looking at x1 versus x2
plot(X(:, 1), X(:, 2), '.')

% Looking at y versus x1 and x2
figure;
plot(X(class1, 1), X(class1, 2), 'b.')
hold on;
plot(X(class2, 1), X(class2, 2), 'r.')
hold off;

% Fit a logistic regression
one_X = [ones(size(X, 1), 1), X];
counts = ones(size(Y));
[b, dev, stats] = glmfit(one_X, [Y, counts], 'binomial', 'constant', 'off');
b
se = stats.se;
fprintf("CI for b1 = (%.3f, %.3f)\n", b(1) - 1.96*se(1), b(1) + 1.96*se(1))
fprintf("CI for b2 = (%.3f, %.3f)\n", b(2) - 1.96*se(2), b(2) + 1.96*se(2))
fprintf("CI for b3 = (%.3f, %.3f)\n", b(3) - 1.96*se(3), b(3) + 1.96*se(3))
b_norm = b/(b(1)/3);
b_norm
% Looking at the fitted separable line
figure;
plot(X(class1, 1), X(class1, 2), 'b.')
hold on;
plot(X(class2, 1), X(class2, 2), 'r.')
seq = -5:.1:5;
plot(seq, -b(1)/b(3) - b(2)/b(3)*seq, 'LineWidth', 2)
hold off;

%% Logistic regression with a quadratic boundary
% Generate Data
n = 1000;
X = rand(n, 2);
X(:, 1) = (X(:, 1) - 1/2)*8 + normrnd(0, 1, n, 1);
X(:, 2) = (X(:, 2) - 1/2)*6 + 1 + normrnd(0, 1, n, 1);
Y = zeros(size(X, 1), 1);
for i = 1:size(X, 1)
    x = 3 + X(i, 1)*(-4) + X(i, 1)^2 + X(i, 2)*(-1) + normrnd(0, 1);
    if x >= 0
        Y(i) = 0;
    end
    if x < 0
        Y(i) = 1;
    end
end
class1 = find(Y == 0);
class2 = find(Y == 1);

% Looking at y versus x1
plot(X(:, 1), Y, '.')
ylim([-.3, 1.3])
% Looking at y versus x2
plot(X(:, 2), Y, '.')
ylim([-.3, 1.3])
% Looking at x1 versus x2
plot(X(:, 1), X(:, 2), '.')

% Looking at y versus x1 and x2
figure;
plot(X(class1, 1), X(class1, 2), 'b.')
hold on;
plot(X(class2, 1), X(class2, 2), 'r.')
hold off;

% Fit a logistic regression
one_X = [ones(size(X, 1), 1), X];
counts = ones(size(Y));
[b, dev, stats] = glmfit(one_X, [Y, counts], 'binomial', 'constant', 'off');
% Looking at the fitted separable line
figure;
plot(X(class1, 1), X(class1, 2), 'b.')
hold on;
plot(X(class2, 1), X(class2, 2), 'r.')
seq = -5:.1:5;
plot(seq, -b(1)/b(3) - b(2)/b(3)*seq, 'LineWidth', 2)
hold off;

X_new = [ones(size(X, 1), 1), X(:, 1), X(:, 1).^2, X(:, 2)];
[b, dev, stats] = glmfit(X_new, [Y, counts], 'binomial', 'constant', 'off');
figure;
plot(X(class1, 1), X(class1, 2), 'b.')
hold on;
plot(X(class2, 1), X(class2, 2), 'r.')
seq = -1:.1:5;
plot(seq, -b(1)/b(4) - b(2)/b(4)*seq - b(3)/b(4)*seq.^2, 'LineWidth', 2)
hold off;

