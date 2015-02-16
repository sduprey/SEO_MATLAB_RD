%  Program: googleSim1.m
%  Author: Tim Chartier
%  Description:  
%   This program find the PageRank for a network where the network is 
%   created in the adjacency matrix G.  
%
%% Parameters you may wish to alter
numsims = 2000;  % Parameter controlling the number of simulations

% adjacency matrix of the network
G = [0 0 0 1 0 0; 1 0 0 0 0 0; 1 0 0 0 0 0; 0 1 1 0 1 0; 0 0 1 0 0 1; 0 0 0 1 0 0];
n = length(G);

%%  Monte Carlo Simulation on network given by adjacency matrix G
     
close all

state = 1;      % initial state of the system

M = zeros(n,n);
for i = 1:n;
    rowSum = sum(G(i,:));
    if (rowSum ~= 0)
       M(i,:) = 1/rowSum*G(i,:);
    end            
end

pages = zeros(1,n);   % vector to hold number of times page visited

% Simulate a surfer's session
computed_prob = [];
for i=1:numsims
    prob = rand;
    accumulated_prob = 0;
    flag = -1;
    
    for j = 1:n-1
      accumulated_prob = accumulated_prob + M(state,j);  
      if prob < accumulated_prob
          state = j;
          flag = j;
          break;
      end
    end;
    
    if flag==-1   % coded in case of round-off error
        state = n;
    end

    pages(state) = pages(state) + 1;

    if ~mod(i,numsims/5)
       computed_prob = [computed_prob; pages/sum(pages)];
%        fprintf('%6d       %5.3e   %5.3e   %5.3e   %5.3e   %5.3e \n',i,pages(1:5)/sum(pages));
    end
end

%% Give results in bar chart

bar(computed_prob(end,:))
convergence = max(abs(computed_prob(end,:)-computed_prob(end-1,:)));
text = sprintf('Convergence to %4.2e in all entries',convergence);
title(text);
axis tight

ranking = pages/sum(pages);
[sortedRanking, indices] = sort(ranking,'descend');
fprintf('\n****************************\n')
fprintf('     PageRank results\n')
fprintf('****************************\n')
fprintf('Web Page   PageRank\n')
fprintf('----------------------------\n')
for i=1:length(sortedRanking)
    fprintf('%5d       %5.3f \n',indices(i),sortedRanking(i));
end

fprintf('\nNote your connectivity matrix was: ')
G
