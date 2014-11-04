function data=pagetype_reporting(conn,type,regexx,current_conc)
%PAGETYP_REPORTING Summary of this function goes here
%   Detailed explanation goes here
position_nb_beans=100;
volume_nb_beans=50;
my_string=['select * from pricing_keywords where domain=''' current_conc ''' and url like ''%' regexx '%'''];
setdbprefs ('DataReturnFormat', 'table');
curs = exec(conn, my_string);
curs = fetch(curs);
close(curs);
%Assign data to output variable
data = curs.Data;
% getting search position distribution
h=figure('Name','Position and volume distribution','toolbar','none','menubar','none','units','pixels','position',[10 10 1000 1250],'Color',[1 1 1]);

subplot(1,3,1,'align');
hist(data.search_position,position_nb_beans);
first_title=['Rank ' current_conc ' ' type];
title(first_title);

subplot(1,3,2,'align');
hist(data.search_volume,volume_nb_beans);
title(['Vol ' current_conc ' ' type]);

subplot(1,3,3,'align');
epurated_volume = data.search_volume(data.search_volume<=quantile(data.search_volume,0.6));
hist(epurated_volume,100);
title(['Low Vol ' current_conc ' ' type]);
saveas(h,[first_title '.jpg'],'jpg');


end

