function [W1, W2] = bi_bm(T1, T2, rho)

[T,I] = sort([T1,T2]);
diffT = diff(T);
W = zeros(2,length(T));
for i=2:length(T)
    dw = mvnrnd([0 0], [diffT(i-1),diffT(i-1)*rho; diffT(i-1)*rho, diffT(i-1)]);
    W(:,i) = W(:,i-1) + dw';
end

W1 = W(1, I<=length(T1)); 
W2 = W(2, I>length(T1));