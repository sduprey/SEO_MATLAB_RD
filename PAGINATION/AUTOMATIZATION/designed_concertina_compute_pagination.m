function output_set=designed_concertina_compute_pagination(Ncurrent, Nlinks, Npadding, Ntotal)
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
%percent between 0 and 1 highlighting the quantity split between left and
%right
percent=total_left_to_left./(total_left_to_left+total_left_to_right);
% display_left_to_left is an integer between null and remaining
display_left_to_left=round(percent*remaining);
% display_left_to_right is an integer between null and remaining
display_left_to_right=remaining-display_left_to_left;


%% computing the middle pagination reference
middlepage=(min_bound:max_bound)';

%% computing the left pagination reference
leftpage = ones(display_left_to_left,1);
if (display_left_to_left>0)
    Necart=min_bound./display_left_to_left;
    i=1;
    % if i=1 just one page to be displayed
    while(i<display_left_to_left)
        new_ref=leftpage(i)+Necart;
        rounded_new_ref=roundn(new_ref,1);
        if (rounded_new_ref<=new_ref)
            rounded_new_ref=min((rounded_new_ref+10),min_bound-1);
        end
        if (rounded_new_ref>min_bound)
            rounded_new_ref=min_bound;
        end
        leftpage(i+1) = rounded_new_ref;
        i=i+1;
    end
end

%% computing the right pagination reference
rightpage = Ntotal.*ones(display_left_to_right,1);
if (display_left_to_right>0)
    Necart=(Ntotal-max_bound)./display_left_to_right;
    i=display_left_to_right;
    % i=1 we just display the last page at the end
    while(i>1)
        % we round up to an integer*Narr
        new_ref=(rightpage(i)-Necart);
        rounded_new_ref=roundn(new_ref,1);
        if (rounded_new_ref>new_ref)
            rounded_new_ref=max((rounded_new_ref-10),max_bound+1);
        end
        if (rounded_new_ref<max_bound)
            rounded_new_ref=max_bound;
        end
        rightpage(i-1) = rounded_new_ref;
        i=i-1;
    end
end
output_set=[leftpage;middlepage;rightpage];
end





