function [percent_training,percent_validating] = validateTreeFitting(X,Y,nTrees,leafsize)
%VALIDATETREEFITTING Summary of this function goes here
%   Detailed explanation goes here
pt = cvpartition(Y,'holdout',0.5);
%  Extract predictors and responses for both sets
Y_t = Y(training(pt));
X_t = X(training(pt),:);
Y_v = Y(test(pt));
X_v = X(test(pt),:);

b = TreeBagger(nTrees, X_t, Y_t,'cat',6,'minleaf',leafsize);

predY = predict(b,X_t);
%
predY=ordinal(predY,[],{'0' '1'});
predY=(predY=='1');
percent_training = sum(double(predY) == double(Y_t))./length(Y_t);
disp(['Tree, % Good classified rate on training set  : ' num2str(percent_training*100)]);
%
%predY=ordinal(predY,[],{'AAA' 'AA' 'A' 'BBB' 'BB' 'B' 'CCC'});
%percent_training = sum(predY == Y_t)./length(Y_t);
%C_training = confusionmat(cellstr(Y_t),cellstr(predY),...
%    'order',{'AAA' 'AA' 'A' 'BBB' 'BB' 'B' 'CCC'});

%
predY = predict(b,X_v);
%
predY=ordinal(predY,[],{'0' '1'});
predY=(predY=='1');
percent_validating = sum(double(predY) == double(Y_v))./length(Y_v);
disp(['Tree, % Good classified rate on validating set  : ' num2str(percent_validating*100)]);
%
%predY=ordinal(predY,[],{'AAA' 'AA' 'A' 'BBB' 'BB' 'B' 'CCC'});
%percent_validating = sum(predY == Y_v)./length(Y_v);
%C_validating = confusionmat(cellstr(Y_v),cellstr(predY),...
%    'order',{'AAA' 'AA' 'A' 'BBB' 'BB' 'B' 'CCC'});
end

