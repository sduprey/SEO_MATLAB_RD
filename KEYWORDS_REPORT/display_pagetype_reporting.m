function display_pagetype_reporting(type, data)

position_nb_beans=100;
volume_nb_beans=50;

% getting search position distribution
h=figure('Name','Position and volume distribution','toolbar','none','menubar','none','units','pixels','position',[10 10 1000 1250],'Color',[1 1 1]);
subplot(1,3,1,'align');
hist(data.search_position,position_nb_beans);
first_title=['Rank ' type];
title(first_title);

subplot(1,3,2,'align');
high_volume = data.search_volume(data.search_volume>=quantile(data.search_volume,0.9));
hist(high_volume,volume_nb_beans);
title(['High Vol ' type]);

subplot(1,3,3,'align');
low_volume = data.search_volume(data.search_volume<=quantile(data.search_volume,0.4));
hist(low_volume,volume_nb_beans);
title(['Low Vol ' type]);
saveas(h,[first_title '.jpg'],'jpg');


end

