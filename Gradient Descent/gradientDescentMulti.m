function [theta, J_history] = gradientDescentMulti(X, y, theta, alpha, num_iters)

m = length(y); % number of training examples
J_history = zeros(num_iters, 1);

for iter = 1:num_iters
    % Vectorization，矢量化操作
    theta = theta-(alpha/m)*(X'*(X*theta-y));
    % 每次迭代，保存在当前参数下的房价和标记房价的偏差值
    J_history(iter) = computeCostMulti(X, y, theta);
end
end
