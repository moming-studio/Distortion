function [ X0,Y0,R ] = Yuan( rgb )
%ɨ���߷���Բ�ĺͰ뾶
%   Detailed explanation goes here
[~, ~,v] = size(rgb);
if v==3
    I = rgb2gray(rgb);
else
    I = rgb;
end
[Height, Width,v] = size(rgb);
Thre = 46;

%% Ѱ��Բ�������ϱ߽�
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
%% Ѱ��Բ��������±߽�
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

%% Ѱ��Բ���������߽�
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

%% Ѱ��Բ��������ұ߽�
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

 
