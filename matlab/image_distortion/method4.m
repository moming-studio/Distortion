%% ���ھ�γ��ӳ�䷨У������ͼ�� ����ӳ��
clear all
clc 
close all
A=imread('2.jpg');
[A,R]=kuaisusaomiao(A,40);
[m,n,k]=size(A);
for i=1:m*1
    for j=1:n
    %% ��������֪������У����ͼ���λ��Ҳ����i,j
    %step.1 ��ԭ������
    % xx=round(f*sita);
    % yy=round(2*R-f*fai);
     f=R*2/pi;
    sita = j/f;
    fai = (2*R-(i/1))/f;
    %% ��ԭ������ϵ�ĵѿ�������ϵ��ֵ
    % ��֮ǰ����ϵsita �� fai�Ķ����֪
    y = cos(sita);
    x = sin(sita)*cos(fai);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
    
    %�����㷨
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     z = R*sin(sita)*sin(fai);
    %����Ҫ֪������λ�õĵ�u��v��ֵ����ô���ֵ��x,y,x,z֮��Ĺ�ϵ��ʲô�أ�
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