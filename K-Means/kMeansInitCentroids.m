function centroids = kMeansInitCentroids(X, K)

centroids = zeros(K, size(X, 2));  

randidx = randperm(size(X,1));   % 随机打乱序列
centroids = X(randidx(1:K),:);  % 取前K个作为初始的中心

end