%Read Data
function [S, realT, volum] = data_process(filename)

fid = fopen(filename, 'r');
data = textscan(fid, '%f', 'delimiter','|-: '); %*
fclose(fid);
data = data{1};

days = @(ind) datenum(data(ind*8-7), data(ind*8-6), data(ind*8-5), data(ind*8-4), data(ind*8-3), data(ind*8-2));
N = length(data)/8;
S = zeros(N,1); realT = zeros(N,1); volum = zeros(N,1);

for i=1:N
    realT(i) = days(i)*24*3600 ;
    S(i) = data(i*8);
    volum(i) = data(i*8-1);
end

[realT, I] = sort(realT); % Why sort?
S = S(I);
volum = volum(I);