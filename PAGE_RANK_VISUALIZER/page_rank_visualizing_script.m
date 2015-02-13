%% Importing the data from the csv page rank computation export
load('page_rank_visualizing_script.mat');
refining_limit=0.00001;
very_refining_limit=0.000001;

%% Visualizing the page rank distribution for the whole magasin
disp(sum(pagerankmaison.page_rank));
figure;
hist(pagerankmaison.page_rank,100000)

%% Visualizing the page rank distribution for the whole magasin focusing on the origin
figure;
hist(pagerankmaison.page_rank,100000)
xlim([0 refining_limit])

%% Visualizing the page rank distribution for the whole magasin focusing on the origin
figure;
hist(pagerankmaison.page_rank,100000)
xlim([0 very_refining_limit])

%% Getting the 500 first URLs
[~,I] = sort(pagerankmaison.page_rank,'descend');
pagerankmaison = pagerankmaison(I,:);
disp(pagerankmaison(1:500,:));

%% Histogram per page types
page_types = unique(pagerankmaison.page_type);
for i=1:length(page_types)
    figure;
    filtering_index=(pagerankmaison.page_type == page_types(i));
    pagerankmaison_pagetype_fitered =pagerankmaison(filtering_index,:);
    hist(pagerankmaison_pagetype_fitered.page_rank,100000);
    axis tight;
    title(['Page rank distribution per' char(page_types(i))]);
    figure;
    hist(pagerankmaison_pagetype_fitered.page_rank,100000);
    xlim([0 refining_limit])
    title(['Refined page rank distribution per' char(page_types(i))]);
    figure;
    hist(pagerankmaison_pagetype_fitered.page_rank,100000);
    xlim([0 very_refining_limit])
    title(['Very refined page rank distribution per' char(page_types(i))]);
end

%% Histogram per depths
depths = unique(pagerankmaison.depth);
for i=1:length(depths)
    figure;
    filtering_index=(pagerankmaison.depth == depths(i));
    pagerankmaison_depth_fitered =pagerankmaison(filtering_index,:);
    hist(pagerankmaison_depth_fitered.page_rank,100000);
    title(['Page rank distribution per' char(depths(i))]);
    figure;
    hist(pagerankmaison_depth_fitered.page_rank,100000);
    title(['Refined page rank distribution per' char(depths(i))]);
    xlim([0 refining_limit])
    figure;
    hist(pagerankmaison_depth_fitered.page_rank,100000);
    title(['Very refined page rank distribution per' char(depths(i))]);
    xlim([0 very_refining_limit])
end
 


