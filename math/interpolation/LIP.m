function [Lsum] = LIP(x, y)
% Author :  Satyajit Ghana https://github.com/satyajitghana
% Lagrange Interpolating Polynomial
% USAGE : polynomial = LIP([x1 x2 x3 . . . xi], [y1 y2 y3 . . . yi])
n = length(y);
syms t;
Lsum = 0;
for i = 1:n
	Lprod = 1;
	for j = 1:n
		if (i ~= j)
			Lprod = Lprod * ( (t - x(j)) / (x(i) - x(j)) );
		end
	end
	Lsum = Lsum + y(i) * Lprod;
end

disp('Langrange Interpolating Polynomial for the given data is : ');
Lsum = simplify(Lsum);
disp(Lsum);

t = x(1):0.5:x(end);
%z = eval(Lsum);

plot(x,y,'*',t,eval(Lsum), 'LineWidth', 1.5);
hold on;
grid on;
end
