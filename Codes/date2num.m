function second = date2num(date)

second = datenum(str2double(date(1:4)),str2double(data(6:7)),str2double(data(9:10)),str2double(date(12:13)),str2double(date(15:16)),str2double(date(18:19)));
% date_num = date(1:10);%datenum(date(1:10), 'yyyy-mm-dd');
% h = (double(date(12))-48)*10 + (double(date(13))-48);%str2double(date(12:13));
% m = (double(date(15))-48)*10 + (double(date(16))-48);%str2double(date(15:16));
% s = (double(date(18))-48)*10 + (double(date(19))-48);%str2double(date(18:19));
% time = h*3600+m*60+s;