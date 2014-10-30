function testErrorRate(predY,Y_t )
predY=ordinal(predY,[],{'0' '1'});
predY=(predY=='1');
percent = sum(double(predY) == double(Y_t))./length(Y_t);
disp(['Tree, % Good classified rate on set  : ' num2str(percent*100)]);
% C = confusionmat(cellstr(Y_t),cellstr(predY),...
%     'order',{'0' '1'});
% disp('Tree Confusion matrix on set  with order AAA AA A BBB BB B CCC');
% C %#ok<NOPTS>
end

