% 两维图像旋转以及双线性灰度差值算法的实现
% Ref. 章毓晋. 图像工程（上册）——图像处理. 清华大学出版社
% Author: lskyp Date: 2009.08.12
tic
clc;close all;
clear all;
im_init = imread('060.bmp');
im_init = double(im_init);

im_height = size(im_init,1);
im_width = size(im_init,2);

%[im_width im_height]=size(im_init);
% 分别处理灰度图像和RGB图像
if ndims(im_init) == 3
im_final = zeros(im_height,im_width,3);
R = im_init(:,:,1);
G = im_init(:,:,2);
B = im_init(:,:,3);
R_final = im_final(:,:,1);
G_final = im_final(:,:,2);
B_final = im_final(:,:,3);
else
im_final = zeros(im_height,im_width);
end
r=im_width;
for h = 1:im_height
   for w = 1:im_width
      % 平移至原点，旋转，然后再平移回去
      
      
     m=h - im_height/2;
     n=w - im_width/2;
     
     
      if (m^2+n^2)<r^2
          
          
      x=(m*r)/sqrt(r^2-n^2);
      %x=r*(m-im_width/2)/(sqrt(r^2-n^2))+im_width/2;
      % x=m;
       y=(n*r)/sqrt(r^2-m^2);
        
	   %y=n;
      new_position =  [x;y] + [im_height/2;im_width/2];
      
      
      
      
      
       % 这里是认为图像中心处为原点，建立局部坐标系，方向还是向下向右
      % 旋转后，再平移回去
       new_position(1) = mod(new_position(1),im_height);
       new_position(2) = mod(new_position(2),im_width);
          % 由于旋转有可能会跑出图像边界，进行了模操作
           % 这是控制操作范围的好方法
         if new_position(1) <= 1
          new_position(1) = 1;  
         end
         if new_position(2) <= 1
         new_position(2) = 1;
         end
      % 当然，图像阵默认是从1开始计量，所以不能出现0
             % 如果新位置为整数，那么直接赋予灰度值或者RGB值
         % 否则，按照双线性插值计算，使用后向映射
    
    if ndims(im_init) == 3
        new_position(1) = round(new_position(1));
       new_position(2) = round(new_position(2));
        R_final(new_position(1),new_position(2)) = R(h,w);
        if(new_position(1)>1)&&(new_position(2)>1)
        if(new_position(1)<im_height)&&(new_position(2)<im_width)
         R_final(new_position(1)+1,new_position(2)) = R(h,w);
         R_final(new_position(1)-1,new_position(2)) = R(h,w);
         R_final(new_position(1),new_position(2)+1) = R(h,w);
         R_final(new_position(1),new_position(2)-1) = R(h,w);
        end
        end
           G_final(new_position(1),new_position(2)) = G(h,w);
    if(new_position(1)>1)&&(new_position(2)>1)
    if(new_position(1)<im_height)&&(new_position(2)<im_width)
      G_final(new_position(1)+1,new_position(2)) = G(h,w);
      G_final(new_position(1),new_position(2)+1) = G(h,w);
      G_final(new_position(1)-1,new_position(2)) = G(h,w);
      G_final(new_position(1),new_position(2)-1) = G(h,w);
    end
    end
      B_final(new_position(1),new_position(2)) = B(h,w);
    if(new_position(1)>1)&&(new_position(2)>1)
    if(new_position(1)<im_height)&&(new_position(2)<im_width)
     B_final(new_position(1)+1,new_position(2)) = B(h,w);
     B_final(new_position(1)-1,new_position(2)) = B(h,w);
     B_final(new_position(1),new_position(2)+1) = B(h,w);
     B_final(new_position(1),new_position(2)-1) = B(h,w);
    end
    end
    else
   im_final(h,w) = im_init(uint32(new_position(1)),uint32(new_position(2)));
    end
   
    end
% 这里可以出对应的final位置的像素是旋转后所在位置对应的原图像像素值

     
end
end
if ndims(im_init) == 3

im_final(:,:,1) = R_final;
im_final(:,:,2) = G_final;
im_final(:,:,3) = B_final;
else
im_final = im2uint8(mat2gray(im_final));
end
% 整合图像
figure;
subplot(1, 2, 1);
imshow(im2uint8(mat2gray(im_init)));
title('原始图像')
subplot(1, 2, 2);


imshow(uint8(im_final))

title('旋转图像')

toc
time=toc;
clc;