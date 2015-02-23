%% Importing the data from the csv page rank computation export
% getting the computed page rank for maison
load('computed_data.mat');
disp(pagerankmaison(1:500,:));
disp(visits_data(1:500,:));

%% Joining the two tables and sorting by page ranks and sorting by visits
pagerank_joined_table = outerjoin(pagerankmaison,visits_data);
% getting rid of the nan data
pagerank_joined_table.nb_impressions(isnan(pagerank_joined_table.nb_impressions))=0;
pagerank_joined_table(isnan(pagerank_joined_table.page_rank),:)=[];

pagerank_joined_table = sortrows(pagerank_joined_table,'nb_impressions','descend');
writetable(pagerank_joined_table(1:800,:),'nb_impressions_sorted_output.csv');
pagerank_joined_table = sortrows(pagerank_joined_table,'page_rank','descend');
writetable(pagerank_joined_table(1:800,:),'page_rank_sorted_output.csv');

%% 
