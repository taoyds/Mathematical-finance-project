function m = measure(realT1, realT2)
%[S1, realT1, volum1] = data_process(filename1);
%[S2, realT2, volum2] = data_process(filename2);

% figure
% del_t1 = diff(realT1);
% hist(del_t1);
% figure
% del_t2 = diff(realT2);
% hist(del_t2);

tl = max(min(realT1),min(realT2));
tu = min(max(realT1),max(realT2));

realT1 = realT1(realT1>tl & realT1<tu);
realT2 = realT2(realT2>tl & realT2<tu);
if(isempty(realT1)||isempty(realT2))
    m = 0;
    return
end

[f1,x1] = ksdensity(realT1);

[f2,x2] = ksdensity(realT2);

% figure
% plot(x1, f1)
% hold on
% plot (x2, f2)

m = dot(f1,f2)/(norm(f1)*norm(f2));
% figure
% scatter(realT1,S1);
% hold on
% scatter(realT2,S2);
end
