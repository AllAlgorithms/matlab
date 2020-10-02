function [polynomial, differences] = newton_forward_interpolation(x, y)
% Newton - Gregory Forward Difference Interpolation
% Author : Satyajit Ghana https://github.com/satyajitghana
% Input : data points (x_i, y_i) i = 1, 2, 3, 4, 5, . . n

n = length(y);
differences = zeros(n, n);
differences(:, 1) = y;
for j = 2:n
	for i = j:n
		differences(i, j) = differences(i, j-1) - differences(i-1, j-1);
	end
end
delta_zeros = diag(differences);
syms t polynomaial product;
% to calculate the fixed width of the data
h = x(2) - x(1);
s = (t - x(1)) / h;
product = [1 s];
for i = 3:1:n
	product(i) = product(i-1)*(s-(i-2)) / (i-1);
end
polynomial = simplify(product * delta_zeros);

t = x(1):0.01:x(end);
plot(x, y, '*', t, eval(polynomial), 'LineWidth', 1.5);
hold on;
grid on;
end
