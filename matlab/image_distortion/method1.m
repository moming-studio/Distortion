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
% rgb = 
%% 基于经度坐标校正鱼眼图像
for v=1:height   
    for u=1:width
      %纵坐标不变，横坐标改变
        xq = (u-width/2);
        yq = (v-height/2);
        x1 = xq/R;
        y1 = yq/R;
        m = sin(x1);
        n = cos(x1);
        p = atan((sqrt(y1*y1+m*m))/n);
        q = m/(sqrt(y1*y1+m*m));
        t = y1/(sqrt(y1*y1+m*m));
        x = r*p*q+(width)/2;
        y = r*p*t+(height)/2;
        ix = floor(x);
        iy = floor(y);
        delta = x-ix;
        if(x>0 && y>0 &&y<576&&x<720)
            Image(v,u) = rgb(iy,ix)*(1-delta)+rgb(iy,ix+1)*delta;
        end


        
        
        
        
    end
    
end
% i = imresize(Image,[720 576 ],'bilinear');
figure(1);
imshow(uint8(Image));



















