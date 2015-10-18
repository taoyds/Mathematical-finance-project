%

filename1 = 'DENT.csv';
filename2 = 'AACOU.csv';

[S1, realT1] = data_process(filename1);
[S2, realT2] = data_process(filename2);

available_t0 = max(realT1(1), realT2(1));
available_t1 = min(realT1(end), realT2(end));

current_date = '2010-03-01';
curr_date = datenum(current_date, 'yyyy-mm-dd');
consider_days = 30;

% samples in considering time
cons_ind1 = find(realT1<=curr_date & realT1>=curr_date-consider_days); % Pick 30 days to test?
cons_ind2 = find(realT2<=curr_date & realT2>=curr_date-consider_days);

% complete missing S's 
T = [realT1(cons_ind1); realT2(cons_ind2)];
[T, permu] = sort(T);
pseudT = time_manipulation(T); %*
pseudT1 = pseudT(permu<=length(cons_ind1));
pseudT2 = pseudT(permu>length(cons_ind1)); %*

missing_S1 = interp1(pseudT1,S1(cons_ind1),pseudT2);
missing_S1 = clear_NaN(missing_S1);
missing_S2 = interp1(pseudT2,S2(cons_ind2),pseudT1);
missing_S2 = clear_NaN(missing_S2);

new_S1 = zeros(size(T));
new_S1(permu<=length(cons_ind1)) = S1(cons_ind1);
new_S1(permu>length(cons_ind1)) = missing_S1;

new_S2 = zeros(size(T));
new_S2(permu<=length(cons_ind1)) = missing_S2;
new_S2(permu>length(cons_ind1)) = S2(cons_ind2);

% estimate sigma and mu's
X1 = diff(log(new_S1)); X2 = diff(log(new_S2)); del_T = diff(pseudT);
[mu1, sigma_sqr1] = single_estimate(X1, del_T);
[mu2, sigma_sqr2] = single_estimate(X2, del_T);

rho = 1/(length(del_T))/sqrt(sigma_sqr1*sigma_sqr2) *  ((X1 - del_T*(mu1-.5*sigma_sqr1)) .\ del_T)' * (X2 - del_T*(mu2-.5*sigma_sqr2));

