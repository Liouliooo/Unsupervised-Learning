function [theta, J_history] = gradientDescentMulti(X, y, theta, alpha, num_iters)

m = length(y); % number of training examples
J_history = zeros(num_iters, 1);

for iter = 1:num_iters
    % Vectorization��ʸ��������
    theta = theta-(alpha/m)*(X'*(X*theta-y));
    % ÿ�ε����������ڵ�ǰ�����µķ��ۺͱ�Ƿ��۵�ƫ��ֵ
    J_history(iter) = computeCostMulti(X, y, theta);
end
end
