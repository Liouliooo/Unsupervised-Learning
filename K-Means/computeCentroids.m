function centroids = computeCentroids(X, idx, K)

% m，n表示数据的行数和列数
[m, n] = size(X);  

% 置零
centroids = zeros(K, n);  

% 
for i=1:K
  cost=zeros(1,size(X,2));
  index=0;
  for j=1:size(X,1)
    if (idx(j)==i)
      cost=cost+X(j,:);
      index=index+1;
    end
  end
  centroids(i,:)=cost/index;
end

end