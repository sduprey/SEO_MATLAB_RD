%% Mots clés où Amazon est et où nous ne sommes pas
%% Getting data from the database referential & storing it efficiently in memory
javaaddpath('C:\My_MathWorks_Work\PRODUCTS\postgresql-9.3-1102.jdbc4.jar');
setdbprefs ('DataReturnFormat', 'table');
conn = database('KEYWORDSDB','postgres','root','Vendor','PostgreSQL',...
    'Server','localhost');

%% Setting up magasins and concurrents
my_magasin ={'informatique';'musique-cd-dvd';'musique-instruments';'bricolage-chauffage';'culture-multimedia';'dvd';'livres-bd';'jeux-educatifs';'cadeaux-noel';'juniors';'jeux-pc-video-console';'high-tech';'vin-champagne';'photo-numerique';'animalerie';'bagages';'jardin-animalerie';'electromenager';'le-sport';'vin-alimentaire';'cosmetique';'telephonie';'arts-loisirs';'pret-a-porter';'soldes-promotions';'outillage';'chaussures';'destockage';'auto';'Unknown';'maison';'boutique-cadeaux';'salon-complet';'bijouterie';'au-quotidien';'jardin'};
my_entity = {'aubert.com';'autourdebebe.com';'king-jouet.com';'toysrus.fr';'materiel.net';'pearl.fr';'amazon.fr';'ebay.fr';'rueducommerce.fr';'conforama.fr';'darty.com';'fnac.com';'priceminister.com';'zalando.fr';'ldlc.com';'boulanger.fr';'french.alibaba.com';'pixmania.fr'};
% creating the database for each entity
% we do run the table creation just once !!!
% not more
for conc=1:length(my_entity)
    current_ent = my_entity{conc};
    [radical_for_base, remain] = strtok(current_ent,'.');
    disp(radical_for_base);
    requestone = ['select keyword, url, search_position, search_volume, magasin, rayon, produit into ' radical_for_base '_pricing from pricing_keywords where domain=''' current_ent ''''];
    curs = exec(conn, requestone);
    close(curs);
    requesttwo = ['CREATE INDEX ON ' radical_for_base '_pricing (keyword)'];
    curs = exec(conn, requesttwo);
    close(curs);
    requestthree = ['select CDISCOUNT_PRICING.keyword as cd_keyword, CDISCOUNT_PRICING.url as cd_url, CDISCOUNT_PRICING.search_volume as cd_search_volume, CDISCOUNT_PRICING.search_position as cd_search_position,' radical_for_base '_PRICING.magasin as magasin, ' radical_for_base '_PRICING.rayon as rayon, ' radical_for_base '_PRICING.produit as produit, ' radical_for_base '_PRICING.keyword as am_keyword, ' radical_for_base '_PRICING.url as am_url, ' radical_for_base '_PRICING.search_volume as am_search_volume, ' radical_for_base '_PRICING.search_position as am_search_position INTO ' radical_for_base '_VS_CDISCOUNT_PRICING from ' radical_for_base '_PRICING LEFT OUTER JOIN CDISCOUNT_PRICING  on( ' radical_for_base '_PRICING.keyword=CDISCOUNT_PRICING.keyword)'];
    curs = exec(conn, requestthree);
    close(curs);
    disp(requestone);
    disp(requesttwo);
    disp(requestthree);
end
%% magasin reporting
current_magasin='informatique';
my_entity = {'materiel.net';'pearl.fr';'amazon.fr';'ebay.fr';'rueducommerce.fr';'darty.com';'fnac.com';'priceminister.com';'ldlc.com';'boulanger.fr';'french.alibaba.com';'pixmania.fr'};
magasin_keywords_reporting(current_magasin,my_entity,conn);

%% magasin reporting
current_magasin='musique-cd-dvd';
my_entity = {'amazon.fr';'ebay.fr';'rueducommerce.fr';'fnac.com';'priceminister.com';'pixmania.fr'};
magasin_keywords_reporting(current_magasin,my_entity,conn);

%% magasin reporting
current_magasin='musique-instruments';
my_entity = {'amazon.fr';'ebay.fr';'rueducommerce.fr';'fnac.com';'priceminister.com';'pixmania.fr'};
magasin_keywords_reporting(current_magasin,my_entity,conn);

%% magasin reporting
current_magasin='dvd';
my_entity = {'amazon.fr';'fnac.com'};
magasin_keywords_reporting(current_magasin,my_entity,conn);

%% magasin reporting
current_magasin='livres-bd';
my_entity = {'amazon.fr';'fnac.com'};
magasin_keywords_reporting(current_magasin,my_entity,conn);

%% magasin reporting
current_magasin='jeux-pc-video-console';
my_entity = {'amazon.fr';'ebay.fr';'rueducommerce.fr';'darty.com';'fnac.com';'priceminister.com';'ldlc.com';'boulanger.fr';'french.alibaba.com';'pixmania.fr'};
magasin_keywords_reporting(current_magasin,my_entity,conn);

%% magasin reporting
current_magasin='juniors';
my_entity = {'aubert.com';'autourdebebe.com';'king-jouet.com';'toysrus.fr';'amazon.fr';'rueducommerce.fr';'fnac.com';'priceminister.com';'zalando.fr';'french.alibaba.com'};
magasin_keywords_reporting(current_magasin,my_entity,conn);

%% magasin reporting
current_magasin='high-tech';
my_entity = {'materiel.net';'pearl.fr';'amazon.fr';'ebay.fr';'rueducommerce.fr';'darty.com';'fnac.com';'priceminister.com';'ldlc.com';'boulanger.fr';'french.alibaba.com';'pixmania.fr'};
magasin_keywords_reporting(current_magasin,my_entity,conn);

%% magasin reporting
current_magasin='vin-champagne';
my_entity = {'auchan.fr';'vinatis.com'};
magasin_keywords_reporting(current_magasin,my_entity,conn);

%% magasin reporting
current_magasin='photo-numerique';
my_entity = {'materiel.net';'pearl.fr';'amazon.fr';'ebay.fr';'rueducommerce.fr';'darty.com';'fnac.com';'priceminister.com';'ldlc.com';'boulanger.fr';'french.alibaba.com';'pixmania.fr'};
magasin_keywords_reporting(current_magasin,my_entity,conn);

%% magasin reporting
current_magasin='bagages';
my_entity = {'amazon.fr';'ebay.fr';'rueducommerce.fr';'priceminister.com'};
magasin_keywords_reporting(current_magasin,my_entity,conn);

%% magasin reporting
current_magasin='electromenager';
my_entity = {'amazon.fr';'ebay.fr';'rueducommerce.fr';'conforama.fr';'darty.com';'priceminister.com';'french.alibaba.com'};
magasin_keywords_reporting(current_magasin,my_entity,conn);

%% magasin reporting
current_magasin='le-sport';
my_entity = {'amazon.fr';'ebay.fr';'rueducommerce.fr';'priceminister.com';'zalando.fr';'french.alibaba.com'};
magasin_keywords_reporting(current_magasin,my_entity,conn);

%% magasin reporting
current_magasin='telephonie';
my_entity = {'materiel.net';'pearl.fr';'amazon.fr';'ebay.fr';'rueducommerce.fr';'darty.com';'fnac.com';'priceminister.com';'ldlc.com';'boulanger.fr';'french.alibaba.com';'pixmania.fr'};
magasin_keywords_reporting(current_magasin,my_entity,conn);

%% magasin reporting
current_magasin='arts-loisirs';
my_entity = {'amazon.fr';'ebay.fr';'rueducommerce.fr';'fnac.com';'french.alibaba.com'};
magasin_keywords_reporting(current_magasin,my_entity,conn);

%% magasin reporting
current_magasin='pret-a-porter';
my_entity = {'amazon.fr';'ebay.fr';'rueducommerce.fr';'priceminister.com';'zalando.fr';'french.alibaba.com'};
magasin_keywords_reporting(current_magasin,my_entity,conn);

%% magasin reporting
current_magasin='chaussures';
my_entity = {'amazon.fr';'ebay.fr';'rueducommerce.fr';'priceminister.com';'zalando.fr';'french.alibaba.com'};
magasin_keywords_reporting(current_magasin,my_entity,conn);

%% magasin reporting
current_magasin='auto';
my_entity = {'amazon.fr';'ebay.fr';'rueducommerce.fr'};
magasin_keywords_reporting(current_magasin,my_entity,conn);

%% magasin reporting
current_magasin='maison';
my_entity = {'amazon.fr';'ebay.fr';'rueducommerce.fr';'conforama.fr';'priceminister.com'};
magasin_keywords_reporting(current_magasin,my_entity,conn);

%% magasin reporting
current_magasin='boutique-cadeaux';
magasin_keywords_reporting(current_magasin,my_entity,conn);

%% magasin reporting
current_magasin='bijouterie';
magasin_keywords_reporting(current_magasin,my_entity,conn);

%% magasin reporting
current_magasin='au-quotidien';
my_entity = {'amazon.fr';'ebay.fr';'rueducommerce.fr';'priceminister.com'};
magasin_keywords_reporting(current_magasin,my_entity,conn);

%% magasin reporting
current_magasin='jardin';
my_entity = {'amazon.fr';'ebay.fr';'rueducommerce.fr';'priceminister.com'};
magasin_keywords_reporting(current_magasin,my_entity,conn);

%% magasin reporting
current_magasin='animalerie';
my_entity = {'amazon.fr';'ebay.fr';'rueducommerce.fr';'priceminister.com'};
magasin_keywords_reporting(current_magasin,my_entity,conn);
%
% %% magasin reporting
% current_magasin='personnalisation-3d';
% magasin_keywords_reporting(current_magasin,my_entity,conn);
%
% %% magasin reporting
% current_magasin='destockage';
% magasin_keywords_reporting(current_magasin,my_entity,conn);
%
% %% magasin reporting
% current_magasin='Unknown';
% magasin_keywords_reporting(current_magasin,my_entity,conn);

%% Closing the connection
close(conn);



%%
