%% Importing the data from the csv page rank computation export
pagerankmaison = importfile('page_rank_maison.csv');

%% Preprocessing data
pagerankmaison.page_type=categorical(pagerankmaison.page_type);
pagerankmaison.rayon=categorical(pagerankmaison.rayon);
pagerankmaison.depth=ordinal(pagerankmaison.depth);

%% Saving data as a .mat file
save('page_rank_visualizing_script.mat');


 


