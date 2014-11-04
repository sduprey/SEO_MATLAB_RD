%% Reporting for the keywords referential
%% Getting data from the database referential & storing it efficiently in memory
javaaddpath('C:\My_MathWorks_Work\PRODUCTS\postgresql-9.3-1102.jdbc4.jar');
setdbprefs ('DataReturnFormat', 'table');
conn = database('KEYWORDSDB','postgres','root','Vendor','PostgreSQL',...
    'Server','localhost');

%% Setting up magasins and concurrents
my_magasin ={'informatique';'musique-cd-dvd';'musique-instruments';'bricolage-chauffage';'culture-multimedia';'dvd';'livres-bd';'jeux-educatifs';'cadeaux-noel';'juniors';'jeux-pc-video-console';'high-tech';'vin-champagne';'photo-numerique';'animalerie';'bagages';'jardin-animalerie';'electromenager';'le-sport';'vin-alimentaire';'cosmetique';'telephonie';'arts-loisirs';'pret-a-porter';'soldes-promotions';'outillage';'chaussures';'destockage';'auto';'Unknown';'maison';'boutique-cadeaux';'salon-complet';'bijouterie';'au-quotidien';'jardin'};
my_entity = {'cdiscount.com';'amazon.fr';'rueducommerce.fr';'conforama.fr';'darty.com';'priceminister.com';'zalando.fr';'ldlc.com';'boulanger.fr';'french.alibaba.com';'pixmania.fr'};
% 
% current_mag='informatique';
% current_ent='cdiscount.com';
for conc=1:length(my_entity)
    current_ent = my_entity{conc};
    for mag=1:length(my_magasin)
        current_mag=my_magasin{mag};
        
        %% results order by search_volume by entity and by magasin
        requesting_string=['select keyword, search_position, search_volume from pricing_keywords where domain= ''' current_ent ''' and magasin=''' current_mag ''' order by search_volume desc'];
        setdbprefs ('DataReturnFormat', 'table');
        curs = exec(conn, requesting_string);
        curs = fetch(curs);
        close(curs);
        %% Search position by search volume per magasin per entity
        data = curs.Data;
        disp(data(1:min(size(data,1),400),:));
        
        
        %% results order by search_position by entity and by magasin
        requesting_string=['select keyword, search_position, search_volume from pricing_keywords where domain= ''' current_ent ''' and magasin=''' current_mag ''' order by search_position desc'];
        setdbprefs ('DataReturnFormat', 'numeric');
        curs = exec(conn, requesting_string);
        curs = fetch(curs);
        close(curs);
        %% Search volume by search position per magasin per entity
        data = curs.Data;
        data = curs.Data;
        disp(data(1:min(size(data,1),400),:));
        
    end
end



%  
%         
%         %% do not put in a loop over entity
%         %% results order by search_volume outside cdiscount and by magasin
%         requesting_string=['select keyword, search_position, search_volume from pricing_keywords where domain= not like ''cdiscount.com'' and magasin=''' current_mag ''' order by search_volume desc'];
%         setdbprefs ('DataReturnFormat', 'numeric');
%         curs = exec(conn, requesting_string);
%         curs = fetch(curs);
%         close(curs);
%         %Assign data to output variable
%         data = curs.Data;
%         %% Search volume by search position per magasin per entity
%  
%         for i=1:min(size(data,1),200)
%             disp(data(i,:));
%         end
%         
%         %% results order by search_position outside cdiscount and by magasin
%         requesting_string=['select keyword, search_position, search_volume from pricing_keywords where domain not like ''cdiscount.com'' and magasin=''' current_mag ''' order by search_position desc'];
%         setdbprefs ('DataReturnFormat', 'numeric');
%         curs = exec(conn, requesting_string);
%         curs = fetch(curs);
%         close(curs);
%         %Assign data to output variable
%         ddata = curs.Data;