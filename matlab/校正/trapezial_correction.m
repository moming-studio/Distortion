clear all; close all;
 image_original=imread('C:\Documents and Settings\Administrator\桌面\校正\correct_image_061g.bmp');
% figure;imshow(uint8(image_original));
point_1=[727,1009];
point_2=[64,1185];


%计算摄像机与地面相对空间位置
size_image=size(image_original);
center=size_image./2;
co_1=[size_image(1)-point_1(1),point_1(2)];
co_2=[size_image(1)-point_2(1),point_2(2)];
up_length=co_1(1)-point_1(1);
down_length=co_2(1)-point_2(1);
width=down_length;
length=width/3;
down_image=uint8(zeros(length,width));
height=point_2(2)-point_1(2);
% angle=cotan(((up_length-down_length)/2)/height);
distance=length*(up_length/2)/(point_1(1)-point_2(1));
height_of_cam=height*(distance+length)/length;


%恢复部分图像_模型测试用
for n=1:width%横向
    for m=1:length%纵向
        plane_distance_to_axis(m,n)=sqrt((width/2-n)^2+(length-m+distance)^2);
        x_origin(m,n)=-distance*(width/2-n)/((length-m+distance))+width/2;
        temp=(1-distance/(length-m+distance))*plane_distance_to_axis(m,n);
        y_origin(m,n)=temp*height_of_cam/plane_distance_to_axis(m,n);
        down_image_test(m,n)=image_original(round(point_2(2)-y_origin(m,n)),round(point_2(1)+x_origin(m,n)));
    end
end
imshow(uint8(down_image_test));

% new_point_1=
% new_point_2=

% % 图像整体恢复
% recover_range=500;
% height_of_cam_recover=height_of_cam+(size_image(2)-point_2(2));
% length_of_image=
% co_1=[size_image(1)-new_point_1(1),new_point_1(2)];
% co_2=[size_image(1)-new_point_2(1),new_point_2(2)];
% up_length=co_1(1)-new_point_1(1);
% down_length=co_2(1)-new_point_2(1);
% for 
imwrite(down_image,'C:\Documents and Settings\Administrator\桌面\校正\jiaozheng.bmp');