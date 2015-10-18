function [mu, sigma_sqr] = single_estimate(X, del_T)

% X = diff(log(S))

A = sqrt(del_T);
B = X./A;

[m, sigma_sqr] = linear_regression(A,B);
mu = m + 0.5*sigma_sqr;