datafile = {'AFO.csv','AFQ.csv', 'AFT.csv', 'AGCO.csv', 'AGIX.csv', 'AGMA.csv', 'AGOPRB.csv','BGEPRB.csv', 'BIP.csv', 'BKPRF.csv', 'BMRC.csv', 'BNZ.csv', 'BOX.csv', 'BPWWS.csv','CFNB.csv', 'CIIC.csv', 'CLNY.csv', 'CMSPRB.csv', 'CO.csv', 'CPBC.csv', 'CUZPRB.csv','CYCC.csv', 'DCA.csv', 'DEK.csv', 'DENT.csv', 'DSF.csv', 'E.csv','EDAC.csv','EGPPRDCL.csv','ELP.csv', 'ESM.csv', 'EWI.csv','FBHS.csv', 'FFSX.csv', 'JZT.csv', 'KOSS.csv','MCN.csv','MDU.csv', 'MMF.csv', 'MOFG.csv', 'NBJPRA.csv', 'NKM.csv', 'NTWK.csv', 'NWD.csv', 'OOO.csv','RAD.csv', 'RDF.csv', 'RRST.csv', 'SCCO.csv', 'SDE.csv', 'SGPPRB.csv', 'SSNC.csv', 'SUNHD.csv','TXTPRB.csv', 'VIST.csv', 'WLBC.csv', 'XRIT.csv', 'ZVVV.csv', 'ZZRTWI.csv', 'IDTC.csv'};
% realT = cell(size(datafile));
% 
% for i=1:length(datafile)
%     waitbar(i/length(datafile));
%     [~, realT{i}, ~] = data_process(datafile{i});
% end
m = zeros(length(datafile));
for i = 1:length(datafile)
    for j = i+1:length(datafile)
        m(i,j) = measure(realT{i},realT{j});
    end
end
