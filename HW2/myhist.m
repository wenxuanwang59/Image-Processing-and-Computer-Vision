% Homework #2 
% Name: Wenxuan Wang; UF Gatorlink username: wenxuanwang; UFID: 64118211
% Use the command in the window: output = myhist(imread('imagename.png'))
function num = myhist(Image)

[rows, columns] = size(Image); %read theimage size
num = zeros(1, 256);%Initialization

for col = 1 : columns %obtain each pixel value
	for row = 1 : rows
		pix= Image(row, col); %obatin the intensity value of each pixel
		num(pix+1) = num(pix+1) + 1;
	end
end

%plot
pix = 0 : 255;
bar(pix, num);
hold('on');

xlabel('Pixel Value');        %set x-label 
ylabel('Number of each single value');     %set y-label                         
title('Histogram');               %set title
end
