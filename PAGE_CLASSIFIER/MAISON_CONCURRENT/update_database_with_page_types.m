function update_database_with_page_types(conn, URLval, Y_val_tb)
for i=1:length(Y_val_tb)
    disp(['URL ' URLval(i) ' @@@Classifier page type results : ' Y_val_tb(i)]);
    update_statement = ['update arbocrawl_results set page_type = '''  Y_val_tb{i}  ''' where url = ''' URLval{i} ''''];
    exec(conn,update_statement);
end
end

