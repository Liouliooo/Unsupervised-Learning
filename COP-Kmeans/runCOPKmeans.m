function [clusters, isFailed ] = runCOPKmeans( data, K, M, C, maxIter)

m = size(data,1);
n = size(data,2);

initial_clusters = initCentroids(data, K, M, C);

%% for testing
sum = 0;
for i = 1 : K
    sum = sum + length(initial_clusters{i}.idx);
end
    fprintf('Data Point correctly assigned number: %d\n',sum);
%% 
if( sum < m)
    
    return ;
end

% Assign data points to nearest cluster that does't violate any any constraints
iterNo = 0;
deviation = 1;
prevClusters = initial_clusters;
tempClusters = initial_clusters;
while deviation > 0.001 && iterNo < maxIter
    fprintf('%d  iterator:\n',iterNo+1);
    % Assign datapoint to clusters
    [clusters,isPass] = AssignClusters(data,tempClusters, K, M, C);
    
    % Check constraints
    if (~isPass)
        % Clustering failed
     % clusters = NaN;
        isFailed = true;
        fprintf('Constraints are not satisfied! \n');
       
        return ;
    end
    
    % Recalculate cluster centers
    for k = 1 : K
        sum = zeros(1,n);
        for j = 1 : length(clusters{k}.idx)
            sum = sum + data(clusters{k}.idx(j), :);
        end
        clusters{k}.center = sum / length(clusters{k}.idx);
    end
    
    % Calculate the deviation in cluster centers
    deviation = 0;
    for i = 1 : K
        deviation = deviation + (pdist([clusters{i}.center; prevClusters{i}.center]));
    end
    
    prevClusters = clusters;
    tempClusters = clusters;
    iterNo = iterNo + 1;
end

if (iterNo == maxIter)
    fprintf('Maximum # iteration reached...\n');
end
isFailed = false;
end

