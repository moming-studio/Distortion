%  功能：纵向抛物线校正

clc;close all;clear all;

a = 400;
%b = 160;
Hnine = 1;

%load('b_m.mat')
%[XX YY] = size(b_m);
%data = imread('C:\CCStudio_v3.3\MyProjects\1\3.8.6 LaplacianSharp\bin\20120701\090-2.bmp');
data = imread('C:\Documents and Settings\Administrator\桌面\a\060.bmp');
[M N ] = size(data);


data(288,:) = 255;
data(:,360) = 255;
data(496,:) = 255;
data(287:289,359:261) = 255;
 figure;imshow(data);

test1 = 0;
test2 = 0;
test3 = 0;
test4 = 0;
rec1 = 0;
rec2 = 0;
data_then = zeros(M,N);
datatest = zeros(M,N);

ftest = zeros(M,N);

ftest = data;

x = 0;
y = 0;
%figure;

for ie = 1%1:150
    for y = -288:288 
       
       
%        b = b_m(ie,1);
%        m = b_m(ie,2)  ;


         b =-192;
         m = 409;
        a = -b/m.^2;
        offset = 300;
        fangcheng = @(yy) (a*((y+offset).^2 + b/a));
        
        
%         bb = -2;
%         aa = 368;
%         
%         
%         offset = 300;
%         fangcheng = @(yy) (bb*(1-(yy+offset).*(yy+offset)/aa/aa).^0.5);

%         k = -98/100;
%         b = 127;
%         offset = 0;
%         fangcheng = @(yy) (k*(y+offset) + b);

        x = fangcheng(y);        

       
      
       ftest(288,:) = 255;

        i_index = M/2 -  y;  % 论文坐标转矩阵坐标
        
        j_index = x + N/2 ;
        %i_index = M/2-i_index;
        
      

        
        i_index = uint32(i_index);
        j_index = uint32(j_index);
        if(i_index>M)
           i_index = M;
         %  test1 = test1 + 1;
       elseif(i_index<1)
          i_index = 1;
         %  test2 = test2 + 1;
        end
        
        if(j_index>N)
            j_index = N;
        %   test3 = test3 + 1;
        elseif(j_index<1)
            j_index = 1;
         %  test4 = test4 +1;
       end
            
        
          ftest(i_index,j_index) = 0;
      %  ftest(i,j) = 255;
        
    
        
       % data_then(i,j) = data(i_index,j_index);
    end
end
imshow(uint8(ftest));

%figure;imshow(uint8(datatest),[]);
%figure;imshow(uint8(data_then));









% 
% %% -----------------透镜形变校正------------------------
% A = [
%      13,59,-1,0,0,0,585,2655
%      0,0,0,13,59,-1,338,1534
%      -68,58,-1,0,0,0,7344,-6264
%      0,0,0,68,-58,1,1496,-1276
%      51,124,-1,0,0,0,2601,6324
%      0,0,0,51,124,-1,6324,15376
%      -113,122,-1,0,0,0,12769,-13786
%      0,0,0,113,-122,1,13786,-14884
%      %-30,106,-1,0,0,0,900,-3180,30
%    
%      ];
% B = [45 26 -108 -22 51 -124 -113 -122 ]';
% 
% value = det(A);  
% Ali = inv(A);
% Htmp = Ali*B;
% 
% H = zeros(3,3);
% for i = 1:8
%     H(i) = Htmp(i)*Hnine;
% end
% H(9) = Hnine;
% 
% H = H';
% 
% h = inv(H);
% 
% 
% data_then = zeros(M,N,NN);
% test1 = 0;
% test2 = 0;
% test3 = 0;
% test4 = 0;
% for i = 1:M
%     for j = 1:N
%         X = j-N/2;   % 矩阵坐标转论文（图像中点即原点）坐标
%         Y = M/2-i;
%         
%         x_pie = (h(1,1)*X + h(1,2)*Y + h(1,3))/(h(3,1)*X + h(3,2)*Y + h(3,3));
%         y_pie = (h(2,1)*X + h(2,2)*Y + h(2,3))/(h(3,1)*X + h(3,2)*Y + h(3,3));
%        
%         i_index = M/2 - y_pie;  % 论文坐标转矩阵坐标
%         j_index = x_pie + N/2;
%         
%         i_index = uint32(i_index);
%         j_index = uint32(j_index);
%         if(i_index>M)
%             i_index = M;
%             test1 = test1 + 1
%         elseif(i_index<1)
%             i_index = 1;
%             test2 = test2 + 1
%         end
%         
%         if(j_index>N)
%             j_index = N;
%             test3 = test3 + 1
%         elseif(j_index<1)
%             j_index = 1;
%             test4 = test4 +1
%         end
%             
%         
%         data_then(i,j,:) = data(i_index,j_index,:);
%     end
% end
% 
% figure;imshow(uint8(data_then));
         
