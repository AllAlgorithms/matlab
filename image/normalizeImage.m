function [I] = normalizeImage(I,varargin)
%NORMALIZEIMAGE Normalizes Image into range 0...1
%
% Parameter:
%   Input:
%       I   ... Image
%
%   ParameterPairs:
%   all parameters used with limits [x1 x2] where x2>x1
%   'InputCrop'         ... crops the image range
%                           default: no crop
%   'InputRange'        ... defines the inputrange which is mapped to the
%                           outputrange
%                           default: [min(I(:)) max(I(:))]
%   'StdRange'          ... overwrites the InputRange !!!! (USE with
%                           OutputCrop!!!)
%                           Range is [mean+x1 mean +x2]
%                           e.g.
%                           default: not used
%   'OutputRange'       ... default: [0 1]
%   'OutputCrop'        ... optionally the output can be cropped
%                           default: no crop
%
%   Output:
%       I    ... cell array of normalized images or just the normalized
%                   image
%
% Usage: see demo
%
% Example:
%       In=nomalizeImage(I)
%       In=nomalizeImage(I,'InputRage',[0 255])
% 
% Compare: 
% I=im2double(imread('coins.png'));
% min(I(:))
% max(I(:))
% I=normalizeImage(imread('coins.png'),'InputRange',[0 255]);
% min(I(:))
% max(I(:))
% 
%
% See also IMNORMALIZE, SCALEFEATURE, NORMALIZEFEATURE


%% Using Matlab Paser
FunctionName ='normalizeImage: '; p=inputParser;p.KeepUnmatched =true;p.FunctionName=FunctionName;
p.addRequired('I',@(x)(ndims(x)==2 && isnumeric(x))|| iscell(x));
p.addParamValue('InputCrop',[],@(x)(any(size(x)==[1 2]) || any(size(x)==[2 1])) );
p.addParamValue('InputRange',[],@(x)(any(size(x)==[1 2]) || any(size(x)==[2 1])) );
p.addParamValue('StdRange',[],@(x)(any(size(x)==[1 2]) || any(size(x)==[2 1])) );
p.addParamValue('OutputRange',[0 1],@(x)(any(size(x)==[1 2]) || any(size(x)==[2 1])) );
p.addParamValue('OutputCrop',[],@(x)(any(size(x)==[1 2]) || any(size(x)==[2 1])) );

p.parse(I, varargin{:});

if ~iscell(I)
    Ic{1}=I;
    I=Ic;
    clear Ic;
    Iwascell=0; % false
else
    Iwascell=1; % true
end

% run through all Cells
for i=1:numel(I)
    if ~isempty(I{i}) % skip empty cells
        I{i}=double(I{i}); % cast double

        % Crop values of the image
        if ~isempty(p.Results.InputCrop)
            % minimum range
            I{i}(I{i}<=p.Results.InputCrop(1))=p.Results.InputCrop(1);
            % maxumum range
            I{i}(I{i}>=p.Results.InputCrop(2))=p.Results.InputCrop(2);
        end

        % InputRange
        InputRange=p.Results.InputRange;
        if isempty(InputRange) % use full range if no limits are given
            InputRange(1)=min(I{i}(:));
            InputRange(2)=max(I{i}(:));
        end
        % sometimes std range is better to use for the input range
        if ~isempty(p.Results.StdRange)
            stdI=std(I{i}(:));
            meanI=mean(I{i}(:));
            InputRange(1)=meanI+p.Results.StdRange(1)*stdI;
            InputRange(2)=meanI+p.Results.StdRange(2)*stdI;
        end

        % perform normalization
        OutputRange=p.Results.OutputRange;
        k=(OutputRange(2)-OutputRange(1))/(InputRange(2)-InputRange(1));
        d=(OutputRange(1)*InputRange(2)-OutputRange(2)*InputRange(1))/(InputRange(2)-InputRange(1));
        I{i}=k*I{i}+d;

        % crop output
        if ~isempty(p.Results.OutputCrop)
            % minimum range
            I{i}(I{i}<=p.Results.OutputCrop(1))=p.Results.OutputCrop(1);
            % maxumum range
            I{i}(I{i}>=p.Results.OutputCrop(2))=p.Results.OutputCrop(2);
        end

        % return image and not cellarray if image was not a cell array
        if ~Iwascell
            Ic=I;
            I=Ic{1};
            clear Ic;
        end
    end
end


