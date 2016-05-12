%% 基于经度坐标的鱼眼校正
clear all
clc
%%
A=imread('3.jpg');
T=40;
[A,R]=kuaisusaomiao(A,T);
[m,n,k]=size(A);
C=[];
x=n/2;
y=m/2;
for u=1:m
    for v=1:n
        i = u;
        j = sqrt(R^2-(y-u)^2)*(v-x)/R+x;
        if(R^2-(y-u)^2<0)
            continue;
        end
        jl = floor(j);
        delta = (j-jl);
        
        C(u,v) = A(i,jl)*(1-delta) + A(i,jl+1)*delta;
    end
end
C=uint8(C);
imshow(C);
% imwrite(C,'method_1_1.jpg');