%% Computing the adjacency matrix over the web
% this function needs access to the web
% [U,G] = surfer('http://www.harvard.edu',500);
% in case we don't, just fill up the matching matrixes hard coded way
G = [0 0 0 1 0 0; 1 0 0 0 0 0; 1 0 0 0 0 0; 0 1 1 0 1 0; 0 0 1 0 0 1; 0 0 0 1 0 0];
U={'url1','url2','url3','url4','url5','url6'};

%% Visualizing the adjacency matrix
spy(G)
title('Visualizing the adjacency matrix')
% n=length(U);
% %% Building the coordinates matrix
% coordinates = zeros(n,2);
% for i=1:n
%     coordinates(i,1)=rand;
%     coordinates(i,2)=rand;
% end
% gplot(G,coordinates);
% title('Visualizing the adjacency matrix')


%% Computing the page rank
pagerank;
