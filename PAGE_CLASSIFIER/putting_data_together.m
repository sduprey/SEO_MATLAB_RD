%% Reporting for the keywords referential
%% Getting data from the database referential & storing it efficiently in memory
javaaddpath('C:\My_MathWorks_Work\PAGE_CLASSIFIER\postgresql-9.3-1102.jdbc4.jar');
setdbprefs ('DataReturnFormat', 'table');
conn = database('CRAWL4J','postgres','mogette','Vendor','PostgreSQL',...
    'Server','localhost');
curs = exec(conn, 'select url, whole_text, title, h1, short_description, status_code, depth, outlinks_size, inlinks_size, nb_breadcrumbs, nb_aggregated_ratings, nb_ratings_values, nb_prices, nb_availabilities, nb_reviews, nb_reviews_count, nb_images, page_rank, page_type, last_update from arbocrawl_results');
curs = fetch(curs);
close(curs);
%Assign data to output variable
data = curs.Data;
% Close database connection.
close(conn);

%% Setting up predictors and outputs
%select url, whole_text, title, h1, short_description, status_code, depth, outlinks_size, inlinks_size,
%nb_breadcrumbs, nb_aggregated_ratings, nb_ratings_values, nb_prices, nb_availabilities, nb_reviews,
%nb_reviews_count, nb_images, page_rank, page_type, last_update from arbocrawl_results

% predictor matrix
X = [data.depth data.outlinks_size data.inlinks_size data.nb_breadcrumbs data.nb_aggregated_ratings data.nb_ratings_values data.nb_prices data.nb_availabilities data.nb_reviews data.nb_reviews_count data.nb_images];
catPred={'depth' 'outlinks_size' 'inlinks_size' 'nb_breadcrumbs' 'nb_aggregated_ratings' 'nb_ratings_values' 'nb_prices' 'nb_availabilities' 'nb_reviews' 'nb_reviews_count' 'nb_images'};

% we here don't use page rank as a predictor
Y = categorical(data.page_type);

%% saving as .mat file
save 'shallow_crawl_cdiscount' X Y catPred;

