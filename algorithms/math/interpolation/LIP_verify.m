function [] = LIP_verify(func)
[x, y] = function_points(func, 10, 1, 10);
LIP(x, y);
hold on;
c = 0:0.001:10;
plot(c, func(c), 'g');
end
