function [ varargout ] = makeScattergram( I,varargin )
%MAKESCATTERGRAM makes a scattergram matrix from an image
% see [1], [2,117]
%
% Parameter:
%   Input: I ... grayscale image range 0 ... 1
%
%   ParameterPairs:
%       'GradientTresh' crop normalized gradient since high gradientvalues
%       are usually not very interessting any more
%
%   Global Parameter Pairs:
%       'Debug'     0 ... no debug output,
%                   1,2,... ... higher the number leads to more output
%       'FilterPadding' used for imfilter
%
%   Output:
%       Is ... scattergram image
%
% Usage: see demo
%
% Example: see demo
%
% Todo: - see also [russ BV20, p.414] and scatterplot, scatter,
%
% Literature:
% [1]	D.P. Panda and A. Rosenfeld. Image segmentation by pixel
% classification in (gray level, edge value) space. IEEE Transactions on Computers, 27:875–879, 1978.
% [2]	E. R. Davies. Machine Vision — Theory, Algorithms, Practicalities.
% Elsevier, 3 edition, 2005.
%


%%  Matlab Paser
FunctionName ='makeScattergram: ';p=inputParser;p.KeepUnmatched =true;p.FunctionName=FunctionName;
p.addRequired('I',@(x)ndims(x)==2);
p.addParamValue('Size',[100 100],@(x)isnumeric(x));
p.addParamValue('GradientThresh',1,@(x)isnumeric(x));
p.addParamValue('FilterPadding','symmetric',@(x)any(strcmpi(x,{'symmetric','replicate','circular'})));
p.addParamValue('Debug', 0,@(x)isnumeric(x)); % method
p.parse(I,varargin{:});

%% Start Coding
I=normalizeImage(I);

% scattergram
H=[-1 -1 -1; 0 0 0 ;1 1 1 ];
Gx=imfilter(I,H,p.Results.FilterPadding);
Gy=imfilter(I,H',p.Results.FilterPadding);
Gmag=abs(Gx+sqrt(-1)*Gy);

Gmag=normalizeImage(Gmag);
Gmag(Gmag>p.Results.GradientThresh)=p.Results.GradientThresh; % crop gradient
Gmag=normalizeImage(Gmag);

if p.Results.Debug>0
    inds=ceil(rand(10000,1)*numel(I));
    inds=unique(inds);
    figure,scatter(I(inds),Gmag(inds));
    xlabel('Intensity (normalized)')
    ylabel('Gradient (normalized)')
end
%%
% make scatter matrix
SM=zeros(p.Results.Size(1),p.Results.Size(2));

% quantysize
Gnq=ceil(Gmag*(p.Results.Size(1)-1))+1;
Inq=ceil(I*(p.Results.Size(2)-1))+1;
if p.Results.Debug>0
    min(Inq(:))
    max(Inq(:))
    min(Gnq(:))
    max(Gnq(:))
end

% build accumulator
for i=1:numel(Inq)
    SM(Gnq(i),Inq(i))=SM(Gnq(i),Inq(i))+1;
end

if p.Results.Debug>0
   figure,
   %imagesc(log(SM)),xlabel('G'),ylabel('I')
   mesh(log(SM)),xlabel('I'),ylabel('G')
end
varargout{1}=SM;
varargout{2}=Gnq;
varargout{3}=Inq;