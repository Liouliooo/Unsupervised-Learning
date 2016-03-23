clear ; close all; clc

% Load Data
data = load('house_data.txt');
X = data(:, 1:2);  % ǰ����Ϊ����
y = data(:, 3);  % ������Ϊ�۸�
m = length(y);  

fprintf('Gradient Descent.\n');

X = featureNormalize(X);
% Add intercept term to X
% ΪX���ӽؾ���
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

% ����������һ��֮������ݣ��������ģ�����Ԥ�ⷿ�ۡ�
newData = [1,0.2489,0.5];
% newData = featureNormalize(newData);
price = newData*theta; 
fprintf('Predict price is %f\n',price);
