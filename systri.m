function [ x ] = systri( A,b )
%SYSTRI 此处显示有关此函数的摘要
%该函数用于求解对称三对角Ax=b的精确解；
[N,Nn]=size(A);
L=zeros(N,N);
U=eye(N);
L(1,1)=A(1,1);
U(1,2)=A(1,2)/L(1,1);
for i=2:N-1
    L(i,i-1)=A(i,i-1);
    L(i,i)=A(i,i)-L(i,i-1)*U(i-1,i);
    U(i,i+1)=A(i,i+1)/L(i,i);
end
L(N,N-1)=A(N,N-1);
L(N,N)=A(N,N)-L(N,N-1)*U(N-1,N);

y=zeros(N,1);
x=zeros(N,1);
y(1)=b(1)/A(1,1);
for i=2:N
    y(i)=(b(i)-A(i,i-1)*y(i-1))/(A(i,i)-A(i,i-1)*U(i-1,i));
end
x(N)=y(N);
for i=N-1:-1:1
    x(i)=y(i)-U(i,i+1)*x(i+1);
end

end

