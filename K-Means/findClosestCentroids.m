function idx = findClosestCentroids(X, centroids)

% 簇的个数
K = size(centroids, 1);
% 初始化每行数据的索引
idx = zeros(size(X,1), 1);

% 计算每行数据距离自己最近的簇
cost_matrix=zeros(1,K);
for i=1:size(X,1)
  temp=X(i,:);
  for j=1:K
    cost_matrix(1,j)=norm(temp-centroids(j,:));
  end
  [cost,index]=min(cost_matrix);
  idx(i)=index;
end

end