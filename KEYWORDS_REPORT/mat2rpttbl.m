function tbl = mat2rpttbl(mat, colNames, rowNames, colfmts)

if nargin > 1 && ~isempty(colNames)
    if ~iscellstr(colNames)
        if ischar(colNames)
            colNames = cellstr(colNames);
        else
            colNames = mat2rpttbl(colNames);
        end
    end
else
    colNames = cell.empty(0,size(mat,2));
end
if nargin > 2 && ~isempty(rowNames)
    if ~iscellstr(rowNames)
        if ischar(rowNames)
            rowNames = cellstr(rowNames);
        else
            rowNames = mat2rpttbl(rowNames);
        end
    end
    rowNames = [{''};rowNames(:)];
else
    rowNames = cell.empty(size(mat,1)+size(colNames,1),0);
end
if nargin > 3 && ~isempty(colfmts)
    if length(colfmts)==1
        colfmts(1:size(mat,2)) = colfmts;
    elseif length(colfmts) ~= size(mat,2)
        t = colfmts;
        colfmts = cell(1,size(mat,2));
        colfmts(1:length(t)) = t;
        for i = 2:length(colfmts)
            if isempty(colfmts{i})
                colfmts{i} = colfmts{i-1};
            end
        end
    end
else
    colfmts = repmat({'%0.2f'},1,size(mat,2));
end

tbl = num2cell(mat);
for i = 1:size(mat,2)
    for j = 1:size(mat,1)
        if any(colfmts{i}==',')
            tbl{j,i} = char(format(java.util.Formatter,colfmts{i},tbl{j,i}));
        else
            tbl{j,i} = sprintf(colfmts{i},tbl{j,i});
        end
    end
end
tbl = [rowNames [colNames(:)';tbl]];

