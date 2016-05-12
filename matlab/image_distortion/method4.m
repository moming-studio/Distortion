%% 基于经纬度映射法校正鱼眼图像 反向映射
clear all
clc 
close all
A=imread('2.jpg');
[A,R]=kuaisusaomiao(A,40);
[m,n,k]=size(A);
for i=1:m*1
    for j=1:n
    %% 首先我们知道的是校正后图像的位置也就是i,j
    %step.1 还原球坐标
    % xx=round(f*sita);
    % yy=round(2*R-f*fai);
     f=R*2/pi;
    sita = j/f;
    fai = (2*R-(i/1))/f;
    %% 还原球坐标系的笛卡尔坐标系的值
    % 由之前坐标系sita 和 fai的定义可知
    y = cos(sita);
    x = sin(sita)*cos(fai);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
    
    %修正算法
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     z = R*sin(sita)*sin(fai);
    %现在要知道成像位置的的u和v的值，那么这个值和x,y,x,z之间的关系是什么呢？
    %This step is very important 
    u = x*R;
    v = y*R;
    uu = round(u + R);
    vv = round(R-v);
    
     if(vv<1||uu<1||vv>m||uu>n)
          C(j,i) = 255;
          vv = 1;
            continue;
     end
  
    %%
         C(j,i)=A(vv,uu,1);

    end
end

imshow(uint8(C))
% imwrite(C,'method_4_1.jpg');