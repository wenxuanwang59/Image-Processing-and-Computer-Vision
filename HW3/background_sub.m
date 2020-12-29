% Homework #3
% Name: Wenxuan Wang; UF Gatorlink username: wenxuanwang; UFID: 64118211
% Use the command: [ background_sub('PeopleWalking.mp4'); ]

function background_sub(input) 
% Load the video as v
v = VideoReader(input); 
%read the first frame randomly to obtain image size.
[h,w,c] = size(read(v,1)); 
total = ones(h,w);  
% Threshold setting
th = 100; 
for i = 1:100 % Read the first 100 frames
    % Read the video frames as images and split channels
    image = double(read( v, i )); 
    red = image( :, :, 1 ); 
    green = image( :, :, 2 ); 
    blue = image( :, :, 3 ); 
    % Using the first equation disccussed in class to get rgb to grayscale
    image = 1/3 * (red + green + blue ); 
    total = total + image; % sum those images up   
end
%compute the average with the computed total
average_image = 0.01 * total ;
imshow(uint8(average_image)); 
title('Average Image of the First 100 Frames');

for j = [1,20,40,80,100] 
    % read the 1st, 20th, 40th, 80th, 100th frame of video as rgb image
    image = double(read(v,j));
    figure;
    % Split channels of the following frames
    red = image(:,:,1);
    green = image(:,:,2); 
    blue = image(:,:,3); 
    % Using the first equation disccussed in class to get rgb to grayscale
    image = 1/3 * (red + green +blue);
    % Use absolute difference method compute background substraction  
    subs = abs(image - average_image); 
    % Binarizing the image by threshold we pick 
    subs(subs>=th) = 255; 
    subs(subs<th) = 0;    
    % Plot the original image from grayscale video
    subplot(1,2,1)
    imshow(uint8(image))
    title([int2str(j),'th Frame of original video'])
    % Plot the processed result
    subplot(1,2,2)
    imshow(uint8(subs));
    title(['Frame',int2str(j),'  ','Image after background substract']);  
    
end

end
