[n,n] = size(G);
c = sum(G,1);
r = sum(G,2);

x = pagerankpow(G);

% Bar graph of page rank.

figure;
bar(x)
title('Page Rank')

% Print URLs in page rank order.

[ignore,q] = sort(-x);
disp('     page-rank  in  out  url')
k = 1;
while (k <= n) & (x(q(k)) >= .005)
  j = q(k);
  disp(sprintf(' %3.0f %8.4f %4.0f %4.0f  %s', ...
     j,x(j),r(j),c(j),U{j}))
  k = k+1;
end
