function [poly, differences] = newton_divided_differences(x, y)
% Author : Satyajit Ghana https://github.com/satyajitghana
n = length(y);
% Create the divided differences table
differences = zeros(n, n);
differences(:, 1) = y;

for j = 2:n
    for i = j:n
        differences(i, j) = (differences(i, j-1) - differences(i-1, j-1) ) / (x(i) - x(i-j+1)); 
    end
    %for i = 1: (n - j + 1)
    %    differences(i, j) = (differences(i+1, j-1) - differences(i, j-1)) / (x(i+j-1) - x(i))
    %end
end
disp('Difference Table');
disp(differences)

%delta_zeros = diag(differences);
%syms t polynomaial product;
% to calculate the fixed width of the data
%product = [1 t];
%for i = 2:1:n
%	product(i) = product(i-1)*(t-x(i));
%end
%polynomial = simplify(product * delta_zeros);
delta = diag(differences);
poly = delta(1);
prod = 1;

syms t
for i = 2:n
    prod = prod  * (t- x(i-1));
    poly = poly + prod * delta(i);
end

plot (x, y, '*');
hold on;
fplot(poly, [(x(1) - abs(x(1)-x(2))) (x(end) + abs(x(1)-x(2)))]);
title('$ $ Newton Divided Difference Table', 'Interpreter', 'latex')
legend({'$ $ Data Points' '$ $ Function'}, 'Interpreter', 'latex', 'Interpreter','latex', 'Location', 'best');
xlabel('$ $ x-axis', 'Interpreter', 'latex')
ylabel('$ $ y-axis', 'Interpreter', 'latex')
disp(simplify(poly))
poly = simplify(poly)
poly = vpa(poly, 4)
end
