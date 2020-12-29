% Homework #2 
% Name: Wenxuan Wang; UF Gatorlink username: wenxuanwang; UFID: 64118211
% Use the command: output = myquantize(imread('avengers.png'),quant_num)
function Out_Image = myquantize(Image,quant_num)


Image = double(Image);%transform it into double type
Out_Image = uint8(floor(Image/(256/quant_num))*(256/quant_num)); 
%explanation: quant_num represents the number of gray levels. 256/quant_num
%means that we can get the interval. And then we can use the floor
%function, so that we can get the lower bound. The value after floor
%computation multiple the interval, we get get the output matrix. And use
%uint8 to get the integer value.

figure(1); %plot the output image
imshow(Out_Image);
title('Quantized version of the image'); %set the title
end
