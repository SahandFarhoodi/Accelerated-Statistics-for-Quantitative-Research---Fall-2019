%% Generating data
n = 1000;
Data = zeros(n, 3);
err_sd = .3; 
% You can play with 'err_sd' to increase/decrease overlap of classes
for i = 1:n
    p = unifrnd(0, 1, 1);
    if p >= 3/4
        x = unifrnd(-1, 0, 1) + normrnd(0, err_sd, 1);
        y = unifrnd(-1, 0, 1) + normrnd(0, err_sd, 1);
        Data(i, :) = [x, y, 1];
    end
    if 3/4 > p >= 1/2
        x = unifrnd(0, 1, 1) + normrnd(0, err_sd, 1);
        y = unifrnd(0, 1, 1) + normrnd(0, err_sd, 1);
        Data(i, :) = [x, y, 1];
    end   
    if 1/2 > p >= 1/4
        x = unifrnd(0, 1, 1) + normrnd(0, err_sd, 1);
        y = unifrnd(-1, 0, 1) + normrnd(0, err_sd, 1);
        Data(i, :) = [x, y, 2];
    end
    if 1/4 > p
        x = unifrnd(-1, 0, 1) + normrnd(0, err_sd, 1);
        y = unifrnd(0, 1, 1) + normrnd(0, err_sd, 1);
        Data(i, :) = [x, y, 2];
    end
end
figure;
Data_1 = Data(Data(:,3) == 1, :);
Data_2 = Data(Data(:,3) == 2, :);

% Looking at data
plot(Data_1(:, 1), Data_1(:, 2), 'r.');
hold on;
plot(Data_2(:, 1), Data_2(:, 2), 'b.');
plot([-(1+2*err_sd), 1+2*err_sd], [0, 0], 'Color', [17/255 17/255 17/255])
plot([0, 0], [-(1+2*err_sd), 1+2*err_sd], 'Color', [17/255 17/255 17/255])
hold off;

%% Fit a logistic regression
% You have to first work-out the design matrix (in real data sets it can be
% much more complicated.) 
X = [ones(size(Data, 1), 1), Data(:, 1).*Data(:, 2)];
Y = Data(:, 3) - 1;
[b, dev, stats] = glmfit(X, Y, 'binomial', 'constant', 'off');
plot(Data_1(:, 1), Data_1(:, 2), 'r.');
hold on;
plot(Data_2(:, 1), Data_2(:, 2), 'b.');
alpha = -b(1)/b(2);
plot([-(1+2*err_sd), 1+2*err_sd], [-alpha/(1+2*err_sd), alpha/(1+2*err_sd)], 'Color', [17/255 17/255 17/255])
plot([-alpha/(1+2*err_sd), alpha/(1+2*err_sd)], [-(1+2*err_sd), 1+2*err_sd], 'Color', [17/255 17/255 17/255])
hold off;

%% Fit a k-nearest-neighbor estimation
% Play with k to see the effect of k on k-nearest neighborhood estimation
% When k is large (small) what happens to Bias and Variance of your model?
% How can you pick a good value for k?
k = 50;
KNN_model = fitcknn(Data(:, 1:2), Data(:, 3),'NumNeighbors',k,'Standardize',1);
x1_range = min(Data(:, 1)):0.05:max(Data(:, 1));
x2_range = min(Data(:, 2)):0.05:max(Data(:, 2));
pred = zeros(length(x1_range), length(x2_range));
for i = 1:length(x1_range)
    for j = 1:length(x2_range)
        x1 = x1_range(i);
        x2 = x2_range(j);
        pred(i, j) = predict(KNN_model, [x1, x2]);
    end
end
imagesc(pred);
colorbar;

%% Fit SVM
% Play with 'KernelScale' to find a good tradeoff between Bias and Variance
% What happens if 'KernleScale' is too big (too small)? What is a good
% value? How can you obtain it?
SVM_model = fitcsvm(Data(:, 1:2), Data(:, 3), 'Standardize', 1, 'KernelFunction','RBF', 'KernelScale', .8);
x1_range = min(Data(:, 1)):0.05:max(Data(:, 1));
x2_range = min(Data(:, 2)):0.05:max(Data(:, 2));
pred = zeros(length(x1_range), length(x2_range));
for i = 1:length(x1_range)
    for j = 1:length(x2_range)
        x1 = x1_range(i);
        x2 = x2_range(j);
        pred(i, j) = predict(SVM_model, [x1, x2]);
    end
end
imagesc(pred);
colorbar;

%% Fit a tree-based method
% Check what is 'MaxNumSplits' and play with it to see overfitting and
% underfittng models. How to decide on it? Is there a better way to prevent
% your model from overfittin? YES, you can use 'CrossVal' to 'on', however
% a little modification is needed to get predictions.
tree_model = fitctree(Data(:, 1:2), Data(:, 3), 'MaxNumSplits', 20);
x1_range = min(Data(:, 1)):0.05:max(Data(:, 1));
x2_range = min(Data(:, 2)):0.05:max(Data(:, 2));
pred = zeros(length(x1_range), length(x2_range));
for i = 1:length(x1_range)
    for j = 1:length(x2_range)
        x1 = x1_range(i);
        x2 = x2_range(j);
        pred(i, j) = predict(tree_model, [x1, x2]);
    end
end
imagesc(pred);
colorbar;

