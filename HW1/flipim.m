%difine the funcation flipm
%set the input as the name 'input'
%set the output as the name 'output'
function output=flipim(Input)

%define the column and row
y = size(Input,1);
x = size(Input,2); 
%define the thickness of the image
ch = size(Input,3); 

% Rarrage the first quadrant 
output(1:y/2,1:x/2,:)=Input((y/2)+1:y,(x/2+1):x,:);

% Rarrage the second quadrant
output(1:y/2,(x/2+1):x,:)=Input(y/2+1:y,1:(x/2),:);

% Rarrage the third quadrant 
output((y/2)+1:y,1:x/2,:)=Input(1:y/2,(x/2)+1:x,:);

% Rarrage the fourth quadrant
output((y/2)+1:y,(x/2+1):x,:)=Input(1:y/2,1:(x/2),:);

% Display the image (both the original and the returned one)
% show their sizes and compare
subplot(2,1,1)
imshow(Input);title(['Input Size: ',num2str(y),'*',num2str(x),'*',num2str(ch)]); 
 %the input image size.

subplot(2,1,2)
imshow(output);title(['Output Size: ',num2str(size(output,1)),'*',num2str(size(output,2)),'*',num2str(size(output,3))]);
% the output image size.

%In the command window, please firstly use clear command to clear the
%window, and then use the command 'flipim(imread('imagename.suffix'))'
 
