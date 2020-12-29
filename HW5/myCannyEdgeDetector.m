% Homework #5
% Name: Wenxuan Wang; UF Gatorlink username: wenxuanwang; UFID: 64118211

function output = myCannyEdgeDetector(img,Low,High)
img = double (img); %double the image

Gaussian = fspecial('gaussian',[5 5],2);% Generate a normal Gaussian filter

Sm = conv2(img,Gaussian,'same');% Convolution of image by Gaussian to smooth

% Initialization for gradient computing mask

Gx = [-1, 0, 1; -2, 0, 2; -1, 0, 1]; %Sobel
Gy = [1, 2, 1; 0, 0, 0; -1, -2, -1];

% Convolute the smoothed image by horizontal and vertical filter 
Fil_x = conv2(Sm, Gx, 'same');
Fil_y = conv2(Sm, Gy, 'same');

dt = atan2 (Fil_y, Fil_x);
dt2 = dt*180/pi;

height = size(Sm,1);
width = size(Sm,2);

for i=1:height
    for j=1:width
        if (dt2(i,j)<0) 
            dt2(i,j)=360+dt2(i,j);
        end;
    end;
end;
dt3 = zeros(height, width);

% Calculate magnitude and phase
magnitude_pre = (Fil_x.^2) + (Fil_y.^2);
magnitude = sqrt(magnitude_pre);

%figure

%subplot(2,2,1);
%imshow(uint8(magnitude)),title('Gradient Magnitude'); 

phase = dt*180/pi;


%subplot(2,2,2);
%imshow(phase),title('Gradient Phase');

% Modify directions to the nearest 0, 45, 90, 138 degree
for i = 1  : height
    for j = 1 : width
        if ((dt2(i, j) >= 0 ) && (dt2(i, j) < 22.5) || (dt2(i, j) >= 157.5) && (dt2(i, j) < 202.5) || (dt2(i, j) >= 337.5) && (dt2(i, j) <= 360))
            dt3(i, j) = 0;
        elseif ((dt2(i, j) >= 22.5) && (dt2(i, j) < 67.5) || (dt2(i, j) >= 202.5) && (dt2(i, j) < 247.5))
            dt3(i, j) = 45;
        elseif ((dt2(i, j) >= 67.5 && dt2(i, j) < 112.5) || (dt2(i, j) >= 247.5 && dt2(i, j) < 292.5))
            dt3(i, j) = 90;
        elseif ((dt2(i, j) >= 112.5 && dt2(i, j) < 157.5) || (dt2(i, j) >= 292.5 && dt2(i, j) < 337.5))
            dt3(i, j) = 135;
        end;
    end;
end;

% Non-Max Suppression
L_max = zeros(height,width);
for i=2:height-1
    for j=2:width-1
        if (dt3(i,j)==0)
            L_max(i,j) = (magnitude(i,j) == max([magnitude(i,j), magnitude(i,j+1), magnitude(i,j-1)]));
        elseif (dt3(i,j)==45)
            L_max(i,j) = (magnitude(i,j) == max([magnitude(i,j), magnitude(i+1,j-1), magnitude(i-1,j+1)]));
        elseif (dt3(i,j)==90)
            L_max(i,j) = (magnitude(i,j) == max([magnitude(i,j), magnitude(i+1,j), magnitude(i-1,j)]));
        elseif (dt3(i,j)==135)
            L_max(i,j) = (magnitude(i,j) == max([magnitude(i,j), magnitude(i+1,j+1), magnitude(i-1,j-1)]));
        end;
    end;
end;
L_max = L_max.*magnitude;

% Hysteresis Thresholding
Low = Low * max(max(L_max));
High = High * max(max(L_max));
T_res = zeros (height, width);
for i = 1  : height
    for j = 1 : width
        if (L_max(i, j) < Low)
            T_res(i, j) = 0;
        elseif (L_max(i, j) > High)
            T_res(i, j) = 1;
        % Using 8-connected method and perform edge linking
        elseif (L_max(i+1,j)>High || L_max(i-1,j)>High || L_max(i,j+1)>High || L_max(i,j-1)>High || L_max(i-1, j-1)>High || L_max(i-1, j+1)>High || L_max(i+1, j+1)>High || L_max(i+1, j-1)>High)
            T_res(i,j) = 1;
        end;
    end;
end;



%Show final result
%subplot(2,2,3);
c_img = uint8(T_res.*255);
%imshow(c_img),title('Thresholded Gradient Magnitude')

% Image Recovery
e_img = zeros(height,width,3);

e_img(:,:,1) = img;
e_img(:,:,2) = img;
e_img(:,:,3) = img;

for i = 1:height
    for j =1:width
        if c_img(i,j) == 255;
            e_img(i,j,1) = 0;
            e_img(i,j,2) = 0;
            e_img(i,j,3) = 255;
        end
    end
end

output = e_img

figure
%subplot(2,2,4);
imshow(uint8(output)),title('Output Pseudocolor Image');
