%% Importing the data from the csv page rank computation export
% getting the computed page rank for maison
load('computed_data.mat');
% getting rid of the nan data
pagerankmaison(isnan(pagerankmaison.page_rank),:)=[];

% getting the GWT extract for visits for maison
visits_searchdex_data=importfilevisits('searchdexing-maison-visites.csv');
nb_visits = cellfun(@convert_to_nb_visits,visits_searchdex_data.visits,'UniformOutput',false);
visits_searchdex_data.nb_visits=[nb_visits{:}]';
% getting rid of empty visit numbers
visits_searchdex_data.nb_visits(isnan(visits_searchdex_data.nb_visits))=0;
% getting the GWT extract for visits for maison
visits_data=importfileGWTAllMagasins('www-cdiscount-com-maison_20150223T124846Z_TopSearchUrls_20150124-20150223.csv');
% getting rid of the empty data
visits_data.nb_impressions(isnan(visits_data.nb_impressions))=0;
% % getting rid of www.cdiscount.com stub
% nb_visits = cellfun(@convert_to_nb_visits,visits_searchdex_data.visits,'UniformOutput',false);
save('computed_data.mat');
