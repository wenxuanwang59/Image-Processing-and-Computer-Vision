clc;clear;
image = imread('escher.png');
k = 11;
filter = fspecial('gaussian',[k k],(k/6));

tic
imgconv = myFrequencyFilt(image,filter);
toc 





