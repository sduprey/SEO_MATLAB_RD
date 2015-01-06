function output_set=nomao_compute_pagination(Ncurrent, Nlinks, Ntotal)
% Nlinks << Ntotal because otherwise this is too easy
% goes from one to Ntotal-Npadding

%% middle pages
% we here round up to the nearest decade
Ncurrent_nearest_ten=roundn(Ncurrent,1);

if(Ncurrent>=Ncurrent_nearest_ten)
    Ncurrent_under_ten=Ncurrent_nearest_ten;
    Ncurrent_above_ten=Ncurrent_nearest_ten+10;
else
    Ncurrent_under_ten=Ncurrent_nearest_ten-10;
    Ncurrent_above_ten=Ncurrent_nearest_ten;
end
Ncurrent_underunder_ten=Ncurrent_under_ten-10;
if (Ncurrent_under_ten  == 0)
    middle_pages=((Ncurrent_under_ten+1):Ncurrent_above_ten)';
else
    middle_pages=(Ncurrent_under_ten:Ncurrent_above_ten)';
end

if (Ncurrent_above_ten>=Ntotal)
    middle_pages=middle_pages(middle_pages<=Ntotal);
end

%% left pages
if (Ncurrent_underunder_ten<=0)
    left_pages=[1];
else
    left_pages=[1;Ncurrent_underunder_ten];
end

%% right pages
remaining = Nlinks-(length(left_pages)+length(middle_pages));
right_pages=ones(remaining,1);
my_cursor=Ncurrent_above_ten;
counter=1;
while((remaining > 0) && (mod(my_cursor,100)~=0) && (my_cursor+10<=Ntotal))
    right_pages(counter)=my_cursor+10;
    my_cursor=my_cursor+10;
    remaining=remaining-1;
    counter=counter+1;
end

while((remaining > 0) && (mod(my_cursor,1000)~=0) && (my_cursor+100<=Ntotal))
    right_pages(counter)=my_cursor+100;
    my_cursor=my_cursor+100;
    remaining=remaining-1;
    counter=counter+1;
end

while((remaining > 0) && (mod(my_cursor,10000)~=0) && (my_cursor+1000<=Ntotal))
    right_pages(counter)=my_cursor+1000;
    my_cursor=my_cursor+1000;
    remaining=remaining-1;
    counter=counter+1;
end
right_pages=right_pages(1:(counter-1));

%% concatenat
output_set=[left_pages;middle_pages;right_pages];

end





