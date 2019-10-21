function [Lw,V,EW] = adefilt(I, varargin )
%adefilt Texture filter based on Ade's microstructure methods
%  Description: Texture filter based on Adew's microstructure methods
%               Changed to use eigenvectors of NH proposed by Ade
%               A textured region is selected (NHbase) and thereof sample
%               texture neighborhoods are generated (10x10). These are used
%               to calculate the "covariance" (not a real covariance -
%               since it is not meanfree) matrix. 
%               Then the eigenvectors and values are calculated and the
%               image is filtered with the strongest Eigenvectors.
%
%  Literature: Pratt - Digital Image Processing (imtbookBV8) S.540 16.6.6
%
%  Input:
%       I       ... Input image
%  ParameterPairs:
%       NH      ... neighborhood size for stdfilt stage
%       NHbase    ... texture image template which contains searched texture 
%       lambdaselect ... contains index of eigenvector which is used to
%                       filter the image (sorted by strength) 1.. is strongest
%       Fsize   ... Size of neighborhood in template image to create K
%       matrix
%
%
%  Return values:
%       Lw... Result Wallis image
%       V ... Eigenvectors
%       EW ... Eigenvalues
%

%%%%%%%% Argumente und  Parameter %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
FunctionName ='adefilt: ';
%% Matlab Paser
p=inputParser;p.KeepUnmatched =true;p.FunctionName=FunctionName;
p.addRequired('I',@(x)(ndims(x)==2 && isnumeric(x)));
p.addParamValue('NH',[9],@(x)isnumeric(x)); % check odd?
p.addParamValue('NHbase',[],@(x)~isempty(x)); % todo better check
p.addParamValue('lambdaselect',[1],@(x)~isempty(x)); % todo better check
p.addParamValue('Fsize',[],@(x)~isempty(x)); % todo better check
p.parse(I,varargin{:}); %% parse varargin

% Parameter
NH=p.Results.NH;
% Debug;
% F=img;
% NH=9;
%% Calculate Base
% %covariance matrix
NHvec=double(p.Results.NHbase(:));
[si sj]=size(p.Results.NHbase);
if ~isempty(p.Results.Fsize)
    % calculate K with more templates
    counter=1;
    for i=round(linspace(1,size(p.Results.NHbase,1)-p.Results.Fsize,10))
            for j=round(linspace(1,size(p.Results.NHbase,2)-p.Results.Fsize,10))
                NHvecmat{counter}=double(p.Results.NHbase((i+1):(i+p.Results.Fsize),(j+1):(j+p.Results.Fsize)));
                NHvecmat{counter}=NHvecmat{counter}(:); %make vector
                counter=counter+1;
            end
    end
    NHvec=cell2mat(NHvecmat);
    si =p.Results.Fsize ;
	sj =p.Results.Fsize ;
end
K=NHvec*NHvec';
[V,D]=eig(K);
%imagesc(V)
EW=sum(D,2);

% DEBUG: plot(EW(1:end-1))
%% process all EV
% Lw=[];H1=[];L=[];Ibig=[];
% [si sj]=size(p.Results.NHbase);
% for i=1:si
%     for j=1:sj
%         H2{i,j}=reshape(V(:,j+(i-1)*sj),si,sj);
%         L{i,j}=imfilter(I,H2{i,j},'symmetric');
%         Lw{i,j}=stdfilt(L{i,j},true([NH NH]));
%     end
% end

%% process  EV selection
Lw=[];H=[];L=[];
[EWs inds]=sort(abs(EW),'descend');
% Debug plot EV: imagesc(V(:,inds)),colorbar
for i=1:length(p.Results.lambdaselect)
    j=inds(p.Results.lambdaselect(i));
    H{i}=reshape(V(:,j),si,sj);
    L{i}=imfilter(I,H{i},'symmetric');
    Lw{i}=stdfilt(L{i},true([NH NH]));
end
end
