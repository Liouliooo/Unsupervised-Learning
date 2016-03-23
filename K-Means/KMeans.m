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
% �صĸ������Լ�����������
K = 5; 
max_iters = 15;

% ��ʼ�����ĵ�
initial_centroids = kMeansInitCentroids(X, K);
% Run K-Means
[centroids, idx] = runkMeans(X, initial_centroids, max_iters);


% ����centroids��idx�ָ�ͼ����󡣴�ʱͼ������Ƕ�ά�ġ�
X_recovered = centroids(idx,:);    

% ������һ���õ��ľ���֮���ͼ����󣬰Ѿ���ָ�����ά��ͼ�����ĸ�ʽ��
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
