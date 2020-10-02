function [ varargout  ] = findNextIntegerSquareRoot( x,varargin )
%FINDNEXTINTEGERSQUAREROOT finds the next integer combination y1*y2=x
% To reshape a vector into a matrix, it is necessary to find the size of
% the matrix
%
% Parameter:
%   Input:
%       x ... vector length
%
%   ParameterPairs:
%
%   Output:
%       [x y] ... size of the matrix
% Usage:
%
% Example:
%   [sx sy]=findNextIntegerSquareRoot(21,'Mode','Exact')
%   [sx sy]=findNextIntegerSquareRoot(24,'Mode','Exact')
%   [sx sy]=findNextIntegerSquareRoot(23,'Mode','Exact')
%


%%  Matlab Paser
FunctionName ='findNextIntegerSquareRoot: ';p=inputParser;p.KeepUnmatched =true;p.FunctionName=FunctionName;
p.addRequired('x',@(x)isnumeric(x));
p.addParameter('Mode','Round',@(x)any(strcmpi(x,{'Exact','Round'})));
p.addParameter('MaximumRest',[],@(x)isnumeric(x));
p.parse(x,varargin{:});

%% Start Coding

switch p.Results.Mode
    case 'Exact' % No Rest is allowed!
        if ~isprime(x)
            %% since x is no prime we can factor it
            cp=cumprod(factor(x)); 
            a=cp.*fliplr(cp); % calculate the new larger area
            [minval minind]=min(a);
            s1=cp(minind);
            s2=x/s1;
            rest=0;
        else
            % faster if x is prime
            s1=x;
            s2=1;
            rest=0;
        end
    otherwise
        if isempty(p.Results.MaximumRest)
            % Round - Fastest Way
            xr=sqrt(x);
            s1=ceil(xr);
            s2=s1;
            rest=s1*s2-x;
        else
            %% Allow some rest defined by MaximumRest
            xr=sqrt(x);
            s1=ceil(xr):1:ceil(xr)+5;
            s2=x./s1;
            s2=ceil(s2); % area must be bigger!
            rest=s1.*s2-x;
            ind=find(rest<=p.Results.MaximumRest,1,'first');
            s1=s1(ind);
            s2=s2(ind);
            rest=rest(ind);
        end
end

varargout{1}=s1;
varargout{2}=s2;
varargout{3}=rest;