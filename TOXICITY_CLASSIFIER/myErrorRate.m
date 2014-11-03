function myErrorRate(predY,Y_t )
percent = sum(predY == Y_t)./length(Y_t);
disp(['Tree, % Good classified rate on set  : ' num2str(percent*100)]);
% C = confusionmat(cellstr(Y_t),cellstr(predY),...
%     'order',{'0' '1'});
% disp('Tree Confusion matrix on set  with order AAA AA A BBB BB B CCC');
% C %#ok<NOPTS>
end

