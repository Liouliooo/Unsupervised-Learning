function all_cl = searchCL( pt,CL )
all_cl = [ ];
% Point pt and its cannot-link in first layer. 
all_cl = [ CL(find(CL(:,1)==pt),2); CL(find(CL(:,2)==pt),1) ];
all_cl = unique(all_cl);

end

