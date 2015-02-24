
k = 1:30;
[B,XY] = bucky;
gplot(B(k,k),XY(k,:),'-*')
axis square

%% every thing is fine
% Define the variables.
[B,V] = bucky;
H = sparse(60,60);
k = 31:60;
H(k,k) = B(k,k);

% Visualize the variables.
gplot(B-H,V,'b-');
hold on
gplot(H,V,'r-');
hold off
axis off equal

%%
% Define a matrix A.
A = [0 1 1 0 ; 1 0 0 1 ; 1 0 0 1 ; 0 1 1 0];

% % Draw a picture showing the connected nodes.
% cla
% subplot(1,2,1);
% gplot(A,[0 1;1 1;0 0;1 0],'.-');
% text([-0.2, 1.2 -0.2, 1.2],[1.2, 1.2, -.2, -.2],('1234')', ...
%     'HorizontalAlignment','center')
% axis([-1 2 -1 2],'off')
% 
% % Draw a picture showing the adjacency matrix.
% subplot(1,2,2);
% xtemp=repmat(1:4,1,4);
% ytemp=reshape(repmat(1:4,4,1),16,1)';
% text(xtemp-.5,ytemp-.5,char('0'+A(:)),'HorizontalAlignment','center');
% line([.25 0 0 .25 NaN 3.75 4 4 3.75],[0 0 4 4 NaN 0 0 4 4])
% axis off tight
% 
% subplot(1,1,1);
% gplot(B(1:30,1:30),V(1:30,:),'b-');
% for j = 1:30,
%     text(V(j,1),V(j,2),int2str(j),'FontSize',10);
% end
% axis off equal

spy(B(1:30,1:30))
title('spy(B(1:30,1:30))')


[B,V] = bucky;
H = sparse(60,60);
k = 31:60;
H(k,k) = B(k,k);
gplot(B-H,V,'b-');
hold on
gplot(H,V,'r-');
for j = 31:60
    text(V(j,1),V(j,2),int2str(j), ...
        'FontSize',10,'HorizontalAlignment','center');
end
hold off
axis off equal


spy(B)
title('spy(B)')


gplot(B-H,V,'b-');
axis off equal
hold on
gplot(H,V,'r-');
hold off