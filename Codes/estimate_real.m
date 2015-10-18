function [rho_hats,p,corvar] = estimate_real(filename1, filename2)

    [S1, realT1] = data_process(filename1);
    [S2, realT2] = data_process(filename2);
%     figure
%     plot(realT1,S1);
%     hold on
%     plot(realT2, S2);
    Q1 = diff(log(S1));
    Q2 = diff(log(S2));
    [mu1_hat, sigma1_sqr_hat] = single_estimate(Q1, diff(realT1));
    [mu2_hat, sigma2_sqr_hat] = single_estimate(Q2, diff(realT2));
    minT = max(min(realT1),min(realT2));
    maxT = min(max(realT1),max(realT2));
    range=maxT - minT;  
    del_t= range/100;  
    tgrids = minT:del_t:maxT;
    tgrids = tgrids_filter(tgrids,realT1,realT2);
    S_sampled1 = BB_sampling(realT1,log(S1), tgrids); %in practice sigma1 is not avaliable, use estimate of sigma1 instead
    S_sampled2 = BB_sampling(realT2, log(S2),tgrids);
    
    ava_inds = find(S_sampled1~=inf & S_sampled2~=inf);

    Q_sampled1 = diff(S_sampled1(ava_inds));
    Q_sampled2 = diff(S_sampled2(ava_inds));
    

    [rho_hats,p] = corrcoef(Q_sampled1, Q_sampled2); %using the property that tgrid are uniform grids, so Q_sampled are iid
    corvar = cov(Q_sampled1, Q_sampled2)*24*3600;
    
    
 