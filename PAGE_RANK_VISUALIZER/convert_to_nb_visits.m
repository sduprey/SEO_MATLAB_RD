function [ visits ] = convert_to_nb_visits( visits_from_gwt)
visits = regexprep(visits_from_gwt,'\(.*?\)','');
visits=str2num(visits);
end

