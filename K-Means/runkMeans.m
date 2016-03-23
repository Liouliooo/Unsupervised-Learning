function [centroids, idx] = runkMeans(X, initial_centroids, max_iters)

% Initialize values
[m,n] = size(X); 
K = size(initial_centroids, 1); 
centroids = initial_centroids; 
idx = zeros(m, 1); 

% Run K-Means
for i=1:max_iters
    
    % Output progress
    fprintf('K-Means iteration %d/%d...\n', i, max_iters);

    % For each example in X, assign it to the closest centroid
    idx = findClosestCentroids(X, centroids);
    
    % Given the memberships, compute new centroids
    centroids = computeCentroids(X, idx, K);
end

end

