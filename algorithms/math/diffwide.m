function [dx] = diffwide( x,a )
%DIFFWIDE wide differential 
%  instead of usage of the next or previous value of a vector, use a wider distance
% 
%  Input:    x   ... vector
%            a   ... distance 
%  Output:   dx  ... diff(x) with distance a
%  

dx=[];
% get errors
if (length(x)<a) %
    error('length(x)<a');
elseif (size(x,1)<a && size(x,2)>=a)
    x=x';
    warning('please use columnvectors')
end
% do calculation
for i=1:size(x,2) % run through cols
    dx(:,i)=(x(a+1:end,i)-x(1:end-a,i))/a;
end


  