%brownien bridge sampling
function [sampled_logS, sampling_times] = BB_sampling(O_T, del_T, start_T, end_T, logS, mu, sigma_sqr)
 W = (logS - (mu - .5*sigma_sqr)*O_T) / sigma_sqr^.5;
 sampling_times = start_T:del_T:end_T;
 [sampled_W, ~, ~] = cond_BM_v2(O_T, sampling_times, W);
 sampled_logS = sigma_sqr^.5 * sampled_W + (mu - .5*sigma_sqr)*sampling_times;

function [sample_S] = BB_sampling(T, S, tgrid)

sample_S = interp1q(T,S,tgrid');
% figure
% plot(sample_S);
% sample_S;
% 
% ones(1,length(tgrid))*inf;
% 
% for i = 1:length(S)-1
%     ii = find( tgrid>=T(i) & tgrid < T(i+1) );
%     if isempty(ii)
%         continue
%     end
%     sample_S(ii) = interp1q(T,S,tgrid);
%     %sample_S(ii) = wbridge_zhu(T(i), T(i+1), S(i), S(i+1), tgrid(ii), sigma);
% end
