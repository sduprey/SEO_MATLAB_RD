%% Parameters for the first middle size product list
% humour et jeux/l-10535
nb_product=436.*23; 
% with 23 products per page
% nb_page=436;
nb_page=436; %#ok<NASGU>
% the depth of click we want to explore
depth_click=10;
% total number of pages to display
Ntotal=436;
% total number of displayable references in pagination
Nlinks=15;
% notice that relevant cases are Ntotal >> Nlink
% padding parameter
Npadding=3;
% our pagination distribution computation
my_lp_distrib=@(x)concertina_compute_pagination(x, Nlinks, Npadding, Ntotal);

%% Computing the right, left and middle distributions
% when we land on the listing product page
% checking initial middle and end distribution
distribution=my_lp_distrib(202) %#ok<NOPTS,NASGU>
distribution=my_lp_distrib(1)%#ok<NOPTS,NASGU>
distribution=my_lp_distrib(436)%#ok<NOPTS,NASGU>

%% Computing the reached pages per number of clicks
% we compute the initial distribution
distribution=my_lp_distrib(1);
click=1;
my_evolving_distrib=cell(depth_click,1);
while (click <= depth_click)
    %  links_to_add instantiation
    new_list=[];
    for link=1:size(distribution,1)
        % we here compute the number of pages reachable at the variable click
        new_list = union(new_list,my_lp_distrib(distribution(link)));
    end
    my_evolving_distrib{click}=new_list;
    distribution=new_list;
    %  links_to_add=added_links+newlist
    % we here list the number of pages reached at click number
    click=click+1;
end

%% Visualizing the evolution
my_length_vector = cellfun(@length, my_evolving_distrib);
plot(1:size(my_evolving_distrib,1),my_length_vector,'-o');
xlabel('Nombre de clicks');
ylabel('Nombre de pages atteintes');
title(['Atteignabilité des pages pour ' num2str(nb_product) 'produits']);


%% Parameters for the second giant size product list
% batterie et chargeur
% batteries-chargeurs/l-1070929
nb_product=60297;
% with 23 products per page
% nb_page=26304;
nb_page=600297./23;
% the depth of click we want to explore
depth_click=280;
% total number of pages to display
Ntotal=26304;
% total number of displayable references in pagination
Nlinks=14;
% notice that relevant cases are Ntotal >> Nlink
% padding parameter
Npadding=3;
% our pagination distribution computation
% our pagination distribution computation
my_lp_distrib=@(x)concertina_compute_pagination(x, Nlinks, Npadding, Ntotal);

%% Computing the right, left and middle distributions
% when we land on the listing product page
% checking initial middle and end distribution
distribution=my_lp_distrib(13152) %#ok<NOPTS,NASGU>
distribution=my_lp_distrib(1)%#ok<NOPTS,NASGU>
distribution=my_lp_distrib(26304)%#ok<NOPTS,NASGU>

%% Computing the reached pages per number of clicks
% we compute the initial distribution
distribution=my_lp_distrib(1);
click=1;
my_evolving_distrib=cell(depth_click,1);
while (click <= depth_click)
    %  links_to_add instantiation
    new_list=[];
    for link=1:size(distribution,1)
        % we here compute the number of pages reachable at the variable click
        new_list = union(new_list,my_lp_distrib(distribution(link)));
    end
    my_evolving_distrib{click}=new_list;
    distribution=new_list;
    %  links_to_add=added_links+newlist
    % we here list the number of pages reached at click number
    click=click+1;
end


%% Visualizing the evolution
my_length_vector = cellfun(@length, my_evolving_distrib);
plot(1:size(my_evolving_distrib,1),my_length_vector,'-o');
xlabel('Nombre de clicks');
ylabel('Nombre de pages atteintes');
title(['Atteignabilité des pages pour ' num2str(nb_product) 'produits']);