%% Loading computed data
load('global_results.mat');
load('page_type_data.mat');
amplifying_factor = 100;
entity_to_keep=1:10;

my_entity=my_entity(entity_to_keep);
coverage_rate_per_entity=coverage_rate_per_entity(entity_to_keep);
average_search_position_per_entity=average_search_position_per_entity(entity_to_keep);
average_search_volume_per_entity=average_search_volume_per_entity(entity_to_keep);

average_search_position_per_entity_per_magasin=average_search_position_per_entity_per_magasin(entity_to_keep,:);
average_search_volume_per_entity_per_magasin=average_search_volume_per_entity_per_magasin(entity_to_keep,:);
coverage_rate_per_entity_per_magasin=coverage_rate_per_entity_per_magasin(entity_to_keep,:);

%% Putting all entities together in a 2d scatter plot where coverage rate is the size of the marker
h=figure('Name','Macro_all_entity_2d','toolbar','none','menubar','none','units','pixels','position',[10 10 1000 1250]);
scatter(average_search_position_per_entity,average_search_volume_per_entity,amplifying_factor*coverage_rate_per_entity);
xlabel('Average Search Position');
ylabel('Average Search Volume');
text(average_search_position_per_entity,average_search_volume_per_entity,my_entity);
title('Concurrency overview for position, volume and coverage on a 2d graph')
saveas(h,['Macro_all_entity_2d' '.jpg'],'jpg');

%% Putting all entities together in a 3d scatter plot
h=figure('Name','Macro_all_entity_3d','toolbar','none','menubar','none','units','pixels','position',[10 10 1000 1250],'Color',[1 1 1]);
scatter3(average_search_position_per_entity,average_search_volume_per_entity,coverage_rate_per_entity);
xlabel('Average Search Position');
ylabel('Average Search Volume');
zlabel('Coverage rate');
text(average_search_position_per_entity,average_search_volume_per_entity,coverage_rate_per_entity,my_entity);
title('Concurrency overview for position, volume and coverage on a 3d graph')
saveas(h,['Macro_all_entity_3d' '.jpg'],'jpg');
for mag=1:length(my_magasin)
    %% Comparing concurrency for each magasin
    disp(my_magasin{mag});
    h=figure('Name',['Macro' my_magasin{mag}],'toolbar','none','menubar','none','units','pixels','position',[10 10 5000 7250]);
    % we compare cdiscount to every other concurrents
    loc_magasin=my_magasin{mag};
    local_avg_pos=average_search_position_per_entity_per_magasin(:,mag);
    local_avg_vol=average_search_volume_per_entity_per_magasin(:,mag);
    local_cov_rat=coverage_rate_per_entity_per_magasin(:,mag);
    scatter(local_avg_pos,local_avg_vol,amplifying_factor*local_cov_rat);
    xlabel('Average Search Position');
    ylabel('Average Search Volume');
    text(local_avg_pos,local_avg_vol,my_entity);
    title(['Magasin ' loc_magasin])
    saveas(h,['Macro_' my_magasin{mag} '.jpg'],'jpg');
end

% %% Reporting per page type
% %% Cdiscount Vitrine pages analysis
% type='Vitrine';
% display_pagetype_reporting(type,vitrine_data);
% 
% %% Cdiscount fiche produit pages analysis
% type='Fiche produit';
% display_pagetype_reporting(type,fiche_produit_data);
% 
% %% Cdiscount liste produit filtre pages analysis
% type='Liste produit filtre';
% display_pagetype_reporting(type,liste_produit_filtre_data);
% 
% %% Cdiscount page marque pages analysis
% type='Page Marque';
% display_pagetype_reporting(type,page_marque_data);
% 
% %% Cdiscount page concept pages analysis
% type='Page Concept';
% display_pagetype_reporting(type,page_concept_data);
% 
% %% Cdiscount SearchDexing pages analysis
% type='SearchDexing';
% display_pagetype_reporting(type,search_dexing_data);
% 
% %% Getting data from the database referential & storing it efficiently in memory
% javaaddpath('C:\My_MathWorks_Work\PRODUCTS\postgresql-9.3-1102.jdbc4.jar');
% setdbprefs ('DataReturnFormat', 'table');
% conn = database('KEYWORDSDB','postgres','root','Vendor','PostgreSQL',...
%     'Server','localhost');
% 
% %% magasin reporting
% current_magasin='informatique';
% my_entity = {'cdiscount.com';'materiel.net';'pearl.fr';'amazon.fr';'rueducommerce.fr';'darty.com';'fnac.com';'priceminister.com';'ldlc.com';'boulanger.fr';'french.alibaba.com';'pixmania.fr'};
% magasin_reporting(current_magasin,my_entity,conn);
% 
% %% magasin reporting
% current_magasin='musique-cd-dvd';
% my_entity = {'cdiscount.com';'amazon.fr';'rueducommerce.fr';'fnac.com';'priceminister.com';'pixmania.fr'};
% magasin_reporting(current_magasin,my_entity,conn);
% 
% %% magasin reporting
% current_magasin='musique-instruments';
% my_entity = {'cdiscount.com';'amazon.fr';'ebay.fr';'rueducommerce.fr';'fnac.com';'priceminister.com';'pixmania.fr'};
% magasin_reporting(current_magasin,my_entity,conn);
% 
% %% magasin reporting
% current_magasin='dvd';
% my_entity = {'cdiscount.com';'amazon.fr';'fnac.com'};
% magasin_reporting(current_magasin,my_entity,conn);
% 
% %% magasin reporting
% current_magasin='livres-bd';
% my_entity = {'cdiscount.com';'amazon.fr';'fnac.com'};
% magasin_reporting(current_magasin,my_entity,conn);
% 
% %% magasin reporting
% current_magasin='jeux-pc-video-console';
% my_entity = {'cdiscount.com';'amazon.fr';'ebay.fr';'rueducommerce.fr';'darty.com';'fnac.com';'priceminister.com';'ldlc.com';'boulanger.fr';'french.alibaba.com';'pixmania.fr'};
% magasin_reporting(current_magasin,my_entity,conn);
% 
% %% magasin reporting
% current_magasin='juniors';
% my_entity = {'cdiscount.com';'aubert.com';'autourdebebe.com';'king-jouet.com';'toysrus.fr';'amazon.fr';'rueducommerce.fr';'fnac.com';'priceminister.com';'zalando.fr';'french.alibaba.com'};
% magasin_reporting(current_magasin,my_entity,conn);
% 
% %% magasin reporting
% current_magasin='high-tech';
% my_entity = {'cdiscount.com';'materiel.net';'pearl.fr';'amazon.fr';'ebay.fr';'rueducommerce.fr';'darty.com';'fnac.com';'priceminister.com';'ldlc.com';'boulanger.fr';'french.alibaba.com';'pixmania.fr'};
% magasin_reporting(current_magasin,my_entity,conn);
% 
% %% magasin reporting
% current_magasin='vin-champagne';
% my_entity = {'cdiscount.com';'auchan.fr';'vinatis.com'};
% magasin_reporting(current_magasin,my_entity,conn);
% 
% %% magasin reporting
% current_magasin='photo-numerique';
% my_entity = {'cdiscount.com';'materiel.net';'pearl.fr';'amazon.fr';'ebay.fr';'rueducommerce.fr';'darty.com';'fnac.com';'priceminister.com';'ldlc.com';'boulanger.fr';'french.alibaba.com';'pixmania.fr'};
% magasin_reporting(current_magasin,my_entity,conn);
% 
% %% magasin reporting
% current_magasin='bagages';
% my_entity = {'cdiscount.com';'amazon.fr';'rueducommerce.fr';'priceminister.com'};
% magasin_reporting(current_magasin,my_entity,conn);
% 
% %% magasin reporting
% current_magasin='electromenager';
% my_entity = {'cdiscount.com';'amazon.fr';'rueducommerce.fr';'conforama.fr';'darty.com';'priceminister.com';'french.alibaba.com'};
% magasin_reporting(current_magasin,my_entity,conn);
% 
% %% magasin reporting
% current_magasin='le-sport';
% my_entity = {'cdiscount.com';'amazon.fr';'rueducommerce.fr';'priceminister.com';'zalando.fr';'french.alibaba.com'};
% magasin_reporting(current_magasin,my_entity,conn);
% 
% %% magasin reporting
% current_magasin='telephonie';
% my_entity = {'cdiscount.com';'materiel.net';'pearl.fr';'amazon.fr';'ebay.fr';'rueducommerce.fr';'darty.com';'fnac.com';'priceminister.com';'ldlc.com';'boulanger.fr';'french.alibaba.com';'pixmania.fr'};
% magasin_reporting(current_magasin,my_entity,conn);
% 
% %% magasin reporting
% current_magasin='arts-loisirs';
% my_entity = {'cdiscount.com';'amazon.fr';'ebay.fr';'rueducommerce.fr';'fnac.com';'french.alibaba.com'};
% magasin_reporting(current_magasin,my_entity,conn);
% 
% %% magasin reporting
% current_magasin='pret-a-porter';
% my_entity = {'cdiscount.com';'amazon.fr';'ebay.fr';'rueducommerce.fr';'priceminister.com';'zalando.fr';'french.alibaba.com'};
% magasin_reporting(current_magasin,my_entity,conn);
% 
% %% magasin reporting
% current_magasin='chaussures';
% my_entity = {'cdiscount.com';'amazon.fr';'rueducommerce.fr';'priceminister.com';'zalando.fr';'french.alibaba.com'};
% magasin_reporting(current_magasin,my_entity,conn);
% 
% %% magasin reporting
% current_magasin='auto';
% my_entity = {'cdiscount.com';'amazon.fr';'rueducommerce.fr'};
% magasin_reporting(current_magasin,my_entity,conn);
% 
% %% magasin reporting
% current_magasin='maison';
% my_entity = {'cdiscount.com';'amazon.fr';'rueducommerce.fr';'conforama.fr';'priceminister.com'};
% magasin_reporting(current_magasin,my_entity,conn);
% 
% %% magasin reporting
% current_magasin='boutique-cadeaux';
% my_entity = {'cdiscount.com';'amazon.fr';'rueducommerce.fr';'priceminister.com'};
% magasin_reporting(current_magasin,my_entity,conn);
% 
% %% magasin reporting
% current_magasin='bijouterie';
% my_entity = {'cdiscount.com';'amazon.fr';'rueducommerce.fr';'priceminister.com'};
% magasin_reporting(current_magasin,my_entity,conn);
% 
% %% magasin reporting
% current_magasin='au-quotidien';
% my_entity = {'cdiscount.com';'amazon.fr';'ebay.fr';'rueducommerce.fr';'priceminister.com'};
% magasin_reporting(current_magasin,my_entity,conn);
% 
% %% magasin reporting
% current_magasin='jardin';
% my_entity = {'cdiscount.com';'amazon.fr';'ebay.fr';'rueducommerce.fr';'priceminister.com'};
% magasin_reporting(current_magasin,my_entity,conn);
% 
% %% magasin reporting
% current_magasin='animalerie';
% my_entity = {'cdiscount.com';'amazon.fr';'ebay.fr';'rueducommerce.fr';'priceminister.com'};
% magasin_reporting(current_magasin,my_entity,conn);
% 
% %%
% close(conn);