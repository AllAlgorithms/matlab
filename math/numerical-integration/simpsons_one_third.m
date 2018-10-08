function [] = simpsons_one_third(lower_bound, upper_bound, func, partitions)
%SIMPSON's ONE-THIRD rule for Numerical Integration
%   Author : Satyajit Ghana
% USAGE : simpsons_one_third(lower_bound, upper_bound, function, number_of_partitions)

% If the number of partitions is not given then its assumed to be
% (upper_bound-lower_bound)*100

% the func should be values of function at points, or a function_handle

%% 
if nargin < 4
    partitions = (upper_bound-lower_bound)*100;
end

%%
if isa(func, 'sym') | isa(func, 'function_handle')
if mod(partitions, 2)
    fprintf('The number of Partitions must be even\n');
    partitions = partitions + 1;
    fprintf('Taking %d Partitions\n', partitions);
end
end
%%
n = partitions;
a = lower_bound;
b = upper_bound;
f = func;

h = (b-a)/n;

%%
if isa(func, 'sym')
    try 
        func_hand = matlabFunction(func);
        f = func_hand;
    catch ME
        fprintf('The Function should be a function_handle\n');
        disp(ME);
        return;
    end
end

if isa(func, 'function_handle')
    x = a:h:b;
    I = (h/3)*(f(x(1))+f(x(n+1)) + 4*sum(f(x(2:2:n))) + 2*sum(f(x(3:2:n-1))));
elseif ismatrix(func)
    if isa(func, 'char')
        fprintf('Characters ? Seriously ?\n');
        return;
    end
    if length(func) ~= n
        %fprintf('The number of paritions and value points of functions do not match\n');
        %return;
    end
    n = numel(func) - 1;
    h = (b-a)/n;
    I = (h/3)*(f(1)+f(end) + 4*sum(f(2:2:end)) + 2*sum(f(3:2:end-2)));
    %I = (h/3)*(f(1)+f(n+1) + 4*sum(f(2:2:n)) + 2*sum(f(3:2:n-1)));
else
    fprintf('The given Function is neither a function_handle nor a Matrix of Values of Function\n');
    return;
end

%%
fprintf('The value of Integral Computed using Simpson''s one-third rule');
if isa(func, 'function_handle')
    fprintf(' for %s ', func2str(func));
end
fprintf(' is ');
disp(vpa(I, 10));
end

