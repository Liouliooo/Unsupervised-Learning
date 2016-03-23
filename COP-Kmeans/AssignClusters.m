function [ get_clusters, isPass ] = AssignClusters( data,clusters, K, M, C )
m = size(data,1);
% n = size(data,2);

preClusters = clusters;

%{
%% for testing
sum = 0;
for i = 1 : K
    sum = sum + length(clusters{i}.idx);
end
    fprintf('Data Point correctly assigned number: %d\n',sum);
%% 
%}
% Reset assignments

for i = 1 : K
   get_clusters{i}.idx = [];
end

% Cluster every data point
for i = 1 : m
    %%%%% fprintf('Data point: %d\n',i);
    % Sort clusters by their distances
    dist = zeros(K,2);
    for j = 1 : K
        dist(j,1) = pdist ([data(i,:); clusters{j}.center]);
        dist(j,2) = j;
    end
    dist = sortrows(dist);
    sortedClusters = dist(:,2);
    
    % Test clusters
    for ix = 1: K % Assume one point has one constraint.
        %%%%% fprintf('Center point (%dth): %d\t\t',ix,sortedClusters(ix));
        if ( isViolateConstraints( i,preClusters{sortedClusters(ix)}.idx, M, C, K ,clusters))
            if (ix == K)
                %%%%% fprintf('\n\n');
                isPass = false;
                return ;
            else
                continue;
            end
        else      
            isPass = true;
            get_clusters{sortedClusters(ix)}.idx = [get_clusters{sortedClusters(ix)}.idx, i ];
            %%%%% fprintf('\n\n');
            break;
        end
    end
end

end
