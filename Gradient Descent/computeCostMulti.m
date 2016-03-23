function J = computeCostMulti(X, y, theta)

m = length(y); % number of training examples

% You need to return the following variables correctly 
J = 0;
% Vectorization
J=(1/(2*m))*((X*theta-y)'*(X*theta-y));

end