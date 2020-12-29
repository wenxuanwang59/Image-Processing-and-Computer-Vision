% Homework #4
% Name: Wenxuan Wang; UF Gatorlink username: wenxuanwang; UFID: 64118211
% Use the command: imgconv = myFrequencyFilt(image,filter);

function imgconv = myFrequencyFilt(image,filter)

image = double(image); % Transform it into double type
[height,width] = size(image); % Read the size of image


% Compute convolution of Frequency domain
imgconv_tmp = fft2(image).*fft2(filter,height,width);
imgconv = ifft2(imgconv_tmp);

% Compute phase 
phase = (angle(fft2(image))/pi)*255;

% Use the method in the homework1 to shift DFT 
size_tmp = size(fft2(image));
tmp = floor(size_tmp/2);

% Seperate image to four parts
F_image = fft2(image);
F_image = F_image([tmp(1)+1:end, 1:tmp(1)],[tmp(2)+1:end,1:tmp(2)]);
% Computing the magnitude 
magnitude = log(abs(F_image));


%Plot
subplot(1,3,1);
imshow(magnitude,[]);
title('magnitude of input')
subplot(1,3,2);
imshow(phase,[]);
title('phase of input')
subplot(1,3,3);
imshow(uint8(imgconv));
title('Filtered Image')

end