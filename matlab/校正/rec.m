f = imread('080.bmp');
data = double(f);
[M N] = size(f);
figure(1);imshow(f);

x = [106 117 131 148 168 190 215 247 282 320 360 400 437 472 502 527 549 567 583]-360;
y = 288 - [121 112 100 86   73  60  48  36  27  22  20  22  29  39  50 62  75  86  98];
% x =     [77  85  92  104 118 137 162 195 239 295 359 421 477 520 551 576 595 609 621]-360;
% y = 288-[224 219 214 206 198 189 178 167 155 146 144 146 155 164 174 184 192 200 205];
[MM NN] = size(x);
%R=288;A=360;B=288;
[R,A,B] = fitellipse(x,y); 

%figure;
%hold on;
%plot(x,y)
%x_circ = -360:360;
%y_circ = ( R.^2 - (x_circ-A).^2 ).^0.5 + B;
%plot(x_circ,y_circ);


%R1=380;
z = R/2-110;
data_then = zeros(M,N);
%a=665;b=198;h=62;
 %x0=360;y0=288;
for i = 1:M   %������
   for j = 1:N %������
        x = j - 360;  %����ת��
        y = 288 - i;
       
%          u =R*x*( (z*z+x*x+y*y).^0.5-z )/(x*x+y*y);
%         
%         v =R*y*( (z*z+x*x+y*y).^0.5-z )/(x*x+y*y);
%       
        %u1=(u-b/2)*b*h/(a*h+(b-a)*v)+b/2;
        
        u = 22/21*R*x*( (z*z+x*x+y*y).^0.5-z )/(x*x+y*y);
        v =23/21* R*y*( (z*z+x*x+y*y).^0.5-z )/(x*x+y*y);
%         
        %u=(x-x0)*(R.^2-(y-y0)^2)^0.5/R+x0;
       % v=y;
        
        i_index = 288 - v;
        j_index = 360 + u;
        
        i_index = uint32(i_index);
        j_index = uint32(j_index);
        
        if(i_index<1 || i_index>576 ||j_index<1|| j_index>720)
            data_then(i,j) = 0;
        else
            data_then(i,j) = data(i_index,j_index);
        end
   end
end
 

figure(2);imshow(uint8(data_then));

 data_then_1=zeros(576,576);

for g=1:576
    for k=1:576 
        i_index1=g;                               
        j_index1=k+16;
    if(i_index1<1 || i_index1>576 ||j_index1<1|| j_index1>576)
            data_then_1(g,k) = 0;
   else
            data_then_1(g,k) = data(i_index1,j_index1);
        end
   end
end     
figure(3);imshow(data_then_1);

% point_1=[727,1009];
% point_2=[64,1185];

point_1=[226,238];
point_2=[36,346];



%����������������Կռ�λ��
size_image=size(data_then_1);
center=size_image./2;
co_1=[size_image(1)-point_1(1),point_1(2)];
co_2=[size_image(1)-point_2(1),point_2(2)];
up_length=co_1(1)-point_1(1);  %���ε��ϵ�
down_length=co_2(1)-point_2(1); %���ε��µ�
width=down_length;       %У������ʾ�Ŀ��
length=width/3;      %У������ʾ�ĸ߶�
down_image=uint8(zeros(length,width));  %��ʼ��
height=point_2(2)-point_1(2);     %���εĸ߶�
% angle=cotan(((up_length-down_length)/2)/height);
% distance=height*(up_length/2)/(point_1(1)-point_2(1));
distance=length*(up_length/2)/(point_1(1)-point_2(1));    %tan��  %(point_1(1)-point_2(1))--����ĺ��������    ������
height_of_cam=height*(distance+length)/length;  %������ĸ߶�


%�ָ�����ͼ��_ģ�Ͳ�����
for n=1:width%����
    for m=1:length%����
        plane_distance_to_axis(m,n)=sqrt((width/2-n)^2+(length-m+distance)^2);
        x_origin(m,n)=-distance*(width/2-n)/((length-m+distance))+width/2;
        temp=(1-distance/(length-m+distance))*plane_distance_to_axis(m,n);
        y_origin(m,n)=temp*height_of_cam/plane_distance_to_axis(m,n);
        down_image_test(m,n)=data_then_1(round(point_2(2)-y_origin(m,n)),round(point_2(1)+x_origin(m,n)));
    end
end
figure(4);imshow(uint8(down_image_test));