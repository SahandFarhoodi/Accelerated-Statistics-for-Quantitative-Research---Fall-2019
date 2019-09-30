temp = csvread('temperature.csv'); %columns = (year, deg);
temp = temp(temp(:, 2) < 500, :);
temp(:, 1) = floor(temp(:, 1));
year_1990 = temp(temp(:, 1) == 1990, :);
year_2005 = temp(temp(:, 1) == 2005, :);

n = 5000;
r = randperm(size(year_1990, 1));
samp_1990 = year_1990(r(1:n), :);
r = randperm(size(year_2005, 1));
samp_2005 = year_2005(r(1:n), :);
r = randperm(size(temp, 1));
samp_All1 = temp(r(1:n), :);
r = randperm(size(temp, 1));
samp_All2 = temp(r(1:n), :);

%% Looking at histograms
bins = 20;
figure; 
subplot(2, 2, 1);
histogram(samp_1990(:, 2), bins);
title('1990');
subplot(2, 2, 2);
histogram(samp_2005(:, 2), bins);
title('2005')
subplot(2, 2, 3);
histogram(samp_All1(:, 2), bins);
title('All1');
subplot(2, 2, 4);
histogram(samp_All2(:, 2), bins);
title('All2');

%% Looking at Kernel methods
figure;
subplot(2, 2, 1);
[f, x] = ksdensity(samp_1990(:, 2));
plot(x, f, 'LineWidth', 2);
title('1990');
subplot(2, 2, 2);
[f, x] = ksdensity(samp_2005(:, 2));
plot(x, f, 'LineWidth', 2);
title('2005');
subplot(2, 2, 3);
[f, x] = ksdensity(samp_All1(:, 2));
plot(x, f, 'LineWidth', 2);
title('All1');
subplot(2, 2, 4);
[f, x] = ksdensity(samp_All2(:, 2));
plot(x, f, 'LineWidth', 2);
title('All2');

%% Looking at qq-plots (in comparison to Normal distribution)
figure;
subplot(2, 2, 1);
qqplot(samp_1990(:, 2));
title('1990');
subplot(2, 2, 2);
qqplot(samp_2005(:, 2));
title('2005');
subplot(2, 2, 3);
qqplot(samp_All1(:, 2));
title('All1');
subplot(2, 2, 4);
qqplot(samp_All2(:, 2));
title('All2');

%% Looking at ecdfs
figure;
subplot(2, 2, 1);
[f, x] = ecdf(samp_1990(:, 2));
plot(x, f, 'LineWidth', 1);
title('1990');
subplot(2, 2, 2);
[f, x] = ecdf(samp_2005(:, 2));
plot(x, f, 'LineWidth', 1);
title('2005');
subplot(2, 2, 3);
[f, x] = ecdf(samp_All1(:, 2));
plot(x, f, 'LineWidth', 1);
title('All1');
subplot(2, 2, 4);
[f, x] = ecdf(samp_All2(:, 2));
plot(x, f, 'LineWidth', 1);
title('All2');

%% Comparing two different years
% Looking at ecdf of 1990 vs. 2005, and All1 vs. All2
figure;
subplot(2, 1, 1);
[f, x] = ecdf(samp_1990(:, 2));
plot(x, f, 'LineWidth', 1);
hold on;
[f, x] = ecdf(samp_2005(:, 2));
plot(x, f, 'LineWidth', 1);
title('1990 vs. 2005');
hold off;
subplot(2, 1, 2);
[f, x] = ecdf(samp_All1(:, 2));
plot(x, f, 'LineWidth', 1);
hold on;
[f, x] = ecdf(samp_All2(:, 2));
plot(x, f, 'LineWidth', 1);
title('All1 vs. All2');
hold off;

% Looking at qqplot for 1990 vs. 2005, and All1 vs. All2
figure;
subplot(2, 1, 1);
qqplot(samp_1990(:, 2), samp_2005(:, 2));
title('1990 vs. 2005');
subplot(2, 1, 2);
qqplot(samp_All1(:, 2), samp_All2(:, 2));
title('All1 vs. All2');

%% Using bootstrap to see the distribution of mean and median
B = 10000;
n = 500;
means = zeros(B, 1);
medians = zeros(B, 1);
for b = 1:B
    r = randperm(size(year_1990, 1));
    samp_1990 = year_1990(r(1:n), :);
    means(b) = mean(samp_1990(:, 2));
    medians(b) = median(samp_1990(:, 2));
end
figure;
subplot(1, 2, 1);
[f, x] = ksdensity(means);
plot(x, f, 'LineWidth', 2);
title('means');
subplot(1, 2, 2);
[f, x] = ksdensity(medians);
plot(x, f, 'LineWidth', 2);
title('medians');

