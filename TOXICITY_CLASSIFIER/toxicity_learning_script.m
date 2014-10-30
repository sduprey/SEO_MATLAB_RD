%% Importing data from the CSV file
% penguin = importfile('penguin.17-10-2014-20-10-2014-utf8.csv');
% save('penguin.mat');

%% Loading data
load('penguin.mat');

%% Data displaying
disp(penguin(1:20,:));

%% Continuous prediction
%% Predictor and output matrix building
% predictor matrix
X = [penguin.KeywordVolume penguin.KeywordCpc penguin.KeywordCompetition penguin.Pr penguin.Alexa penguin.RefPages penguin.RefDomains penguin.CitationFlow penguin.TrustFlow penguin.YesterdayPos penguin.ExactAnchorsRefDomains penguin.ExactAnchorsRefPages penguin.ContainingAnchorsRefDomains penguin.ContainingAnchorsRefPages];
% output vector we try to forecast penguin.TodayPos penguin.Change penguin.Change_abs
Y = penguin.Change;

%% Single regression tree
pt = cvpartition(Y,'holdout',0.5);
%  Extract predictors and responses for both sets
Y_t = Y(training(pt));
X_t = X(training(pt),:);
Y_v = Y(test(pt));
X_v = X(test(pt),:);

t = classregtree(X_t,Y_t);
%  See tree
view(t)

%% Tree performance on validating and training set : pruning the tree
% How well did the single tree perform on the training set
% very well but overfit the noise
predY = t(X_t);
disp('Full tree training set')

training_residus = predY-Y_t;
figure;
hist(training_residus,100)
title('Training histogram error');
figure;
plot(1:length(predY),predY,1:length(Y_t),Y_t);
title('Training point to point error');

errpct = abs(training_residus)./Y_t*100;
MAE = mean(abs(errpct));
disp(MAE);
% Calculate the single tree's predictions on the validating set...
predY = t(X_v);
disp('Full tree validating set')
figure;
plot(1:length(predY),predY,1:length(Y_v),Y_v);
title('Validating point to point error');

validating_residus = predY-Y_v;
figure;
hist(validating_residus,100)
title('Validating histogram error');

errpct = abs(validating_residus)./Y_v*100;
MAE = mean(abs(errpct));
disp(MAE);

%% Discontinuous prediction

%% Predictor and output matrix building
% predictor matrix
X = [penguin.KeywordVolume penguin.KeywordCpc penguin.KeywordCompetition penguin.Pr penguin.Alexa penguin.RefPages penguin.RefDomains penguin.CitationFlow penguin.TrustFlow penguin.YesterdayPos penguin.ExactAnchorsRefDomains penguin.ExactAnchorsRefPages penguin.ContainingAnchorsRefDomains penguin.ContainingAnchorsRefPages];
% output vector we try to forecast penguin.TodayPos penguin.Change penguin.Change_abs
Y = penguin.Change <= -7;

%% Single regression tree
pt = cvpartition(Y,'holdout',0.5);
%  Extract predictors and responses for both sets
Y_t = Y(training(pt));
X_t = X(training(pt),:);
Y_v = Y(test(pt));
X_v = X(test(pt),:);

t = classregtree(X_t,Y_t);
%  See tree
view(t)

%% Tree performance on validating and training set : pruning the tree
% How well did the single tree perform on the training set
% very well but overfit the noise
predY = t(X_t);
disp('Full tree training set')
testErrorRate(predY,Y_t);

% Calculate the single tree's predictions on the validating set...
predY = t(X_v);
disp('Full tree validating set')
testErrorRate(predY,Y_v);

% % %% Pruning the single tree by estimating the cost on the validating set
% % [cost,secost,ntnodes,bestlevel] = test(t, 'test', X_v, Y_v);
% % topt = prune(t, 'level', bestlevel);
% % view(topt)
% % 
% % % Pruned tree is better on the validating set !
% % % does not overfit the noise
% % predY = topt(X_v);
% % disp('Pruned tree validating set')
% % testErrorRate(predY,Y_v );

%% Bootstrapped aggregated  tree
nTrees = 50;
tic;
b = TreeBagger(nTrees, X_t, Y_t);

% Prediction on the training set
[predY,allpred,devs] = predict(b,X_t);
disp('Bagged trees training set')
testErrorRate(predY,Y_t);

% Prediction on the validating set
[predY,allpred,devs] = predict(b,X_v);
disp('Bagged trees validating set')
testErrorRate(predY,Y_v);

%% Parallel bootstrapped aggregated  tree
%  crossval, jackknife, bootstrp
nTrees = 50;
matlabpool open local;
opt = statset('UseParallel','always');
tic;
b = TreeBagger(nTrees, X, Y, 'opt',opt);
toc;
matlabpool close;

%% Performance computation
nb_trees_step =100:100:1000;
times = zeros(10,2);
for i=1:length(nb_trees_step)
    % Sequential computation
    nTrees = nb_trees_step(i);
    tic;
    b = TreeBagger(nTrees, X, Y);
    times(i,1)=toc;
    % Parallel computation
    opt = statset('UseParallel','always');
    matlabpool open local;
    tic;
    b = TreeBagger(nTrees, X, Y, 'opt',opt);
    times(i,2)=toc;
    matlabpool close;
end
plot(times);
legend({'Non Parallel', 'Parallel'})
xlabel('number of grown trees')
ylabel('second times for calibration')
title('\bf Calibration time for bagged trees : parallel vs non-parallel')

%% Which leaf size is the best for the tree : once again prune the bagged trees
nTrees = 50;
b = TreeBagger(nTrees, X_t, Y_t, 'oobpred','on');
err=oobError(b);
plot(err);
xlabel('number of grown trees')
ylabel('out-of-bag classification error')

leaf = [1 5 10];
nTrees = 25;
color = 'bgr';
for ii = 1:length(leaf)
    b = TreeBagger(nTrees,X,Y,'oobpred','on','cat',6,'minleaf',leaf(ii));
    plot(b.oobError,color(ii));
    hold on;
    [percent_training,percent_validating] = validateTreeFitting(X,Y,nTrees,leaf(ii));
    disp(['% Training set validation rate with leaf size' num2str(leaf(ii)) ' : ' num2str(percent_training*100)]);
    disp(['% Validating set validation rate with leaf size' num2str(leaf(ii)) ' : ' num2str(percent_validating*100)]);
end
xlabel('Number of grown trees');
ylabel('Out-of-bag classification error');
legend({'1', '5', '10'},'Location','NorthEast');
title('Classification Error for Different Leaf Sizes');
hold off;



%% Feature selection
% The errors are comparable for the three leaf-size options. We will
% therefore work with a leaf size of 10, because it results in leaner trees
% and more efficient computations.
%
% Note that we did not have to split the data into _training_ and _test_
% subsets. This is done internally, it is implicit in the sampling
% procedure that underlies the method. At each bootstrap iteration, the
% bootstrap replica is the training set, and any customers left out
% ("out-of-bag") are used as test points to estimate the out-of-bag
% classification error reported above.
%
% Next, we want to find out whether all the features are important for the
% accuracy of our classifier. We do this by turning on the _feature
% importance_ measure (|oobvarimp|), and plot the results to visually find
% the most important features. We also try a larger number of trees now,
% and store the classification error, for further comparisons below.

nTrees = 50;
leaf = 10;
b = TreeBagger(nTrees,X,Y,'oobvarimp','on','cat',6,'minleaf',leaf);

bar(b.OOBPermutedVarDeltaError);
xlabel('Feature number');
ylabel('Out-of-bag feature importance');
title('Feature importance results');

oobErrorFullX = b.oobError;
