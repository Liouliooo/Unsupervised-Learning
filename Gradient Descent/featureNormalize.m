function X_norm = featureNormalize(X)

X_norm = X; 

max_num=max(X_norm);
min_num=min(X_norm);

for i=1:size(X_norm,2)
  X_norm(:,i)=(X_norm(:,i)-min_num(i))/(max_num(i)-min_num(i));
end

end
