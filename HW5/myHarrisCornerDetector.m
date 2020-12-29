% Homework #5
% Name: Wenxuan Wang; UF Gatorlink username: wenxuanwang; UFID: 64118211

function output =myHarrisCornerDetector(img,k)
% Harris corresponding parameter, the general value range is 0.04-0.06, and 0.05 is used in this function

img = double(img);%double the image

% Apply Sobel Edge Detector in the horizontal and vertical direction 
Gx = [-1, 0, 1; -2, 0, 2; -1, 0, 1]; 
x=filter2(Gx,img);

Gy = [1, 2, 1; 0, 0, 0; -1, -2, -1];
y=filter2(Gy,img);

%Calculate gradients in the horizontal and vertical direction
x2=x.^2;
y2=y.^2;
xy=x.*y;


gaussian=fspecial('gaussian',[5,5],2); % Generate a normal Gaussian filter

x2=filter2(gaussian,x2);
y2=filter2(gaussian,y2);
xy=filter2(gaussian,xy);

% Calculate the Harris response value of each pixe
hei = size(img,1);
wid = size(img,2);
R = zeros(hei,wid);
Rmax = 0;
% Harris response value at pixel (i, j)
for i=1:hei
    for j=1:wid
        H=[x2(i,j) xy(i,j);xy(i,j) y2(i,j)];
         R(i,j)=det(H)-k*(trace(H))^2; % Harris corresponding parameter is set as 0.04 
         if R(i,j) > Rmax
             Rmax = R(i,j);
         end
    end
end

%figure
%subplot(1,2,1)
%imshow(uint8(R)),title('Harris Response Before Non-Maximum Suppression');

% Thresholding 
th=0.01*Rmax;
for i=1:hei
    for j=1:wid
        if R(i,j)<th
            R(i,j)=0;
        end
    end
end

% Non-maximum suppression
result=imregionalmax(R);

% Convert to RGB 
output = zeros(hei,wid,3);
output(:,:,1) = img;
output(:,:,2) = img;
output(:,:,3) = img;
[posr,posc]=find(result==1);

% Change those corner points to red (255,0,0)
for i = 1: length(posr)
    w = posr(i);
    e = posc(i);
   output(w,e,1)= 255;
   output(w,e,2)= 0;
 output(w,e,3)= 0;
end

figure
%subplot(1,2,2)
imshow(uint8(output)),title('Output Pseudocolor Image');
% square points
hold on

for i = 1:length(posr)
  plot(posc(i),posr(i),'r.');
end

end