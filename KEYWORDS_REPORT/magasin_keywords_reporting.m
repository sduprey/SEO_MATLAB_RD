function  magasin_keywords_reporting(current_magasin,my_concurrent,conn)
%MAGASIN_REPORTING Summary of this function goes here
%   Detailed explanation goes here
%% Per magasin concurrency analysis
for conc=1:length(my_concurrent)
    current_conc = my_concurrent{conc};
    [radical_for_base, remain] = strtok(current_conc,'.');
    disp(radical_for_base);
    disp(['Fetching data for magasin ' current_magasin ' and concurrent : ' current_conc]);
    % getting count of
    %         global_count_string=['select count(distinct keyword) from pricing_keywords where magasin = ''' current_magasin ''''];
    %         setdbprefs ('DataReturnFormat', 'numeric');
    %         curs = exec(conn, global_count_string);
    %         curs = fetch(curs);
    %         close(curs);
    %         %Assign data to output variable
    %         global_count = curs.Data;
    %         disp([' Global count for magasin ' current_magasin ' : ' num2str(double(global_count))]);
    % getting real data
    
    my_string=['select am_keyword, am_search_position, am_search_volume from ' radical_for_base '_VS_CDISCOUNT_PRICING where cd_keyword is null and am_search_position<=15 and am_search_position >= 2 and am_search_volume<=50 and am_search_volume >= 5 and magasin=''' current_magasin ''' order by am_search_volume desc'];
    disp(my_string);
    setdbprefs ('DataReturnFormat', 'cellarray');
    curs = exec(conn, my_string);
    curs = fetch(curs);
    close(curs);
    %Assign data to output variable
    data = curs.Data;
    %     if isa(data, 'table')
    %         %             local_count = size(data,1);
    %         %             qp=local_count./global_count;
    %         %             disp(['Coverage rate : ' num2str(qp)]);
    %         %             if qp>=1
    %         %                disp('we might have a problem');
    %         %             end
    %         %summary(data);
    %         %% getting search position distribution
    %         h=figure('Name','Position and volume distribution','toolbar','none','menubar','none','units','pixels','position',[10 10 1000 1250],'Color',[1 1 1]);
    %         subplot(1,3,1,'align');
    %         hist(data.search_position,100);
    %         first_title=['Rank' current_conc ' ' current_magasin];
    %         title(first_title);
    %
    %         subplot(1,3,2,'align');
    %         high_volume = data.search_volume(data.search_volume>=quantile(data.search_volume,0.9));
    %         hist(high_volume);
    %         title(['High Vol ' current_conc ' ' current_magasin]);
    %
    %         subplot(1,3,3,'align');
    %         low_volume = data.search_volume(data.search_volume<=quantile(data.search_volume,0.4));
    %         hist(low_volume);
    %         title(['Low Vol ' current_conc ' ' current_magasin]);
    %         saveas(h,[first_title '.jpg'],'jpg');
    %     else
    disp(data);
    %local_count = 0;
    % disp(['Coverage rate : ' num2str(local_count./global_count)]);
    %     end
end
end

