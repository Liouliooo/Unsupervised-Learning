function idx = findClosestCentroids(X, centroids)

% �صĸ���
K = size(centroids, 1);
% ��ʼ��ÿ�����ݵ�����
idx = zeros(size(X,1), 1);

% ����ÿ�����ݾ����Լ�����Ĵ�
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