%% ���ھ�γ��ӳ�䷨У������ͼ�� ����ӳ��
clear all
clc
A=imread('2.jpg');
[A,R]=kuaisusaomiao(A,40);
[m,n,k]=size(A);
for i=1:m
    for j=1:n
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
        f=R*2/pi;
        theta=r/f;
        x=f*sin(theta)*cos(fi);
        y=f*sin(theta)*sin(fi);
        z=f*cos(theta);
        rr=sqrt(x^2+z^2);
        sita=pi/2-atan(y/rr);
        if(z>=0)
            fai=acos(x/rr);
        else
            fai=pi-acos(x/rr);
        end
        xx=round(f*sita);
        yy=round(2*R-f*fai);
        if(xx<1||yy<1||xx>m||yy>n)
            continue;
        end
        C(xx,yy,1)=A(i,j,1);

    end
end

imshow(uint8(C))