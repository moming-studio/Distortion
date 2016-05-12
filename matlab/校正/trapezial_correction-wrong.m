clear all; close all;
image_original=imread('C:\Documents and Settings\Administrator\桌面\校正\correct_image_061g.bmp');
figure;imshow(image_original);
point_1=[414,508];
point_2=[111,722];


%计算摄像机与地面相对空间位置
size_image=size(image_original);
center=size_image./2;
co_1=[size_image(1)-point_1(1),point_1(2)];
co_2=[size_image(1)-point_2(1),point_2(2)];
up_length=co_1(1)-point_1(1);
down_length=co_2(1)-point_2(1);
side_length=down_length;
down_image_test=uint8(zeros(side_length,side_length));
height=point_2(2)-point_1(2);
% angle=cotan(((up_length-down_length)/2)/height);
distance=side_length*(up_length/2)/(point_1(1)-point_2(1));
height_of_cam=height*(distance+side_length)/side_length;


%恢复部分图像_模型测试用
for n=1:side_length   %横向
    for m=1:side_length  %纵向
        plane_distance_to_axis(m,n)=sqrt((side_length/2-n)^2+(side_length-m+distance)^2);
        x_origin(m,n)=-distance*(side_length/2-n)/((side_length-m+distance))+side_length/2;
        temp=(1-distance/(side_length-m+distance))*plane_distance_to_axis(m,n);
        y_origin(m,n)=temp*height_of_cam/plane_distance_to_axis(m,n);
        down_image_test(m,n)=image_original(round(point_2(2)-y_origin(m,n)),round(point_2(1)+x_origin(m,n)));
    end
end
imshow(uint8(down_image_test));


% 图像整体恢复
% recover_range=500;
% height_of_cam_recover=height_of_cam+(size_image(2)-point_2(2));
% length_of_image=
% for 
imwrite(down_image_test,'C:\Documents and Settings\Administrator\桌面\校正\jiaozheng.bmp');