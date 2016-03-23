function clusters = initCentroids(data, K, M, C)

m = size(data,1);
n = size(data,2);

intial_idx = randperm(m,K);

% Intialize clusters. 
for i = 1 : K
	clusters{i}.center = data( intial_idx(i), :);
	clusters{i}.idx = [ ];
end

% Cluster data points
for i = 1 : m
	minDist = +Inf; % biggest number
	minDistCluster = 1;
	for j = 1 : K
		dist(j,1) = pdist( [data(i,:); clusters{j}.center ]);
		dist(j,2) = j;
		if ( dist(j,1) < minDist)
			minDist = dist(j,1);
			minDistCluster = j;
		end
	end
	dist = sortrows(dist);
	sortedClusters = dist(:,2);


	%% Check, if point i has beed allocated.
	for ic = 1 : K
		jump = false;
		if(~isempty( find (clusters{ic}.idx == i))) % Jump to the first for loop.
			jump = true;   
			break;
		end
	end
	if ( jump )     % If current point is allocated, continue.
		continue;
	end
	%% Point i has no must-link and has no cannot-link.
	%  if ( isempty(find(M(:,1)==i)) && isempty(find(M(:,2)==i))  &&   isempty( find(C(:,1)==i)) && isempty( find(C(:,2) ==i )) )
	if( isempty(find(M(:,1)==i)) )
		if ( isempty(find(M(:,2)==i)) )
			if( isempty( find(C(:,1)==i)))
				if( isempty( find(C(:,2) ==i )))
					 clusters{minDistCluster}.idx = [ clusters{minDistCluster}.idx, i];   % careful about this code.   
				end
			end
		end
		% This point has no constraints.

	end

	%%  Point i has must-link and has no cannot-link. 
    % But its must-link may have cannot-link
	if ( (~isempty(find(M(:,1)==i)) || ~isempty(find(M(:,2)==i)) ))  % &&   isempty( find(C(:,1)==i)) && isempty( find(C(:,2) ==i )) )
		 if( isempty( find(C(:,1)==i)) )
			 if( isempty( find(C(:,2) ==i )))
				 MLpoints = searchML(i,M); 
                 CL_p = [];
                 for cli = 1:length(MLpoints)
                     temp = searchCL(MLpoints(cli,1),C);
                     CL_p = [CL_p ;temp];
                 end
                 CL_p = unique(CL_p);
                  
                  
		  % Delete the same value(must-link) in CLp,
		 
            for dec = 1: length(MLpoints)
                if( ~isempty(find (CL_p(:,1)==MLpoints(dec)) ) )
                    tcm = find(CL_p(:,1)==MLpoints(dec));
                    CL_p(tcm,1) = [];
                end
            end
            
            for icmcc = 1: K
                isVCLCC = false;
                for icm_cmcc = 1: length(CL_p)
                    if (~isempty( find( clusters{sortedClusters(icmcc)}.idx == CL_p(icm_cmcc,1) ) ))
                        isVCLCC = true;                
                        break ; % If this cluster has cannot-link point,break .  And to see the next cluster.
                    end
                end
                if(~isVCLCC)
                    clusters{ sortedClusters(icmcc) }.idx = [clusters{ sortedClusters(icmcc) }.idx, MLpoints' ];                 
                    break;
                end
            end
			end
		 end

	 end

	 %% Point i has no must-link and has cannot-link 
	 if ( isempty(find(M(:,1)==i)))       % && isempty(find(M(:,2)==i))  &&  ( ~isempty( find(C(:,1)==i)) || ~isempty( find(C(:,2) ==i )) ) )
		 if ( isempty(find(M(:,2)==i))  )
			 if( ~isempty( find(C(:,1)==i)) || ~isempty( find(C(:,2) ==i )) )
				 CLpoints = searchCL(i,C); % CLpoint do not contain the point i.

				 % Need to use vector sortedClusters
				 for icl = 1 : K
					 isV = false;
					 for icl_c = 1 : length(CLpoints)
						 if (~isempty( find( clusters{sortedClusters(icl)}.idx == CLpoints(icl_c,1) ) ))
							 isV = true;
							 break ; % If this cluster has cannot-link point,break .  And to see the next cluster.
                         end
                     end
                    % fprintf('%d\n',sortedClusters(icl));  % For testing
                    if(~isV)
                        % Error,========================================================
                        clusters{ sortedClusters(icl) }.idx = [clusters{ sortedClusters(icl) }.idx, i ];
                        break;
                    end   
                end
             end
        end
	 end

	 %% Point i has must_link and has cannot_link 
	 if ( ~isempty(find(M(:,1)==i)) || ~isempty(find(M(:,2)==i ) )  )   %&&  ( ~isempty( find(C(:,1)==i)) || ~isempty( find(C(:,2) ==i )) ) )
		 if ( ~isempty( find(C(:,1)==i)) || ~isempty( find(C(:,2) ==i )) )
			 MLp = searchML(i, M);
			 CLp = [ ];
			 % Find each value's(in must-link) cannot-link,
			 for all_m = 1: length(MLp)
				 temp = searchCL(MLp(all_m,1),C);      % If MLp(all_m,1) has no cannot-link , searchCL( ) function will handle this.
				 CLp = [CLp; temp];
		  end


		  CLp = unique(CLp);

		  % Delete the same value(must-link) in CLp,
		 
         for de_m = 1: length(MLp)
			  if( ~isempty(find (CLp(:,1)==MLp(de_m)) ) )
				  tcm = find(CLp(:,1)==MLp(de_m));
				  CLp(tcm,1) = [];
			 end
		 end
         


		 for icm = 1: K
			 isVCL = false;
			 for icm_cm = 1: length(CLp)
				 if (~isempty( find( clusters{sortedClusters(icm)}.idx == CLp(icm_cm,1) ) ))
					 isVCL = true;
                %     fprintf('%d cannot in cluters: %d\t',i, sortedClusters(icm));
					 break ; % If this cluster has cannot-link point,break .  And to see the next cluster.
				end
			end
			if(~isVCL)
				clusters{ sortedClusters(icm) }.idx = [clusters{ sortedClusters(icm) }.idx, MLp' ];
             %   fprintf('%d must in cluster: %d\n',i, sortedClusters(icm));
				break;
			end
		end
	end
end

end
end         % Function
