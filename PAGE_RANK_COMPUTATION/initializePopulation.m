function pop = initializePopulation(popSize,nb_nodes)

%% Generate Population
pop = randi([0 1],[popSize,nb_nodes*nb_nodes]);

