function scores = page_rank_fitness(pop,trafic,U,nb_nodes)
disp('Entering the fitness function');
disp('Looping over each individual');
pop_size = size(pop,1);
scores = zeros(pop_size,1);
for i=1:pop_size
    G=pop(i,:)';
    GMATRIX=reshape(G,nb_nodes,nb_nodes);
    x=optimized_pagerank_power(U,GMATRIX);
    scores(i) = -sum(trafic.*x);
end

