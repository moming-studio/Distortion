% ��άͼ����ת�Լ�˫���ԻҶȲ�ֵ�㷨��ʵ��
% Ref. ��ع��. ͼ�񹤳̣��ϲᣩ����ͼ����. �廪��ѧ������
% Author: lskyp Date: 2009.08.12
tic
clc;close all;
clear all;
im_init = imread('060.bmp');
im_init = double(im_init);

im_height = size(im_init,1);
im_width = size(im_init,2);

%[im_width im_height]=size(im_init);
% �ֱ���Ҷ�ͼ���RGBͼ��
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
      % ƽ����ԭ�㣬��ת��Ȼ����ƽ�ƻ�ȥ
      
      
     m=h - im_height/2;
     n=w - im_width/2;
     
     
      if (m^2+n^2)<r^2
          
          
      x=(m*r)/sqrt(r^2-n^2);
      %x=r*(m-im_width/2)/(sqrt(r^2-n^2))+im_width/2;
      % x=m;
       y=(n*r)/sqrt(r^2-m^2);
        
	   %y=n;
      new_position =  [x;y] + [im_height/2;im_width/2];
      
      
      
      
      
       % ��������Ϊͼ�����Ĵ�Ϊԭ�㣬�����ֲ�����ϵ����������������
      % ��ת����ƽ�ƻ�ȥ
       new_position(1) = mod(new_position(1),im_height);
       new_position(2) = mod(new_position(2),im_width);
          % ������ת�п��ܻ��ܳ�ͼ��߽磬������ģ����
           % ���ǿ��Ʋ�����Χ�ĺ÷���
         if new_position(1) <= 1
          new_position(1) = 1;  
         end
         if new_position(2) <= 1
         new_position(2) = 1;
         end
      % ��Ȼ��ͼ����Ĭ���Ǵ�1��ʼ���������Բ��ܳ���0
             % �����λ��Ϊ��������ôֱ�Ӹ���Ҷ�ֵ����RGBֵ
         % ���򣬰���˫���Բ�ֵ���㣬ʹ�ú���ӳ��
    
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
% ������Գ���Ӧ��finalλ�õ���������ת������λ�ö�Ӧ��ԭͼ������ֵ

     
end
end
if ndims(im_init) == 3

im_final(:,:,1) = R_final;
im_final(:,:,2) = G_final;
im_final(:,:,3) = B_final;
else
im_final = im2uint8(mat2gray(im_final));
end
% ����ͼ��
figure;
subplot(1, 2, 1);
imshow(im2uint8(mat2gray(im_init)));
title('ԭʼͼ��')
subplot(1, 2, 2);


imshow(uint8(im_final))

title('��תͼ��')

toc
time=toc;
clc;