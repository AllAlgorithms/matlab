function [varargout] = isMonoton(x)
%% isMonoton checks if a vector is a monoton vector 
%
% Input:
% x ... column vector
%
% Returnvalues: 
%  varargout{1} = 
%       0 ... not monoton
%       -1 ... weak monoton rising
%       -2 ... strong monoton falling
%       1 ... weak monoton rising
%       2 ... strong monoton rising
%       3 ... all zeros
% Usage:
% res = isMonoton([1 3 4 5])
% res = isMonoton([1 -1 -2 -2 -2 -3])

%%
dx=diff(x(:));
out=0;                  %
out=out+all(dx>=0);     % weak monoton rising
out=out+all(dx>0);      % strong monoton rising
out=out-all(dx<=0);     % weak monoton falling
out=out-all(dx<0);      % strong monoton falling
if all(dx==0)
    out=3;
end
varargout{1}=out;
end

