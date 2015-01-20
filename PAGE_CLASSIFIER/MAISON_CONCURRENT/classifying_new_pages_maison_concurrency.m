%% Machine Learning for e-commerce web page page type classification
% Implementing and comparing different machine learning techniques to
% choose the best approach can be challenging. Machine learning is
% synonymous with *Non-parametric* modeling techniques. The term
% non-parametric is not meant to imply that such models completely lack
% parameters but that the number and nature of the parameters are flexible
% and determined from data.

%% Loading data
load('multiple_source_crawl_cdiscount_maison.mat');
disp('Predictors used for the e-commerce page type classification algorithm : ');
for i=1:length(catPred)
    disp(catPred{i});
end

%% Cross Validation Hold Out
% Cross validation is almost an inherent part of machine learning. Cross
% validation may be used to compare the performance of different predictive
% modeling techniques. In this example, we use holdout validation. Other
% techniques including k-fold and leave-one-out cross validation are also
% available.
%
% In this example, we partition the data into training set and test set.
% The training set will be used to calibrate/train the model parameters.
% The trained model is then used to make a prediction on the test set.
% Predicted values will be compared with actual data to compute the
% confusion matrix. Confusion matrix is one way to visualize the
% performance of a machine learning technique.

% In this example, we will hold 40% of the data, selected randomly, for
% test phase.
cv = cvpartition(length(Y),'holdout',0.40);

% Training set
Xtrain = X(training(cv),:);
Ytrain = Y(training(cv),:);
% Test set
Xtest = X(test(cv),:);
Ytest = Y(test(cv),:);

disp('Training Set')
tabulate(Ytrain)
disp('Test Set')
tabulate(Ytest)

%% Single Tree performance on training and testing set
t = classregtree(Xtrain,Ytrain);
%  See tree
view(t)
% How well did the single tree perform on the training set
% very well but overfit the noise
predY = t(Xtrain);
%predY = round(predY);
disp('Single tree : we forecast on the training set where the algorithm has been trained')
disp('Full tree training set')
myCategoricalErrorRate(predY,Ytrain);
C_tree = confusionmat(categorical(predY),categorical(Ytrain));
% Examine the confusion matrix for each class as a percentage of the true class
C_tree = bsxfun(@rdivide,C_tree,sum(C_tree,2)) * 100 %#ok<NASGU,*NOPTS>

% Calculate the single tree's predictions on the validating set...
predY = t(Xtest);
disp('Single tree : we forecast on the testing set where the algorithm has not been trained')
disp('Full tree testing set')
myCategoricalErrorRate(predY,Ytest);
[C_tree, order] = confusionmat(categorical(predY),categorical(Ytest));
% Examine the confusion matrix for each class as a percentage of the true class
C_tree = bsxfun(@rdivide,C_tree,sum(C_tree,2)) * 100 %#ok<*NOPTS>
order

%% Single tree forecast on the validating set
disp('Single tree : we forecast on the brand new set : other sites delamaison.fr, lamaisonduconvertible.fr, habitat.fr, enviedemeubles.com');
disp('Full tree validating set')
predYval = t(Xval);
tabulate(predYval);

%% Bootstrapped aggregated trees
% we calibrate the forest with 70 trees and we keep all predictors
tb = TreeBagger(150,Xtrain,Ytrain,'method','classification','OOBVarImp','on');
disp('Forest trees : we forecast on the training set where the algorithm has been trained')
disp('Full forest tree training set')
% Make a prediction for the test set
[Y_train_tb, classifScore_train] = tb.predict(Xtrain);
myCategoricalErrorRate(Y_train_tb,Ytrain);
% Compute the confusion matrix
[C_tb, order] = confusionmat(categorical(Ytrain),categorical(Y_train_tb));
% Examine the confusion matrix for each class as a percentage of the true class
C_tb = bsxfun(@rdivide,C_tb,sum(C_tb,2)) * 100 %#ok<NASGU>
order
disp('Forest tree : we forecast on the testing set where the algorithm has not been trained')
disp('Full forest tree testing set')
% Make a prediction for the test set
[Y_test_tb, classifScore_test] = tb.predict(Xtest);
myCategoricalErrorRate(Y_test_tb,Ytest);
% Compute the confusion matrix
[C_tb, order] = confusionmat(categorical(Ytrain),categorical(Y_train_tb));
% Examine the confusion matrix for each class as a percentage of the true class
C_tb = bsxfun(@rdivide,C_tb,sum(C_tb,2)) * 100
order

% Make a prediction for the test set
disp('Forest tree : we forecast on the brand new set :  other sites delamaison.fr, lamaisonduconvertible.fr, habitat.fr, enviedemeubles.com')
disp('Full forest tree validating set')
[Y_val_tb, classifScore_val] = tb.predict(Xval);

%% Updating the database;
javaaddpath('C:\My_MathWorks_Work\PAGE_CLASSIFIER\postgresql-9.3-1102.jdbc4.jar');
setdbprefs ('DataReturnFormat', 'table');
conn = database('CRAWL4J','postgres','mogette','Vendor','PostgreSQL',...
    'Server','localhost');
update_database_with_page_types(conn,URLval,Y_val_tb);
