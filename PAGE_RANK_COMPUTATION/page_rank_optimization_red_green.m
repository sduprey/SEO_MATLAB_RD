%% Initial configuration : siloing with reciprocating links
warning('OFF'); %#ok<*WNOFF>
rng('default');
% URL name
U={'home','meta_liste_produit1','meta_liste_produit2','liste_produit1','liste_produit2','liste_produit3','liste_produit4','fiche_produit1','fiche_produit2','fiche_produit3','fiche_produit4','fiche_produit5','fiche_produit6','fiche_produit7','fiche_produit8','fiche_produit9','fiche_produit10','fiche_produit11','fiche_produit12','fiche_produit13','fiche_produit14','fiche_produit15','fiche_produit16'};
% coordinates
coordinates = [0,0;-7,-2;7,-2;-10,-4;-4,-4; 4,-4;10,-4;-13,-6;-12,-6;-8,-6;-7,-6;-6,-6;-5,-6;-3,-6;-2,-6;2,-6;3,-6; 5,-6; 6,-6;7,-6; 8,-6;12,-6;13,-6;];
% adjacency matrix : to become spare
nb_nodes=length(U);
%trafic = [100;80;55;40;35;25;20;4;5;3;2;8;7;10;2;1;4;5;2;3;1;2;3];
weights = [10;10;10;8;7;2;3;4;5;3;2;8;7;7;2;1;4;5;2;3;1;2;3];
trafic = weights./sum(weights);

%% Implementing a global optimization algorithm
%% Objective function
% % renormalizing the trafic
% trafic = trafic ./ sum(trafic);
% the vector to optimize is the adjacency matrix
fitness = @(x) page_rank_fitness(x,trafic,U,nb_nodes);

%% Plotting function
my_plot = @(options,state,flag) page_rank_plot(options, ...
    state,flag,trafic,U,coordinates,nb_nodes);

%% Generate initial population
% Generate initial population of random graphs
% we'll use to seed the search space.
close all
population_size = 500;
pop = initializePopulation(population_size,nb_nodes);
imagesc(pop)
xlabel('Link present'); ylabel('Individual in Population')
colormap([1 0 0; 0 1 0]); %set(gca,'XTick',1:size(pop,2))

%% Testing the objective function over the initial population
fitness(pop);

%% Solve With Genetic Algorithm
% Find best trading rule and maximum Sharpe ratio (min -Sharpe ratio)
options = gaoptimset('Display','iter','PopulationType','bitstring',...
    'PopulationSize',size(pop,1),...
    'InitialPopulation',pop,...
    'PlotFcns', my_plot,...
    'Vectorized','on');
%     'CrossoverFcn', @crossover,...
%     'MutationFcn', @mutation,...

[best,minSh] = ga(fitness,size(pop,2),[],[],[],[],[],[],[],options)

disp('Best configuration score');
disp(minSh)

%% Visualizing the best element

best_page_rank_plot(best,nb_nodes,coordinates,U,weights)