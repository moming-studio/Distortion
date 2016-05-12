%% Note
% image correction

%% Section 1 Title
% Description of first code block
clc;
close all; 
clear all;
%read image
f = imread('060.bmp');
data = double(f);
[M, N] = size(f);
figure(1);
imshow(f);
%% Section 2 Title
% Description of second code block
x = [106 117 131 148 168 190 215 247 282 320 360 400 437 472 502 527 549 567 583]-360;
y = 288 - [121 112 100 86   73  60  48  36  27  22  20  22  29  39  50 62  75  86  98];
[MM, NN] = size(x);
[R,A,B] = fitellipse(x,y); 

z = R/2-110;
data_then = zeros(M,N);
%a=665;b=198;h=62;

for i = 1:M
   for j = 1:N
        x = j - 360;  %×ø±ê×ª»»
        y = 288 - i;
       
         u =R*x*( (z*z+x*x+y*y).^0.5-z )/(x*x+y*y);
        
        v =R*y*( (z*z+x*x+y*y).^0.5-z )/(x*x+y*y);
      
        %u1=(u-b/2)*b*h/(a*h+(b-a)*v)+b/2;
        
%         u = 22/21*R*x*( (z*z+x*x+y*y).^0.5-z )/(x*x+y*y);
%         v =23/21* R*y*( (z*z+x*x+y*y).^0.5-z )/(x*x+y*y);
%         
        %u=(x-x0)*(R.^2-(y-y0)^2)^0.5/R+x0;
       % v=y;
        
        i_index = 288 - v;
        j_index = 360 + u;
        
        i_index = uint32(i_index);
        j_index = uint32(j_index);
        
        if(i_index<1 || i_index>576 ||j_index<1|| j_index>720)
            data_then(i,j) = 0;
        else
            data_then(i,j) = data(i_index,j_index);
        end
   end
end
 

figure;imshow(uint8(data_then));
clc;



