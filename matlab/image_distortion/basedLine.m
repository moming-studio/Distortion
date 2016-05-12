%% 清除缓存
clear all
clc
%% 
rgb = imread('060.bmp');
% rgb = imread('2.jpg');
[height, width, v] = size(rgb);
[X0, Y0, R] = Yuan(rgb);%得到圆的圆心和半径
% imshow(rgb);
%% 求得畸变平面中心在校正平面中心对应的中心
x0 = round(X0);
y0 = round(Y0);
r = round(R);
u0 = x0;
v0 = y0;
%% 
Image = zeros(height,width,v);
I = rgb;
%% 基于经度坐标校正鱼眼图像
for v=2:height-1   
    for u=2:width-1
      %纵坐标不变，横坐标改变
      y = v;
      x = x0 +(u-u0)*(sqrt(R^2-(v-v0)^2))/R;
      xl = floor(x);
      xh = xl+1;
      delta = xl-x;
%       if(x>720||x<0)
%           continue;
%       end
      Image(v,u) = I(y,xl)*(1-delta)+I(y,xh)*delta;
     
    end
    
end
% i = imresize(Image,[720 576 ],'bilinear');
figure(1);
imshow(uint8(Image));



















