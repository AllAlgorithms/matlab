%%  demo_lawfilt
%%  clean up
clc
clear all
close all
%% load data 
I1 = imread('ngc6543a.jpg');
figure,
imagesc(I1);
I = rgb2gray(I1);
%% test ade
% make template
pos=[1 1 7 7];
NHbase=imcrop(I,pos);
imagesc(I), axis equal
h = imrect(gca, pos);
[Lw] = adefilt(I,'NHbase',NHbase);% use default values
Ibig=cell2mat(Lw);
imagesc(Ibig)
%% Ade with selected eigenvalues (stronges N)
[Lw] = adefilt(I,'NHbase',NHbase,'lambdaselect',[2:6]);% use default values
Lall=[double(I),Lw];
Lall1=reshape(Lall,3,2);
Ibig=cell2mat(Lall1);
imagesc(Ibig)
%% use more templates
% NHbase is template region
pos=[1 1 0 0]+[1 0 1 1]*512/16;
NHbase=imcrop(I,pos);
imagesc(I), axis equal
h = imrect(gca, pos);
[Lw,V,EW] = adefilt(I,'NHbase',NHbase,'Fsize',7,'lambdaselect',[2:6]);% use default values
%%
imagesc(cell2mat(Lw))
Lall=[double(I),Lw];
Lall=reshape(Lall,3,2);
Ibig=cell2mat(Lall);
imagesc(Ibig)
   
