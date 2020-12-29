clc;clear;
image = imread('escher.png');

filter = fspecial('gaussian',[11 1],(11/6));

tic
imgconv = mySpatialFilt(image,filter);
toc 



filter = fspecial('gaussian',[1 11],(11/6));

tic
imgconv = mySpatialFilt(imgconv,filter);
toc