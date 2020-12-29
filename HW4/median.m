clc;clear;
image = imread('escher.png');
tic
med = medfilt2(image, [403 403]);
figure
imshow(med);
toc
