clear ; close all; clc

fprintf('\nApplying K-Means to compress an image.\n\n');

%  Load an image
A = double(imread('pic.jpg')); 

A = A / 255; % Divide by 255 so that all values are in the range 0 - 1

img_size = size(A);

% Reshape the image into an Nx3 matrix where N = number of pixels.
% Each row will contain the Red, Green and Blue pixel values
% This gives us our dataset matrix X that we will use K-Means on.
X = reshape(A, img_size(1) * img_size(2), 3); 
% 簇的个数，以及最大迭代次数
K = 5; 
max_iters = 15;

% 初始化中心点
initial_centroids = kMeansInitCentroids(X, K);
% Run K-Means
[centroids, idx] = runkMeans(X, initial_centroids, max_iters);


% 根据centroids和idx恢复图像矩阵。此时图像矩阵是二维的。
X_recovered = centroids(idx,:);    

% 根据上一步得到的聚类之后的图像矩阵，把矩阵恢复成三维的图像矩阵的格式。
X_recovered = reshape(X_recovered, img_size(1), img_size(2), 3);

figure(1);
hold on;
% Display the original image 
subplot(1, 2, 1); 
imagesc(A); 
title('Original');

% Display compressed image side by side
subplot(1, 2, 2); 
imagesc(X_recovered)
title(sprintf('Compressed, with %d colors.', K));
