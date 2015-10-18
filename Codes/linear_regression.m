%beta_hat = mean  sigma_sqr_hat = standard deviation

function [beta_hat, sigma_sqr_hat] = linear_regression(X,Y)

% Reture MLEs

%X = X'; Y=Y';
beta_hat = inv(X'*X)*X'*Y;
sigma_sqr_hat = (Y-X*beta_hat)'*(Y-X*beta_hat)/length(Y);
% beta_hat = inv(X'*X)*X'*Y;
% sigma_sqr_hat = sum((Y-X*beta_hat).^2)/(length(Y)-2)