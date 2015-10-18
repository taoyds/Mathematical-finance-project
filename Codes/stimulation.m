function [S1, S2]=stimulation(W1,W2,mu1, sigma1, mu2, sigma2, S1_0, S2_0, T1, T2)

S1 = S1_0 * exp((mu1 - .5*sigma1^2)*T1 + sigma1*W1);
S2 = S2_0 * exp((mu2 - .5*sigma2^2)*T2 + sigma2*W2);
end

% Why not log?