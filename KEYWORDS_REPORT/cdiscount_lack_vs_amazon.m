%% Mots clés où Amazon est et où nous ne sommes pas
%% Getting data from the database referential & storing it efficiently in memory
javaaddpath('C:\My_MathWorks_Work\PRODUCTS\postgresql-9.3-1102.jdbc4.jar');
setdbprefs ('DataReturnFormat', 'table');
conn = database('KEYWORDSDB','postgres','root','Vendor','PostgreSQL',...
    'Server','localhost');

%% Setting up magasins and concurrents
my_magasin ={'informatique';'musique-cd-dvd';'musique-instruments';'bricolage-chauffage';'culture-multimedia';'dvd';'livres-bd';'jeux-educatifs';'cadeaux-noel';'juniors';'jeux-pc-video-console';'high-tech';'vin-champagne';'photo-numerique';'animalerie';'bagages';'jardin-animalerie';'electromenager';'le-sport';'vin-alimentaire';'cosmetique';'telephonie';'arts-loisirs';'pret-a-porter';'soldes-promotions';'outillage';'chaussures';'destockage';'auto';'Unknown';'maison';'boutique-cadeaux';'salon-complet';'bijouterie';'au-quotidien';'jardin'};
for mag=1:length(my_magasin)
    %% Search position by search volume per magasin per entity 
    current_mag=my_magasin{mag};
    disp(['Current magasin ' current_mag])
    requesting_string=['select am_keyword, am_search_position, am_search_volume from AMAZON_VS_CDISCOUNT_PRICING where cd_keyword is null  and am_search_position <= 15 and magasin=''' current_mag ''' order by am_search_volume desc'];
    disp(requesting_string);
    setdbprefs ('DataReturnFormat', 'cellarray');
    curs = exec(conn, requesting_string);
    curs = fetch(curs);
    close(curs);
    data = curs.Data;
    disp(data);
end


%% Closing the connection
close(conn);

