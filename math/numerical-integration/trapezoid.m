function I = trapezoid(f, n, a, b)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

h = (b-a) / n;

if isa(f, 'function_handle') || isa(f, 'sym')
    if isa(f, 'sym')
        f = matlabFunction(f);
    end
    func = sym(f);
    x = a:h:b;
    I = (h/2)*(f(a) + f(b) + 2*sum(f(x(2:n))));
    disp('Using Definite Integrals')
    disp(vpa(int(func, a, b), 15));
    disp('Using Trapz')
    disp(trapz(a:h:b, f(a:h:b)))
else
    h = length(f) - 3;
    I = (h/2)*(f(1) + f(end) + 2*sum(f(2:1:end-1)));
    %I = (h/2)*(f(1) + 2*sum(f(2:1:n)) + f(n+1));
    disp('Using Trapz : ')
    disp(trapz(f))
end
disp('Using my Function : ')
disp(I)
end

