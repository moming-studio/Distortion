%% �������
clear all
clc
%% 
rgb = imread('060.bmp');
% rgb = imread('2.jpg');
[height, width, v] = size(rgb);
[X0, Y0, R] = Yuan(rgb);%�õ�Բ��Բ�ĺͰ뾶
% imshow(rgb);
%% ��û���ƽ��������У��ƽ�����Ķ�Ӧ������
x0 = round(X0);
y0 = round(Y0);
r = round(R);
u0 = x0;
v0 = y0;
%% 
Image = zeros(height,width,v);
I = rgb;
%% ���ھ�������У������ͼ��
for v=2:height-1   
    for u=2:width-1
      %�����겻�䣬������ı�
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



















