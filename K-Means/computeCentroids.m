function centroids = computeCentroids(X, idx, K)

% m��n��ʾ���ݵ�����������
[m, n] = size(X);  

% ����
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