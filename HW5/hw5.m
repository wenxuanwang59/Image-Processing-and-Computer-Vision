% Student Name：Wenxuan Wang
% Student Username:wenxuanwang
% hw5 testing code
clc;clear;
%% Read Images - Do not edit, you may assume all programs and files are in the same folder
img1 = imread('img1.pgm');
img2 = imread('img2.pgm');
img3 = imread('img3.pgm');

%% Run myCannyEdgeDetector - edit only parameters in myCannyEdgeDetector
edges1 = myCannyEdgeDetector(img1,0.075,0.175);
edges2 = myCannyEdgeDetector(img2,0.075,0.175);
edges3 = myCannyEdgeDetector(img3,0.075,0.175);

%% Run myHarrisCornerDetector - edit only parameters in myHarrisCornerDetector
corners1 = myHarrisCornerDetector(img1,0.04);
corners2 = myHarrisCornerDetector(img2,0.04);
corners3 = myHarrisCornerDetector(img3,0.04);