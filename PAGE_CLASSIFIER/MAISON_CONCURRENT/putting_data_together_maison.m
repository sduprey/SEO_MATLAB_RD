%% Reporting for the keywords referential
%% Getting data from the database referential & storing it efficiently in memory
javaaddpath('C:\My_MathWorks_Work\PAGE_CLASSIFIER\MAISON_CONCURRENT\postgresql-9.3-1102.jdbc4.jar');
setdbprefs ('DataReturnFormat', 'table');
conn = database('CRAWL4J','postgres','mogette','Vendor','PostgreSQL',...
    'Server','localhost');

%% complete request
every_field_request = 'select url, whole_text, title, h1, short_description, status_code, depth, outlinks_size, inlinks_size, nb_breadcrumbs, nb_aggregated_ratings, nb_ratings_values, nb_prices, nb_availabilities, nb_reviews, nb_reviews_count, nb_images, nb_search_in_url, nb_add_in_text, nb_filter_in_text, nb_search_in_text, nb_guide_achat_in_text, nb_product_info_in_text, nb_livraison_in_text, nb_garanties_in_text, nb_produits_similaires_in_text, nb_images_text, width_average, height_average, page_rank, page_type, concurrent_name, last_update, semantic_hits, semantic_title, inlinks_semantic, inlinks_semantic_count  from arbocrawl_results';
curs = exec(conn,every_field_request);
curs = fetch(curs);
close(curs);
%Assign data to output variable
data = curs.Data;
% Close database connection.
close(conn);

%% Setting up predictors and outputs
% URL WITHOUT ? PARAMETERS
data.url;
% PAGE TEXT
data.whole_text;
% PAGE TITLE
data.title;
% PAGE H1
data.h1;
% PAGE SHORT DESCRIPTION
data.short_description;
% PAGE STATUS CODE
data.status_code;
% PAGE DEPTH AT SITE LEVEL
data.depth;
% NUMBER OF OUTGOING LINKS
data.outlinks_size;
% NUMBER OF INCOMING LINKS
data.inlinks_size;
% NUMBER OF ITEMTYPE http://data-vocabulary.org/Breadcrumb
data.nb_breadcrumbs;
% NUMBER OF ITEMPROP aggregateRating
data.nb_aggregated_ratings;
% NUMBER OF ITEMPROP ratingValue
data.nb_ratings_values;
% NUMBER OF ITEMPROP price
data.nb_prices;
% NUMBER OF ITEMPROP availability
data.nb_availabilities;
% NUMBER OF ITEMPROP review
data.nb_reviews;
% NUMBER OF ITEMPROP reviewCount
data.nb_reviews_count;
% NUMBER OF ITEMPROP image
data.nb_images;
%  NUMBER OF OCCURENCES FOUND IN URL of search + recherche + Recherche + Search
data.nb_search_in_url;
% NUMBER OF OCCURENCES FOUND IN PAGE TEXT ajout + ajouter + Ajout + Ajouter
data.nb_add_in_text;
% NUMBER OF OCCURENCES FOUND IN PAGE TEXT filtre + facette + Filtre + Facette + filtré + filtrés
data.nb_filter_in_text;
% NUMBER OF OCCURENCES FOUND IN PAGE TEXT Ma recherche + Votre recherche + résultats pour + résultats associés   
data.nb_search_in_text;
% NUMBER OF OCCURENCES FOUND IN PAGE TEXT guide d'achat + Guide d'achat
data.nb_guide_achat_in_text;
% NUMBER OF OCCURENCES FOUND IN PAGE TEXT caractéristique + Caractéristique + descriptif + Descriptif +information + Information       
data.nb_product_info_in_text;
% NUMBER OF OCCURENCES FOUND IN PAGE TEXT livraison + Livraison + frais de port + Frais de port
data.nb_livraison_in_text;
% NUMBER OF OCCURENCES FOUND IN PAGE TEXT garantie + Garantie +assurance + Assurance
data.nb_garanties_in_text;
% NUMBER OF OCCURENCES FOUND IN PAGE TEXT Produits Similaires + produits similaires + Meilleures Ventes + meilleures ventes +Meilleures ventes + Nouveautés + nouveautés + Nouveauté + nouveauté   
data.nb_produits_similaires_in_text;
% NUMBER OF HTML TAG img IN THE PAGE
data.nb_images_text;
% AVERAGE WIDTH OF HTML TAG img IN THE PAGE
data.width_average;
% AVERAGE HEIGHT OF HTML TAG img IN THE PAGE
data.height_average;
% PAGE INRANK TO BE COMPUTED BY AN EXTERNAL PROCESS
data.page_rank;
% PAGE TYPE TO BE DETERMINED BY OUR CLASSIFYING ALGORITHM
data.page_type;
% concurrent name delamaison, darty, Cdiscount-maison
data.concurrent_name;
% last database update time
data.last_update;
% TEN BEST TF/IDF HITS FOR THE PAGE
data.semantic_hits;
% TITLE TF/IDF
data.semantic_title;
%  PAGE INCOMING LINKS ANCHOR SEMANTIC
data.inlinks_semantic;
% PAGE INCOMING LINKS ANCHOR TERM FREQUENCY
data.inlinks_semantic_count;

% predictor matrix
% we just keep a definite subset to use as predictors
X_SEMANTIC_INDICATOR = [data.url data.whole_text data.title data.h1 data.short_description data.semantic_hits data.semantic_title data.inlinks_semantic data.inlinks_semantic_count];
X=[data.depth data.outlinks_size data.inlinks_size data.nb_breadcrumbs data.nb_aggregated_ratings data.nb_ratings_values data.nb_prices data.nb_availabilities data.nb_reviews data.nb_reviews_count data.nb_images data.nb_search_in_url data.nb_add_in_text data.nb_filter_in_text data.nb_search_in_text data.nb_guide_achat_in_text data.nb_product_info_in_text data.nb_livraison_in_text data.nb_garanties_in_text data.nb_produits_similaires_in_text data.nb_images_text data.width_average data.height_average];
catPred={'PAGE DEPTH AT SITE LEVEL','NUMBER OF OUTGOING LINKS','NUMBER OF INCOMING LINKS','NUMBER OF ITEMTYPE http://data-vocabulary.org/Breadcrumb','NUMBER OF ITEMPROP aggregateRating','NUMBER OF ITEMPROP ratingValue','NUMBER OF ITEMPROP price','NUMBER OF ITEMPROP availability','NUMBER OF ITEMPROP review','NUMBER OF ITEMPROP reviewCount','NUMBER OF ITEMPROP image','NUMBER OF OCCURENCES FOUND IN URL of search + recherche + Recherche + Search','NUMBER OF OCCURENCES FOUND IN PAGE TEXT ajout + ajouter + Ajout + Ajouter','NUMBER OF OCCURENCES FOUND IN PAGE TEXT filtre + facette + Filtre + Facette + filtré + filtrés','NUMBER OF OCCURENCES FOUND IN PAGE TEXT Ma recherche + Votre recherche + résultats pour + résultats associés','NUMBER OF OCCURENCES FOUND IN PAGE TEXT guide d''achat + Guide d''achat','NUMBER OF OCCURENCES FOUND IN PAGE TEXT caractéristique + Caractéristique + descriptif + Descriptif +information + Information','NUMBER OF OCCURENCES FOUND IN PAGE TEXT livraison + Livraison + frais de port + Frais de port','NUMBER OF OCCURENCES FOUND IN PAGE TEXT garantie + Garantie +assurance + Assurance','NUMBER OF OCCURENCES FOUND IN PAGE TEXT Produits Similaires + produits similaires + Meilleures Ventes + meilleures ventes +Meilleures ventes + Nouveautés + nouveautés + Nouveauté + nouveauté','NUMBER OF HTML TAG img IN THE PAGE','AVERAGE WIDTH OF HTML TAG img IN THE PAGE','AVERAGE HEIGHT OF HTML TAG img IN THE PAGE'};

% we here don't use page rank as a predictor
Y = categorical(data.page_type);

%% saving as .mat file
save 'maison_concurrency_crawl_cdiscount' X X_SEMANTIC_INDICATOR Y catPred;

