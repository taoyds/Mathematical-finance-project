% Brownian bridge simulation
function X = wbridge_zhu(T_begin,T_end,a,b,tgrid,sigma)
T = T_end - T_begin;
tgrid = [T_begin tgrid T_end];
tgrid = tgrid - T_begin;
tdiff = diff(tgrid);
M =length(tdiff);
if M == 0
    X = [];
    return
end
W = cumsum(sqrt(tdiff).*randn(1,M));
X = a + (b-a)*tgrid(2:M+1)/T + sigma*(W - tgrid(2:M+1)/T*W(M));
X = X (1:end-1);
%Xexpand = [a X b];
%plot(tgrid,Xexpand,'-');
