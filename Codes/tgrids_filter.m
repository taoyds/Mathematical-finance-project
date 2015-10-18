function tgrids = tgrids_filter(tgrids,T1,T2)

minT = max(min(T1),min(T2));
maxT = min(max(T1),max(T2));
tgrids = tgrids(tgrids>minT&tgrids<maxT);