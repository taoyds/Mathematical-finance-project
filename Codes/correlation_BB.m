[S1, realT1, volum1] = data_process('CO.csv');
[S2, realT2, volum2] = data_process('CPBC.csv');
tl = max(min(realT1),min(realT2));
tu = min(max(realT1),max(realT2));

realT1 = realT1(realT1>tl & realT1<tu);
realT2 = realT2(realT2>tl & realT2<tu);
S1 = S1(realT1>tl & realT1<tu);
S2 = S2(realT2>tl & realT2<tu);
Q1 = diff(log(S1));
Q2 = diff(log(S2));
[mu1_hat, sigma1_sqr_hat] = single_estimate(Q1, diff(realT1));
[mu2_hat, sigma2_sqr_hat] = single_estimate(Q2, diff(realT2));

del_t = 1;
sigma1_hat = sigma1_sqr_hat^.5;
sigma2_hat = sigma2_sqr_hat^.5;
tgrids = t1:del_t:tu;
S_sampled1 = BB_sampling(log(S1), realT1, tgrids, sigma1_hat); 
S_sampled2 = BB_sampling(log(S2), realT2, tgrids, sigma2_hat);

ava_inds = find(S_sampled1~=inf & S_sampled2~=inf);
Q_sampled1 = diff(S_sampled1(ava_inds));
Q_sampled2 = diff(S_sampled2(ava_inds));
C = corrcoef(Q_sampled1, Q_sampled2);