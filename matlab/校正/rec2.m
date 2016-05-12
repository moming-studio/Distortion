

clc;close all; clear all;

f = imread('060.bmp');
data = double(f);
[M N] = size(f);
figure;imshow(f);

x = [106 117 131 148 168 190 215 247 282 320 360 400 437 472 502 527 549 567 583]-360;
y = 288 - [121 112 100 86   73  60  48  36  27  22  20  22  29  39  50 62  75  86  98];
% x =     [77  85  92  104 118 137 162 195 239 295 359 421 477 520 551 576 595 609 621]-360;
% y = 288-[224 219 214 206 198 189 178 167 155 146 144 146 155 164 174 184 192 200 205];
[MM NN] = size(x);

[R,A,B] = circ(x,y,NN); 


z = R/2-110;
%z=90;
data_then = zeros(M,N);

for i = 1:M
   for j = 361:N
        x = j - 360;  %坐标转换
        y = 288 - i;
       
         u = R*x*( (z*z+x*x+y*y).^0.5-z )/(x*x+y*y);
        v = R*y*( (z*z+x*x+y*y).^0.5-z )/(x*x+y*y);
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

    
 
 
%x1=47-360;x2=601-360;x3=35-360;
%y1=288-290;y2=288-277;y3=288-70;

x1=361-360;x2=688-360;x3=361-360;x4=466-360;x3_1=361-360;
y1=288-343;y2=288-343;y3=288-270;y4=288-270;y3_1=288-270;

data_then_1 = zeros(M,N); 
%for g=70:290
    %for k=35:601
for g=1:M;
   for k=361:N;
        x_pie=g-360;
        y_pie=288-k;
       x_1=x1+(x_pie-x1)*(x2+(x4-x2)*(y_pie-y2)/(y4-y2))/(x3_1-x1);     %第一次校正
       y_1=270;
       
       x_2=x_1+360;
       y_2=288-y_1;
       
       x_2=uint8(x_2);
       y_2=uint8(y_2);
       
       if(x_2<1 || x_2>720 ||y_2<1|| y_2>576)
            data_then_1(i,j) = 0;
       else
            data_then_1(g,k) = data_then(x_2,y_2);
       end 
    end
end


figure;imshow(uint8(data_then_1));   %3






    