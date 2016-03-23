clear ; close all; clc

% Load Data
data = load('house_data.txt');
X = data(:, 1:2);  % 前两列为特征
y = data(:, 3);  % 第三列为价格
m = length(y);  

fprintf('Gradient Descent.\n');

X = featureNormalize(X);
% Add intercept term to X
% 为X增加截距项
X = [ones(m, 1), X]; 

% Choose some alpha value
alpha = 0.01;
num_iters = 400;

% Init Theta and Run Gradient Descent 
theta = zeros(size(X,2), 1);  
[theta, J_history] = gradientDescentMulti(X, y, theta, alpha, num_iters);

% Plot the convergence graph
figure(1);
plot( 1:numel(J_history), J_history, '-b', 'LineWidth', 2);
xlabel('Number of iterations');
ylabel('Cost J');

% Display gradient descent's result
fprintf('Theta computed from gradient descent: \n');
fprintf(' %f \n', theta);
fprintf('\n');

% 这是特征归一化之后的数据，我随便给的，用于预测房价。
newData = [1,0.2489,0.5];
% newData = featureNormalize(newData);
price = newData*theta; 
fprintf('Predict price is %f\n',price);
