%% CLT - IID
num = 10000;
means = zeros(1, num);
n = 100;
for k = (1:num)
  %X = randn(1, n);
  X = rand(1, n);
  means(k) = mean(X);
end
histogram(means, 20);

%% CLT - not IID
num = 10000;
means = zeros(1, num);
n = 10000;
for k = (1:num)
  %X = randn(1, n);
  X = rand(1, n);
  Y = zeros(1, n-1);
  for i = (1:n-1)
    Y(i) = X(i) + X(i+1);
  end
  means(k) = mean(Y);
end
histogram(means, 20);

%% Delta Method
num = 10000;
means = zeros(1, num);
n = 10000;
for k = (1:num)
  X = 1/exp(randn(n, 1));
  means(k) = mean(X);
end
histogram(means, 20);

%% Find the largest increasing sequence
A = [2, 3, 5, 6, 4, 7, 8, 9, 10, 20, 1, 3, 5];
best_found = 0;
curr_len = 1;
best_ind = 1
for i = 2:length(A)
    if A(i) > A(i-1)
        curr_len = curr_len + 1;
    end
    if A(i) <= A(i-1)
        curr_len = 1;
    end
    if curr_len > best_found
        best_found = curr_len;
        best_ind = i
    end
end
disp(best_found)
best_ind
disp(A(best_ind - best_found + 1: best_ind))
