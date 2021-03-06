%% 基于经纬度映射法校正鱼眼图像 反向映射
clear all
clc
A=imread('2.jpg');
[A,R]=kuaisusaomiao(A,40);
[m,n,k]=size(A);
for i=1:m
    for j=1:n
       %% 规格化坐标系  
        u=j-R;
        v=R-i;
        r=sqrt(u^2+v^2);
        if(r==0)
            fi=0;
        elseif(u>=0)
           fi=asin(v/r);
        else
            fi=pi-asin(v/r);
        end
        
       %% 鱼眼图像映射到球坐标系中去
        f=R*2/pi;
        theta=r/f;%实景方向向量的入射角（垂直于球面过球心）这个角度的真实含义是该点位置离圆心的距离等距为角度距离（等距校正模型）
        
        x=f*sin(theta)*cos(fi);
        y=f*sin(theta)*sin(fi);
        z=f*cos(theta);%z值不可能是负值，由建立的模型可知，正向映射的数据必须保证数据应该来自于圆内的数据
        if(z<=0)
            continue;
        end
        
       %% 重选择坐标系 圆坐标系
        rr=sqrt(x^2+z^2);
        sita=pi/2-atan(y/rr);
        if(z>=0)
            fai=acos(x/rr);
        else
            fai=pi-acos(x/rr);
        end
       %% 最后投射变换
        xx=round(f*sita);
        yy=round(2*R-f*fai);
        
        if(xx<1||yy<1||xx>m||yy>n)
            continue;
        end
        C(xx,yy)=A(i,j);

    end
end

imshow(uint8(C))