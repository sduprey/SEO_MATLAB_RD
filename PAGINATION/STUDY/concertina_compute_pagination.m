function output_set=concertina_compute_pagination(Ncurrent, Nlinks, Npadding, Ntotal)
% Nlinks << Ntotal because otherwise this is too easy
% goes from one to Ntotal-Npadding
min_bound = max(Ncurrent-Npadding, 1);
% goes from one+Npadding to Ntotal
max_bound = min(Ncurrent+Npadding, Ntotal);
remaining = Nlinks-(max_bound-min_bound+1);
% we round up remaining to the lowest nearest even integer
remaining=remaining-mod(remaining,2);
% total_left_to_left might be null up to Ntotal - Npadding -1
total_left_to_left=min_bound-1;
% total_left_to_right might be null up to Ntotal - Npadding -1
total_left_to_right=Ntotal-max_bound;
%percent between 0 and 1
percent=total_left_to_left./(total_left_to_left+total_left_to_right);
% display_left_to_left is an integer between null and remaining
display_left_to_left=round(percent*remaining);
% display_left_to_right is an integer between null and remaining
display_left_to_right=remaining-display_left_to_left;

Narr=1;
if (Ntotal<=20)
    Narr=1;
end
if ((Ntotal>20)&&( Ntotal<=30))
    Narr=2;
end
if ((Ntotal>30)&&( Ntotal<=50))
    Narr=3;
end
if ((Ntotal>50)&&( Ntotal<=100))
    Narr=5;
end
if ((Ntotal>100)&&( Ntotal<=500))
    Narr=7;
end
if ((Ntotal>500)&&( Ntotal<=1000))
    Narr=10;
end
if (Ntotal>1000)
    Narr=1000;
end


%% computing the middle pagination reference
middlepage=(min_bound:max_bound)';

%% computing the left pagination reference
leftpage = ones(display_left_to_left,1);
if (display_left_to_left>0)
    Necart=min_bound./display_left_to_left;
    i=1;
    while(i<display_left_to_left)
        leftpage(i+1) = floor(leftpage(i)+Necart);
        i=i+1;
    end
end

%% computing the right pagination reference
rightpage = Ntotal.*ones(display_left_to_right,1);
if (display_left_to_right>0)
    Necart=(Ntotal-max_bound)./display_left_to_right;
    i=display_left_to_right;
    while(i>1)
        % we round up to an integer*Narr
        rightpage(i-1) = floor((rightpage(i)-Necart));       
        i=i-1;
    end  
end
 output_set=[leftpage;middlepage;rightpage];
end





