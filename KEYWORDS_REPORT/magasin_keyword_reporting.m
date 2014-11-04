%% Reporting for the keywords referential
%% Getting data from the database referential & storing it efficiently in memory
javaaddpath('C:\My_MathWorks_Work\PRODUCTS\postgresql-9.3-1102.jdbc4.jar');
setdbprefs ('DataReturnFormat', 'table');
conn = database('KEYWORDSDB','postgres','root','Vendor','PostgreSQL',...
    'Server','localhost');

%% Setting up magasins and concurrents
my_magasin = {'informatique';'musique-cd-dvd';'musique-instruments';'dvd';'livres-bd';'jeux-pc-video-console';'juniors';'high-tech';'vin-champagne';'photo-numerique';'bagages';'electromenager';'le-sport';'telephonie';'arts-loisirs';'pret-a-porter';'chaussures';'destockage';'auto';'Unknown';'maison';'boutique-cadeaux';'bijouterie';'au-quotidien';'jardin';'personnalisation-3d';'animalerie'};
%my_entity = {'cdiscount.com';'amazon.fr';'ebay.fr';'rueducommerce.fr';'conforama.fr';'darty.com';'fnac.com';'priceminister.com';'zalando.fr';'ldlc.com';'boulanger.fr';'french.alibaba.com';'pixmania.fr'};

%% magasin reporting
current_magasin='informatique';
my_entity = {'cdiscount.com';'materiel.net';'pearl.fr';'amazon.fr';'ebay.fr';'rueducommerce.fr';'darty.com';'fnac.com';'priceminister.com';'ldlc.com';'boulanger.fr';'french.alibaba.com';'pixmania.fr'};
magasin_reporting(current_magasin,my_entity,conn);

%% magasin reporting
current_magasin='musique-cd-dvd';
my_entity = {'cdiscount.com';'amazon.fr';'ebay.fr';'rueducommerce.fr';'fnac.com';'priceminister.com';'pixmania.fr'};
magasin_reporting(current_magasin,my_entity,conn);

%% magasin reporting
current_magasin='musique-instruments';
my_entity = {'cdiscount.com';'amazon.fr';'ebay.fr';'rueducommerce.fr';'fnac.com';'priceminister.com';'pixmania.fr'};
magasin_reporting(current_magasin,my_entity,conn);

%% magasin reporting
current_magasin='dvd';
my_entity = {'cdiscount.com';'amazon.fr';'fnac.com'};
magasin_reporting(current_magasin,my_entity,conn);

%% magasin reporting
current_magasin='livres-bd';
my_entity = {'cdiscount.com';'amazon.fr';'fnac.com'};
magasin_reporting(current_magasin,my_entity,conn);

%% magasin reporting
current_magasin='jeux-pc-video-console';
my_entity = {'cdiscount.com';'amazon.fr';'ebay.fr';'rueducommerce.fr';'darty.com';'fnac.com';'priceminister.com';'ldlc.com';'boulanger.fr';'french.alibaba.com';'pixmania.fr'};
magasin_reporting(current_magasin,my_entity,conn);

%% magasin reporting
current_magasin='juniors';
my_entity = {'cdiscount.com';'aubert.com';'autourdebebe.com';'king-jouet.com';'toysrus.fr';'amazon.fr';'rueducommerce.fr';'fnac.com';'priceminister.com';'zalando.fr';'french.alibaba.com'};
magasin_reporting(current_magasin,my_entity,conn);

%% magasin reporting
current_magasin='high-tech';
my_entity = {'cdiscount.com';'materiel.net';'pearl.fr';'amazon.fr';'ebay.fr';'rueducommerce.fr';'darty.com';'fnac.com';'priceminister.com';'ldlc.com';'boulanger.fr';'french.alibaba.com';'pixmania.fr'};
magasin_reporting(current_magasin,my_entity,conn);

%% magasin reporting
current_magasin='vin-champagne';
my_entity = {'cdiscount.com';'auchan.fr';'vinatis.com'};
magasin_reporting(current_magasin,my_entity,conn);

%% magasin reporting
current_magasin='photo-numerique';
my_entity = {'cdiscount.com';'materiel.net';'pearl.fr';'amazon.fr';'ebay.fr';'rueducommerce.fr';'darty.com';'fnac.com';'priceminister.com';'ldlc.com';'boulanger.fr';'french.alibaba.com';'pixmania.fr'};
magasin_reporting(current_magasin,my_entity,conn);

%% magasin reporting
current_magasin='bagages';
my_entity = {'cdiscount.com';'amazon.fr';'ebay.fr';'rueducommerce.fr';'priceminister.com'};
magasin_reporting(current_magasin,my_entity,conn);

%% magasin reporting
current_magasin='electromenager';
my_entity = {'cdiscount.com';'amazon.fr';'ebay.fr';'rueducommerce.fr';'conforama.fr';'darty.com';'priceminister.com';'french.alibaba.com'};
magasin_reporting(current_magasin,my_entity,conn);

%% magasin reporting
current_magasin='le-sport';
my_entity = {'cdiscount.com';'amazon.fr';'ebay.fr';'rueducommerce.fr';'priceminister.com';'zalando.fr';'french.alibaba.com'};
magasin_reporting(current_magasin,my_entity,conn);

%% magasin reporting
current_magasin='telephonie';
my_entity = {'cdiscount.com';'materiel.net','pearl.fr','amazon.fr';'ebay.fr';'rueducommerce.fr';'darty.com';'fnac.com';'priceminister.com';'ldlc.com';'boulanger.fr';'french.alibaba.com';'pixmania.fr'};
magasin_reporting(current_magasin,my_entity,conn);

%% magasin reporting
current_magasin='arts-loisirs';
my_entity = {'cdiscount.com';'amazon.fr';'ebay.fr';'rueducommerce.fr';'fnac.com';'french.alibaba.com'};
magasin_reporting(current_magasin,my_entity,conn);

%% magasin reporting
current_magasin='pret-a-porter';
my_entity = {'cdiscount.com';'amazon.fr';'ebay.fr';'rueducommerce.fr';'priceminister.com';'zalando.fr';'french.alibaba.com'};
magasin_reporting(current_magasin,my_entity,conn);

%% magasin reporting
current_magasin='chaussures';
my_entity = {'cdiscount.com';'amazon.fr';'ebay.fr';'rueducommerce.fr';'priceminister.com';'zalando.fr';'french.alibaba.com'};
magasin_reporting(current_magasin,my_entity,conn);

%% magasin reporting
current_magasin='auto';
my_entity = {'cdiscount.com';'amazon.fr';'ebay.fr';'rueducommerce.fr'};
magasin_reporting(current_magasin,my_entity,conn);

%% magasin reporting
current_magasin='maison';
my_entity = {'cdiscount.com';'amazon.fr';'ebay.fr';'rueducommerce.fr';'conforama.fr';'priceminister.com'};
magasin_reporting(current_magasin,my_entity,conn);

%% magasin reporting
current_magasin='boutique-cadeaux';
magasin_reporting(current_magasin,my_entity,conn);

%% magasin reporting
current_magasin='bijouterie';
magasin_reporting(current_magasin,my_entity,conn);

%% magasin reporting
current_magasin='au-quotidien';
my_entity = {'cdiscount.com';'amazon.fr';'ebay.fr';'rueducommerce.fr';'priceminister.com'};
magasin_reporting(current_magasin,my_entity,conn);

%% magasin reporting
current_magasin='jardin';
my_entity = {'cdiscount.com';'amazon.fr';'ebay.fr';'rueducommerce.fr';'priceminister.com'};
magasin_reporting(current_magasin,my_entity,conn);

%% magasin reporting
current_magasin='animalerie';
my_entity = {'cdiscount.com';'amazon.fr';'ebay.fr';'rueducommerce.fr';'priceminister.com'};
magasin_reporting(current_magasin,my_entity,conn);
% 
% %% magasin reporting
% current_magasin='personnalisation-3d';
% magasin_reporting(current_magasin,my_entity,conn);
% 
% %% magasin reporting
% current_magasin='destockage';
% magasin_reporting(current_magasin,my_entity,conn);
% 
% %% magasin reporting
% current_magasin='Unknown';
% magasin_reporting(current_magasin,my_entity,conn);

%% Closing the connection
close(conn);

