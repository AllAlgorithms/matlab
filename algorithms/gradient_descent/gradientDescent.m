function [theta] = gradientDescent(X, y, theta, alpha, num_iters)

% Initialize  values
m = length(y); % number of training examples
J_history = zeros(num_iters, 1);
v = zeros(m, 1);

for iter = 1:num_iters

	prediction = X * theta;
	squared_error = prediction - y;
	
	element_wise = squared_error .* X;
	summation = sum(element_wise(:,2));
	
	theta(1) -= alpha*(1/m)* sum(squared_error);
	theta(2) -= alpha*(1/m)* summation;
	

end

end
