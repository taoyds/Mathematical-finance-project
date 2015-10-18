function rho_hats = estimate(t, rho, mu1, sigma1, mu2, sigma2, S1_0, S2_0)

%set mus, sigmas, Si_0s
%mu1 = 2.5; sigma1=0.01; mu2=5.6; sigma2=0.02; S1_0=80; S2_0=110;

%rhos = zeros(1,100);
del_ts = 0.5:0.05:10;
rho_hats = zeros(size(del_ts));
for i = 1:length(del_ts)
    del_t = del_ts(i);
    T1 = sort(rand(1,1000)*t);
    T2 = sort(rand(1,1000)*t);
    [W1, W2] = bi_bm(T1,T2,rho);
    [S1, S2] = stimulation(W1,W2,mu1, sigma1, mu2, sigma2, S1_0, S2_0, T1, T2);
    Q1 = diff(log(S1));
    Q2 = diff(log(S2));
    [mu1_hat, sigma1_sqr_hat] = single_estimate(Q1, diff(T1));
    [mu2_hat, sigma2_sqr_hat] = single_estimate(Q2, diff(T2));
%     sigma1_hat = sigma1_sqr_hat^.5;
%     sigma2_hat = sigma2_sqr_hat^.5;
    tgrids = 0:del_t:t;
    tgrids = tgrids_filter(tgrids,T1,T2);
    S_sampled1 = BB_sampling(T1,log(S1), tgrids); %in practice sigma1 is not avaliable, use estimate of sigma1 instead
    S_sampled2 = BB_sampling(T2, log(S2),tgrids);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% tl = max(min(T1),min(T2));
% tu = min(max(T1),max(T2));
% 
% T1 = T1(T1>tl & T1<tu);
% T2 = T2(T2>tl & T2<tu);
% if(isempty(T1)||isempty(T2))
%     m = 0;
%     return
% end
% 
% [f1,x1] = ksdensity(T1);
% 
% [f2,x2] = ksdensity(T2);
% 
% 
% m = dot(f1,f2)/(norm(f1)*norm(f2));
%  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    

%     clf; hold on;
%     hold on
%      plot(T1,log(S1));
%      plot(tgrids,S_sampled1,'r');
%      
%      plot(T2,log(S2),'g');
%      plot(tgrids,S_sampled2,'y');
    ava_inds = find(S_sampled1~=inf & S_sampled2~=inf);

    Q_sampled1 = diff(S_sampled1(ava_inds));
    Q_sampled2 = diff(S_sampled2(ava_inds));
    

    C = corrcoef(Q_sampled1, Q_sampled2); %using the property that tgrid are uniform grids, so Q_sampled are iid
    
%     del_T = diff(tgrids(ava_inds));
%     X1 = Q_sampled1; X2 = Q_sampled2; sigma_sqr1 = sigma1_sqr_hat;  sigma_sqr2 = sigma2_sqr_hat;
%     rhos(i) = 1/(length(del_T))/sqrt(sigma_sqr1*sigma_sqr2) *  ((X1 - del_T*(mu1_hat-.5*sigma_sqr1)) .\ del_T) * (X2 - del_T*(mu2_hat-.5*sigma_sqr2))';
    if i==92
        1
    end
    rho_hats(i) = C(1,2);
end

figure;
plot(rho_hats, '*'); 