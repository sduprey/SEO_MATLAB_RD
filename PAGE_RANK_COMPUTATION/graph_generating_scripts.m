
U={'home','meta_liste_produit1','meta_liste_produit2','liste_produit1','liste_produit2','liste_produit3','liste_produit4','fiche_produit1','fiche_produit2','fiche_produit3','fiche_produit4','fiche_produit5','fiche_produit6','fiche_produit7','fiche_produit8','fiche_produit9','fiche_produit10','fiche_produit11','fiche_produit12','fiche_produit13','fiche_produit14','fiche_produit15','fiche_produit16'};
G = [ ...
% home  meta_liste_produit1  meta_liste_produit2  liste_produit1  liste_produit2  liste_produit3  liste_produit4  fiche_produit1  fiche_produit2  fiche_produit3  fiche_produit4  fiche_produit5  fiche_produit6  fiche_produit7  fiche_produit8  fiche_produit9  fiche_produit10  fiche_produit11  fiche_produit12  fiche_produit13  fiche_produit14  fiche_produit15  fiche_produit16
% home         
  0          1                     1                     0              0                 0                0             0                0              0              0                0                0               0             0               0                 0                0                0                 0                0                0                0;...
% meta_liste_produit1
  0          0                     0                     1              1                 0                0             0                0              0              0                0                0               0             0               0                 0                0                0                 0                0                0                0;...
% meta_liste_produit2
  0          0                     0                     0              0                 1                1             0                0              0              0                0                0               0             0               0                 0                0                0                 0                0                0                0;...
% liste_produit1
  0          0                     0                     0              0                 0                0             1                1              1              1                0                0               0             0               0                 0                0                0                 0                0                0                0;...
% liste_produit2  
  0          0                     0                     0              0                 0                0             0                0              0              0                1                1               1             1               0                 0                0                0                 0                0                0                0;...
% liste_produit3 
  0          0                     0                     0              0                 0                0             0                0              0              0                0                0               0             0               1                 1                1                1                 0                0                0                0;...
% liste_produit4 
  0          0                     0                     0              0                 0                0             0                0              0              0                0                0               0             0               0                 0                0                0                 1                1                1                1;...
% fiche_produit1 
  0          0                     0                     0              0                 0                0             0                0              0              0                0                0               0             0               0                 0                0                0                 0                0                0                0;...
% fiche_produit2 
  0          0                     0                     0              0                 0                0             0                0              0              0                0                0               0             0               0                 0                0                0                 0                0                0                0;...
% fiche_produit3 
  0          0                     0                     0              0                 0                0             0                0              0              0                0                0               0             0               0                 0                0                0                 0                0                0                0;...
% fiche_produit4 
  0          0                     0                     0              0                 0                0             0                0              0              0                0                0               0             0               0                 0                0                0                 0                0                0                0;...
% fiche_produit5 
  0          0                     0                     0              0                 0                0             0                0              0              0                0                0               0             0               0                 0                0                0                 0                0                0                0;...
% fiche_produit6 
  0          0                     0                     0              0                 0                0             0                0              0              0                0                0               0             0               0                 0                0                0                 0                0                0                0;...
% fiche_produit7 
  0          0                     0                     0              0                 0                0             0                0              0              0                0                0               0             0               0                 0                0                0                 0                0                0                0;...
% fiche_produit8 
  0          0                     0                     0              0                 0                0             0                0              0              0                0                0               0             0               0                 0                0                0                 0                0                0                0;...
% fiche_produit9 
  0          0                     0                     0              0                 0                0             0                0              0              0                0                0               0             0               0                 0                0                0                 0                0                0                0;...
% fiche_produit10
  0          0                     0                     0              0                 0                0             0                0              0              0                0                0               0             0               0                 0                0                0                 0                0                0                0;...
% fiche_produit11
  0          0                     0                     0              0                 0                0             0                0              0              0                0                0               0             0               0                 0                0                0                 0                0                0                0;...
% fiche_produit12  
  0          0                     0                     0              0                 0                0             0                0              0              0                0                0               0             0               0                 0                0                0                 0                0                0                0;...
% fiche_produit13
  0          0                     0                     0              0                 0                0             0                0              0              0                0                0               0             0               0                 0                0                0                 0                0                0                0;...
% fiche_produit14
  0          0                     0                     0              0                 0                0             0                0              0              0                0                0               0             0               0                 0                0                0                 0                0                0                0;...
% fiche_produit15
  0          0                     0                     0              0                 0                0             0                0              0              0                0                0               0             0               0                 0                0                0                 0                0                0                0;...
% fiche_produit16
  0          0                     0                     0              0                 0                0             0                0              0              0                0                0               0             0               0                 0                0                0                 0                0                0                0;...
  ];


%% Visualizing the adjacency matrix
spy(G)
title('Visualizing the adjacency matrix')

%% Computing the page rank
pagerank;