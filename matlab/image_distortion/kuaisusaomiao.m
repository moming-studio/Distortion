function [ A,R ] = kuaisusaomiao( A,T )
%扫描线法求圆心和半径
[m,n,k]=size(A);
for i=1:m-1
    for j=1:n
        I(i,j)=A(i,j);
        if(I(i,j)>=T)
           I(i+1,j)=A(i+1,j); 
           if(I(i+1,j)>=T)
               bottom=j;
               break;
           end
        end
    end
end
for i=m:-1:2
    for j=1:n
        I(i,j)= A(i,j);
        if(I(i,j)>=T)
           I(i-1,j)= A(i-1,j); 
           if(I(i-1,j)>=T)
               top=i;
               break;
           end
        end
    end
end
for j=1:n-1
    for i=1:m
        I(i,j)=A(i,j);
        if(I(i,j)>=T)
           I(i,j+1)= A(i,j+1); 
           if(I(i,j+1)>=T)
               right=j;
               break;
           end
        end
    end
end
for j=n:-1:2
    for i=1:m
        I(i,j)= A(i,j);
        if(I(i,j)>=T)
           I(i,j-1)= A(i,j-1); 
           if(I(i,j-1)>=T)
               left=j;
               break;
           end
        end
    end
end
R=max(abs((right-left)/2),abs((bottom-top)/2));
A=imcrop(A,[left,top,2*R,2*R]);

 
