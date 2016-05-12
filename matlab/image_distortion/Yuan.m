function [ X0,Y0,R ] = Yuan( rgb )
%扫描线法求圆心和半径
%   Detailed explanation goes here
[~, ~,v] = size(rgb);
if v==3
    I = rgb2gray(rgb);
else
    I = rgb;
end
[Height, Width,v] = size(rgb);
Thre = 46;

%% 寻找圆形区域上边界
for Row1=1:(Height/2)
    CurRow_Bright = I(Row1,:);
    Max = max(CurRow_Bright);
    Min = min(CurRow_Bright);
    Lim = Max-Min;
    if(Lim>Thre)
        ytop=Row1;
        break;
    end      
end
%% 寻找圆形区域的下边界
for Row2=Height:-1:(Height/2)
    CurRow_Bright = I(Row2,:);
    Max = max(CurRow_Bright);
    Min = min(CurRow_Bright);
    Lim = Max-Min;
    if(Lim>Thre)
        ybot = Row2;
        break;
    end      
end

%% 寻找圆形区域的左边界
for Col1=1:(Width/2)
    CurCol_Bright = I(:,Col1);
    Max = max(CurCol_Bright);
    Min = min(CurCol_Bright);
    Lim = Max -Min;
    if(Lim>Thre)
        xleft = Col1;
        break;
    end

end

%% 寻找圆形区域的右边界
for Col2=Width:-1:(Width/2)
    CurCol_Bright = I(:,Col2);
    Max = max(CurCol_Bright);
    Min = min(CurCol_Bright);
    Lim = Max -Min;
    if(Lim>Thre)
        xright = Col2;
        break;
    end

end
X0 = (xleft + xright)/2;
Y0 = (ytop + ybot)/2;
RX = floor((xright - xleft)/2);
RY = floor((ybot - ytop)/2);
R = max(RX,RY);

 
