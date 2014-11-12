%% Loading computed data
load('global_results.mat');

% normalizing the keyword proportion
fixed_unknown_size =  40;
unknown_index=17;
percentage_keywords_per_magasin(unknown_index)=0;
percentage_keywords_per_magasin = percentage_keywords_per_magasin./sum(percentage_keywords_per_magasin) * 100;
percentage_keywords_per_magasin(unknown_index)=fixed_unknown_size;
percentage_keywords_per_magasin = percentage_keywords_per_magasin./sum(percentage_keywords_per_magasin) * 100;
% normalizing data
coverage_rate_per_entity_per_magasin(:,unknown_index) = coverage_rate_per_entity_per_magasin(:,unknown_index)./4;
normalizing_factor = repmat((coverage_rate_per_entity./sum(coverage_rate_per_entity_per_magasin,2)),1,size(coverage_rate_per_entity_per_magasin,2));
coverage_rate_per_entity_per_magasin=coverage_rate_per_entity_per_magasin.*normalizing_factor;

% computing the local coverage rate
percentage_matrix=repmat(percentage_keywords_per_magasin',size(coverage_rate_per_entity_per_magasin,1),1);
coverage_rate_local_per_entity_per_magasin=coverage_rate_per_entity_per_magasin.*percentage_matrix;




%% Reporting per magasin
header = {'Global Coverage rate', 'Average Position', 'Average Volume'};
row_header=my_entity;
all_mag_numbers_matrix=[coverage_rate_per_entity,average_search_position_per_entity,average_search_volume_per_entity];
whole_table = mat2rpttbl( all_mag_numbers_matrix, header, row_header', []);
whole_table{1}='Entity';
disp(whole_table);

for mag=1:length(my_magasin)
    %     format=[ repmat({'%0.2f%%'},1,2)];
    %     %format=[{'%,.2f%%' } repmat({'$%(,.2f'},1,length(beta))];
    %    % [{'%(,.2f$','%0.2f%%'} repmat({'$%(,.2f'},1,length(beta))
    header = {'Global Coverage rate', 'Inside magasin coverage rate', 'Average Position', 'Average Volume'};
    loc_magasin=my_magasin{mag};
    disp(['reporting for magasin' my_magasin{mag}]);
    local_avg_pos=average_search_position_per_entity_per_magasin(:,mag);
    local_avg_vol=average_search_volume_per_entity_per_magasin(:,mag);
    local_cov_rat=coverage_rate_per_entity_per_magasin(:,mag);
    local_local_cov_rat=coverage_rate_local_per_entity_per_magasin(:,mag);
    if (strcmp('Unknown',loc_magasin))
        local_local_cov_rat=local_local_cov_rat./10;
    end
    numbers_matrix=[local_cov_rat,local_local_cov_rat,local_avg_pos,local_avg_vol];
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
