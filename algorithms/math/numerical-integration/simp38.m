function [ I ] = simp38(f, n, a, b)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
if mod(n, 3)
    disp('n must be multiple of 3')
    return
end

h = (b-a)/n;

if numel(f) > 1
    I = (3*h/8)*(f(1) + 3*(sum(f(2:3:n-1)) + sum(f(3:3:n))) + 2*sum(f(4:3:n-2)) + f(n+1) );
else
    x = a:h:b;
    I = (3*h/8)*(f(a) + 3*(sum(f(x(2:3:n-1))) + sum(f(x(3:3:n)))) + 2*sum(f(x(4:3:n-2))) + f(b) );
end

end

