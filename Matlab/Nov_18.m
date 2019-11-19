%% Generate AR Data
p = 2;
n = 100;
X_ar = zeros(n, 1);
X_ar(1:p) = [3, -3];
%phi = [.5, -.5]; % oscillation
phi = [.5, -.2]; % exponential decay
%phi = [1.3, -.7]; % exponential increase
for t = 1:size(X_ar, 1)
    if X_ar(t) == 0
        X_ar(t) = phi*X_ar(t-p:t-1) + normrnd(0, .5);
    end
end
plot(X_ar)

ar_mod = ar(X_ar, 10);
ar_mod
ar_mod.covar % covariance matrix
ar_mod.Report.Parameters.ParVector % Parameters
compare(X_ar, ar_mod, 2) % 10-step ahead prediction

armax_mod = armax(X_ar, [3 1]);
armax_mod
armax_mod.Report.Parameters.ParVector % Parameters
compare(X_ar, armax_mod, 2) % 10-step ahead prediction

%% Generate MA Data
q = 2;
n = 100;
% different errors
%errors = normrnd(sin((2*pi*(0:1/n:1))), .1)';
errors = normrnd((((2*pi*(0:1/n:1))-pi)/2).^2, .1)';
%errors = normrnd(0, .1, 1, n)';
errors = errors(1:n);
X_ma = zeros(n, 1);
mu = 3;
X_ma(1:q) = mu * ones(q, 1);
theta = [-.5, .5];
for t = 1:size(X_ma, 1)
    if X_ma(t) == 0
        X_ma(t) = mu + errors(t) + theta*errors(t-q:t-1);
    end
end
plot(X_ma)

armax_mod = armax(X_ma, [1 4]);
armax_mod
armax_mod.Report.Parameters.ParVector % Parameters
compare(X_ma, armax_mod, 2) % 10-step ahead prediction


%% Generate ARMA Data
p = 3;
q = 2;
n = 200;
errors = normrnd((((2*pi*(0:1/n:1))-pi)/2).^2, .1)';
errors = errors(1:n);
X_arma = zeros(n, 1);
X_arma(1:p) = [10, -10, 5];
phi = [.5, -.2, .2];
theta = [-1, 1];
mu = 3;
for t = 1:size(X_arma, 1)
    if X_arma(t) == 0
        X_arma(t) = mu + errors(t) + theta*errors(t-q:t-1) + phi*X_arma(t-p:t-1);
    end
end
plot(X_arma)
 
armax_mod = armax(X_arma, [4 2]);
armax_mod
armax_mod.Report.Parameters.ParVector % Parameters
compare(X_arma, armax_mod, 2) % 10-step ahead prediction

%% How to decide on number of parameters?
% Looking at autocorrelation function
n = 100;
corr = xcorr(X_ar);
corr = corr(n:end);
plot(corr/n)

% Looking at partial autocorrelation function
pcorr = parcorr(X_ar);
plot(pcorr)
ylim([-1.2, 1.2])

% More examples
Mdl = arima('AR',{0.6 -0.5},'Constant',0,'Variance', 1);
y = simulate(Mdl,1000);
plot(y)
[partialACF, lags, bounds] = parcorr(y,'NumAR',2);
parcorr(y)

Mdl = arima('AR',{0.75,0.15} ,'MA',-0.5,'Constant',2, 'Variance',1);
y = simulate(Mdl,1000);
[partialACF,lags,bounds] = parcorr(y,'NumAR',2);
parcorr(y)
parcorr(y,'NumLags',40)

% Fit models with different number of parameters and look at AIC (BIC)



