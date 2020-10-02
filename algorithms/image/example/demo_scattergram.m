%% usage of a scattergram

%% clean up
clc
clear all
close all
%% First load an image
I=im2double(imread('coins.png'));
figure,imagesc(I);title('original Image')
%% general debug flag
debugvar=0;
%% Davies chapter4 108
% scattergram
H=[-1 -1 -1; 0 0 0 ;1 1 1 ];
Gx=imfilter(I,H,'symmetric');
Gy=imfilter(I,H','symmetric');
Gmag=abs(Gx+sqrt(-1)*Gy);

%% make scatter matrix
s=[200 255];
SM=zeros(s(1),s(2));
Gmagn=normalizeImage(Gmag,'OutputCrop',[0 0.7]);
In=normalizeImage(I,'OutputCrop',[0 1]);

% quantisize
Gnq=ceil(Gmagn*(s(1)-1))+1;
Inq=ceil(In*(s(2)-1))+1;
min(Inq(:))
max(Inq(:))
min(Gnq(:))
max(Gnq(:))

% build accumulator
for i=1:numel(Inq)
        SM(Gnq(i),Inq(i))=SM(Gnq(i),Inq(i))+1;
end
%imagesc(log(SM))
%
%imagesc((SM>0)+log(SM))
imagesc(log(SM)),xlabel('G'),ylabel('I')

%% test Fuction
SM=makeScattergram(I,'Size',[100 100],'GradientThresh',0.5,'Debug',1);

%%
makeScattergram(I,'Size',[100 100],'GradientThresh',1,'Debug',1);






