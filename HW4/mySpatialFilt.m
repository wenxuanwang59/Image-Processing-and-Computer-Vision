% Homework #4
% Name: Wenxuan Wang; UF Gatorlink username: wenxuanwang; UFID: 64118211
% Use th command: imgconv =  mySpatialFilt(image,filter);

function imgconv = mySpatialFilt(image,filter)

image = double(image); % transform it into double type
[height,width] = size(image); % Read the size of image
[y,x] = size(filter); % Read the size of filter
fill_pad = floor(max(x,y));

% Initialization
imgconv = zeros(height,width);          
img_pad = zeros(height+2*fill_pad,width+2*fill_pad);

% Pad
img_pad = padarray(image,[floor(fill_pad/2) floor(fill_pad/2)],'symmetric');

% Use for loop to compute the convolution 
for i = 1:height
    for j = 1:width
        imgconv(i,j) = sum(sum(filter.*(img_pad(i:i+y-1,j:j+x-1))));
    end
end

figure
subplot(1,2,1)
img_pad_out = uint8(img_pad);
imshow(img_pad_out);
title('The image of Mirror Reflection Padding')

subplot(1,2,2)
conv_output = uint8(imgconv);
imshow(conv_output);
title('The image after Convolution')
end
