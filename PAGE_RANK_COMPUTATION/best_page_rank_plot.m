function  best_page_rank_plot(best,nb_nodes,coordinates,U,weights)

GMATRIX=reshape(best,nb_nodes,nb_nodes);
pagerank_power(U,GMATRIX)
figure;
spy(GMATRIX)
title('Visualizing the adjacency matrix')
figure;
gplot(GMATRIX,coordinates)
hold on;
scatter(coordinates(:,1),coordinates(:,2),weights);
title('Trafic imbalance')
gObj = biograph(GMATRIX,U);
figure;
gObj = view(gObj); %#ok<*NASGU>
disp('Number of links inside the site :')
disp(sum(sum(GMATRIX)))


