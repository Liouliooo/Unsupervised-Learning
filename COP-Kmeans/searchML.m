function all_must_link = searchML( pt ,M )
all_must_link = [ ];


% all_must_link = [ pt; M(find(M(:,1)==pt),2); M(find(M(:,2)==pt),1) ];
% all_must_link = unique(all_must_link);
all_must_link = [ pt ];
index = 1;
while( index <= size(all_must_link,1) )
   %  all_must_link = [all_must_link; M(find(M(:,1)== all_must_link (index,1)),2); M(find(M(:,2)==all_must_link(index,1) ),1) ];
    num1 = M(find(M(:,1)== all_must_link (index,1)),2);
    for n1 = 1: length(num1)
    if (isempty(find (all_must_link(:,1)==num1(n1,1)  ) ))
        all_must_link = [all_must_link; num1(n1,1) ];
    end
    end
    
    num2 = M(find(M(:,2)==all_must_link(index,1) ),1);
    for n2 = 1:length(num2)
    if (isempty(find (all_must_link(:,1)==num2 (n2,1)  ) ))
        all_must_link = [all_must_link; num2(n2,1)];
    end
    end
    % all_must_link has no same value, index = index + 1.
%    all_must_link = unique(all_must_link);
    index = index +1;
 
end
all_must_link = unique(all_must_link);
end

