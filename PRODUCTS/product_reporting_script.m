%% Report on the current number of products/skus
%% Getting data from the database referential & storing it efficiently in memory
javaaddpath('C:\My_MathWorks_Work\PRODUCTS\postgresql-9.3-1102.jdbc4.jar');
setdbprefs ('DataReturnFormat', 'table');
conn = database('PRODUITSDB','postgres','root','Vendor','PostgreSQL',...
    'Server','localhost');
curs = exec(conn, 'select * from magasin_produits order by report_date asc');
curs = fetch(curs);
close(curs);
%Assign data to output variable
data = curs.Data;
% Close database connection.
close(conn);

%% Filtering the data
magasin_index=strcmp(data.magasin,'TOTAL');
rayon_index=strcmp(data.rayon,'TOTAL')&~(magasin_index);
total = data(magasin_index,:);
magasin = data(rayon_index,:);
rayon = data(~(magasin_index | rayon_index),:);

%% Working the data to store it in memory efficiently
rayon.magasin=categorical(rayon.magasin);
rayon.rayon=categorical(rayon.rayon);
rayon.report_date=datenum(rayon.report_date,'yyyy-mm-dd');
% rayon.nb_skus_total=int32(rayon.nb_skus_total);
% rayon.nb_skus_total=int32(rayon.nb_skus_total);
% rayon.nb_skus_mp=int32(rayon.nb_skus_mp);
% rayon.nb_skus_cd=int32(rayon.nb_skus_cd);
% rayon.nb_skus_mixte=int32(rayon.nb_skus_mixte);
% rayon.nb_offre_exclu_mp=int32(rayon.nb_offre_exclu_mp);
% Working the data
magasin.magasin=categorical(magasin.magasin);
magasin.rayon=categorical(magasin.rayon);
magasin.report_date=datenum(magasin.report_date,'yyyy-mm-dd');
% magasin.nb_skus_total=int32(magasin.nb_skus_total);
% magasin.nb_skus_total=int32(magasin.nb_skus_total);
% magasin.nb_skus_mp=int32(magasin.nb_skus_mp);
% magasin.nb_skus_cd=int32(magasin.nb_skus_cd);
% magasin.nb_skus_mixte=int32(magasin.nb_skus_mixte);
% magasin.nb_offre_exclu_mp=int32(magasin.nb_offre_exclu_mp);
% Working the data
total.magasin=categorical(total.magasin);
total.rayon=categorical(total.rayon);
total.report_date=datenum(total.report_date,'yyyy-mm-dd');
% total.nb_skus_total=int32(total.nb_skus_total);
% total.nb_skus_total=int32(total.nb_skus_total);
% total.nb_skus_mp=int32(total.nb_skus_mp);
% total.nb_skus_cd=int32(total.nb_skus_cd);
% total.nb_skus_mixte=int32(total.nb_skus_mixte);
% total.nb_offre_exclu_mp=int32(total.nb_offre_exclu_mp);
my_magasins=unique(magasin.magasin);
my_rayons=unique(rayon.rayon);

%% Saving serialized data as a flat file
save('my_data.mat');


%% Evolution from the last report per magazin
percentage = zeros(length(my_magasins),5);
volume_change=zeros(length(my_magasins),1);
threshold=5;
for i=1:length(my_magasins)
    disp(['Evolution for magasin ' cellstr(my_magasins(i))]);
    filtered=magasin(magasin.magasin==my_magasins(i),:);
    magazin_matrix=[filtered.nb_skus_total,filtered.nb_skus_mp,filtered.nb_skus_cd,filtered.nb_skus_mixte,filtered.nb_offre_exclu_mp];
    percentage(i,:) = (magazin_matrix(end,:)-magazin_matrix(end-1,:))./magazin_matrix(end-1,:);
    volume_change(i,1)=magazin_matrix(end,1)-magazin_matrix(end-1,1);
end
mag_alerted = any(abs(percentage)>=threshold,2);

my_alerted_percentage=percentage(mag_alerted,:);
my_alerted__percent= mat2cell(my_alerted_percentage, ones(1,size(my_alerted_percentage,1)), ones(1,size(my_alerted_percentage,2)));
% my_percent=num2str(my_percent)
my_alerted__percent = cellfun(@myconversion,my_alerted__percent,'UniformOutput',false);

my_alerted_volume=volume_change(mag_alerted);
my_alerted_volume= mat2cell(my_alerted_volume, ones(1,size(my_alerted_volume,1)), ones(1,size(my_alerted_volume,2)));
my_alerted_volume=cellfun(@myvolconversion,my_alerted_volume,'UniformOutput',false);

my_alerted__percent = [cellstr(my_magasins(mag_alerted)),my_alerted__percent,my_alerted_volume];


headers={'Magasin','nb skus total','nb skus mp','nb skus cd','nb skus mixte','nb offre exclu mp','Volume'};
my_alerted__percent = [headers;my_alerted__percent];

% percentage = cell(percentage);
% my_percent= mat2cell(strcat(num2str(percentage),'%'), ones(1,size(percentage,1)), ones(1,size(percentage,2)));
my_percent= mat2cell(percentage, ones(1,size(percentage,1)), ones(1,size(percentage,2)));
% my_percent=num2str(my_percent)
my_percent = cellfun(@myconversion,my_percent,'UniformOutput',false);
volume_change= mat2cell(volume_change, ones(1,size(volume_change,1)), ones(1,size(volume_change,2)));
volume_change=cellfun(@myvolconversion,volume_change,'UniformOutput',false);
my_percent = [cellstr(my_magasins),my_percent,volume_change];
my_percent = [headers;my_percent];

%% Evolution from the last report per rayon
percentage = zeros(length(my_rayons),5);
volume_change=zeros(length(my_rayons),1);
for i=1:length(my_rayons)
    disp(['Evolution for rayon ' cellstr(my_rayons(i))]);
    filtered=rayon(rayon.rayon==my_rayons(i),:);
    rayon_matrix=[filtered.nb_skus_total,filtered.nb_skus_mp,filtered.nb_skus_cd,filtered.nb_skus_mixte,filtered.nb_offre_exclu_mp];
    try
        percentage(i,:) = (rayon_matrix(end,:)-rayon_matrix(end-1,:))./rayon_matrix(end-1,:);
        volume_change(i,1)=rayon_matrix(end,1)-rayon_matrix(end-1,1);
    catch exception
    end
end

ray_alerted = any(abs(percentage)>=threshold,2);

my_alerted_volume=volume_change(ray_alerted);
my_alerted_volume= mat2cell(my_alerted_volume, ones(1,size(my_alerted_volume,1)), ones(1,size(my_alerted_volume,2)));
my_alerted_volume=cellfun(@myvolconversion,my_alerted_volume,'UniformOutput',false);

alerted_percentage = percentage(ray_alerted,:);
% percentage = cell(percentage);
% my_percent= mat2cell(strcat(num2str(percentage),'%'), ones(1,size(percentage,1)), ones(1,size(percentage,2)));
my_alerted_ray_percent= mat2cell(alerted_percentage, ones(1,size(alerted_percentage,1)), ones(1,size(alerted_percentage,2)));
% my_percent=num2str(my_percent)
my_alerted_ray_percent = cellfun(@myconversion,my_alerted_ray_percent,'UniformOutput',false);
my_alerted_ray_percent = [cellstr(my_rayons(ray_alerted)),my_alerted_ray_percent,my_alerted_volume];
headers={'Rayon','nb skus total','nb skus mp','nb skus cd','nb skus mixte','nb offre exclu mp','Volume'};
my_alerted_ray_percent = [headers;my_alerted_ray_percent];

% percentage = cell(percentage);
% my_percent= mat2cell(strcat(num2str(percentage),'%'), ones(1,size(percentage,1)), ones(1,size(percentage,2)));
my_ray_percent= mat2cell(percentage, ones(1,size(percentage,1)), ones(1,size(percentage,2)));
% my_percent=num2str(my_percent)
my_ray_percent = cellfun(@myconversion,my_ray_percent,'UniformOutput',false);
volume_change= mat2cell(volume_change, ones(1,size(volume_change,1)), ones(1,size(volume_change,2)));
volume_change=cellfun(@myvolconversion,volume_change,'UniformOutput',false);
my_ray_percent = [cellstr(my_rayons),my_ray_percent,volume_change];
my_ray_percent = [headers;my_ray_percent];

%% Aggregated Cdiscount reporting
% concatenation
total_matrix=[total.nb_skus_total,total.nb_skus_mp,total.nb_skus_cd,total.nb_skus_mixte,total.nb_offre_exclu_mp];
total_matrix=ret2price(price2ret(total_matrix));
% visualization
figure;
plot(total.report_date, total_matrix);
legend('Nb total SKU','Nb SKU MP','Nb SKU CD','Nb SKU mixte', 'Nb Offre exclu','location','NW')
% axis tight;
datetick('x','mmm','keeplimits')
ylabel('Basis point as of 1st January');
title('Cdiscount level aggregated results')

%% Per magazin aggregated reporting

for i=1:length(my_magasins)
    disp(['Printing magazin ' num2str(i) ' from ' num2str(length(my_magasins)) ' magazins']);
    filtered=magasin(magasin.magasin==my_magasins(i),:);
    magazin_matrix=[filtered.nb_skus_total,filtered.nb_skus_mp,filtered.nb_skus_cd,filtered.nb_skus_mixte,filtered.nb_offre_exclu_mp];
    my_legend={'Nb total SKU','Nb SKU MP','Nb SKU CD','Nb SKU mixte', 'Nb Offre exclu','location','NW'};
    try
        magazin_matrix=ret2price(price2ret(magazin_matrix));
        %% Reporting for a specific magazin
        % visualization
        plot(filtered.report_date, magazin_matrix);
        legend(my_legend,'NW')
        datetick('x','mmm','keeplimits')
        ylabel('Basis point as of 1st January');
        title(strcat('Magazin--', cellstr(my_magasins(i))))
        delete(gcf);
    catch exception
        disp('Problem normalizing data');
    end
end

%% Per rayon aggregated reporting

for i=1:length(my_rayons)
    disp(['Printing rayon ' num2str(i) ' from ' num2str(length(my_rayons)) ' magazins']);
    filtered=rayon(rayon.rayon==my_rayons(i),:);
    rayon_matrix=[filtered.nb_skus_total,filtered.nb_skus_mp,filtered.nb_skus_cd,filtered.nb_skus_mixte,filtered.nb_offre_exclu_mp];
    my_legend={'Nb total SKU','Nb SKU MP','Nb SKU CD','Nb SKU mixte', 'Nb Offre exclu','location','NW'};
    try
        rayon_matrix=ret2price(price2ret(rayon_matrix));
        %% Reporting for a specific magazin
        % visualization
        plot(filtered.report_date, rayon_matrix);
        legend(my_legend,'NW')
        datetick('x','mmm','keeplimits')
        ylabel('Basis point as of 1st January');
        title(strcat('Rayon--',cellstr(my_rayons(i))))
        delete(gcf);
    catch exception
        disp('Problem normalizing data');
    end
end