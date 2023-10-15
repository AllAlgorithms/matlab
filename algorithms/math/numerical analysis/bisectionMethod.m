% bisection method
f=@(x)(3*x-exp(x));  %user defined function in terms of matlab functions
n=20; %number of iterations a user want
a=0; %initial range
b=1; %final range
% tol=0.01 %absolute error defined by user
c=(a+b)/2;
% if (f(c)<tol)
if ((f(a)*f(b))<0)
    for i=1:n
        c=(a+b)/2;
        if ((f(c)*f(a))<0)
            b=c;
        else   
            a=c;
        end
    end
else
    disp("Wrong interval")
end
% else 
    % disp("less tolerance");
% end