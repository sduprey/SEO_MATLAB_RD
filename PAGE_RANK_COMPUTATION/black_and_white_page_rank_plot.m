function state = black_and_white_page_rank_plot(options,state,flag,trafic,U,coordinates,nb_nodes)
imagesc(state.Population);
axis tight;
xlabel('Link present'); ylabel('Individual in Population')
colormap([0 0 0; 1 1 1]); %set(gca,'XTick',1:size(pop,2))

% [unused,i] = min(state.Score);
% genotype = state.Population{i};
% GMATRIX=reshape(genotype,nb_nodes,nb_nodes);
% figure;
% spy(GMATRIX)
% title('Visualizing the adjacency matrix')
% figure;
% gplot(GMATRIX,coordinates)
% title('Graph layout')
% gObj = biograph(GMATRIX,U);
% figure;
% gObj = view(gObj); %#ok<*NASGU>
% disp('Number of links inside the site :')
% disp(sum(sum(GMATRIX)))


