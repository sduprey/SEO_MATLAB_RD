%% Loading computed data
load('global_results.mat');
load('page_type_data.mat');

%we just keep the entity from 1 to 11
entity_to_keep=1:10;

%% building the table


%%Reporting per magasin
    header = {'Coverage rate', 'average position', 'average volume'};
    row_header=my_entity(entity_to_keep);
    
    all_mag_numbers_matrix=[coverage_rate_per_entity(entity_to_keep),average_search_position_per_entity(entity_to_keep),average_search_volume_per_entity(entity_to_keep)];
    whole_table = mat2rpttbl( all_mag_numbers_matrix, header, row_header', []);
    whole_table{1}='Entity';
    disp(whole_table);
    
for mag=1:length(my_magasin)
   
    
    %     format=[ repmat({'%0.2f%%'},1,2)];
%     %format=[{'%,.2f%%' } repmat({'$%(,.2f'},1,length(beta))];
%    % [{'%(,.2f$','%0.2f%%'} repmat({'$%(,.2f'},1,length(beta))

    loc_magasin=my_magasin{mag};
    disp(['reporting for magasin' my_magasin{mag}]);
    local_avg_pos=average_search_position_per_entity_per_magasin(entity_to_keep,mag);
    local_avg_vol=average_search_volume_per_entity_per_magasin(entity_to_keep,mag);
    local_cov_rat=coverage_rate_per_entity_per_magasin(entity_to_keep,mag);
    numbers_matrix=[local_cov_rat,local_avg_pos,local_avg_vol];
    whole_table = mat2rpttbl( numbers_matrix, header, row_header', []);
    whole_table{1}='Entity';
    disp(whole_table);

    
%     %% Comparing concurrency for each magasin
%     h=figure('Name',['Macro' my_magasin{mag}],'toolbar','none','menubar','none','units','pixels','position',[10 10 5000 7250]);
%     % we compare cdiscount to every other concurrents
%     scatter(local_avg_pos,local_avg_vol,amplifying_factor*local_cov_rat);
%     xlabel('Average Search Position');
%     ylabel('Average Search Volume');
%     text(local_avg_pos,local_avg_vol,my_entity);
%     title(['Magasin ' loc_magasin])
end
