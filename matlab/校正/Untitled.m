
clc;close all; clear all;

f = imread('C:\Documents and Settings\Administrator\×ÀÃæ\a\060.bmp');
data = double(f);
[M N] = size(f);
figure;imshow(f);

%x = [106 117 131 148 168 190 215 247 282 320 360 400 437 472 502 527 549 567 583]-360;
%y = 288 - [121 112 100 86   73  60  48  36  27  22  20  22  29  39  50 62  75  86  98];
% x =     [77  85  92  104 118 137 162 195 239 295 359 421 477 520 551 576 595 609 621]-360;
% y = 288-[224 219 214 206 198 189 178 167 155 146 144 146 155 164 174 184 192 200 205];
%[MM NN] = size(x);
%R=288;A=360;B=288;
%[R,A B] = circ(x,y,NN); 
%[R,A B]=nihe(x,y);
%figure;
%hold on;
%plot(x,y)
%x_circ = -360:360;
%y_circ = ( R.^2 - (x_circ-A).^2 ).^0.5 + B;
%plot(x_circ,y_circ);



%z = R/2-110;
R=300;
A=N/2;B=M/2;
data_then = zeros(M,N);
% R=288;x0=360;y0=288;
for i = 1:M
   for j = 1:N
        x = j - 360;  %×ø±ê×ª»»
        y = 288 - i;
        
       % u = R*x*( (z*z+x*x+y*y).^0.5-z )/(x*x+y*y);
      %  v = R*y*( (z*z+x*x+y*y).^0.5-z )/(x*x+y*y);
        u=(x-A)*(R.^2-(y-B).^2)^0.5/R+A;
        v=y;
        
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
    