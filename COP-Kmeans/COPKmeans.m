% COP-Kmeans
clear ; close all; clc

rng('shuffle');
fprintf('COP-Kmeans:\n');

% Load data.
% Features
data = load('features.dat');
features = data;

% Labels
label_data = load('labels.dat');
point_idx = label_data';
point_idx
% Constraints
[must_link, cannot_link] = buildContraints(point_idx);
% must_link = [0,0];
% cannot_link = [0,0];

% number of clusters
K = 10; 
% iterator 
max_iters = 100; 

% run cop-kmeans algorithm
[clusters, isFailed] = runCOPKmeans(features, K ,must_link, cannot_link,max_iters);

if (isFailed == true)
    fprintf('Clustering failed!\n ');
    return ;
else 
    fprintf('Clustering Successful!\n\n');
end
% fprintf('\n\nK-Means finished.\n\n');
