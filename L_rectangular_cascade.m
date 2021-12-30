function [ L, L0 ,theta] = L_rectangular_cascade( F, W, G_0, G, Nf, N )
%L_RECTANGULAR 此处显示有关此函数的摘要
%水力学参数计算
theta = zeros(1,N);%各级分流比
L = ones(1,N);%各级精料流量
P = F-W;
theta(1)=0.5*(1-W/G_0);
L0=(1-theta(1))*G(1)-W;
for n=1:Nf
    if n==1
        L(n)=G(n)-L0-W;
    else
    L(n)=G(n)-L(n-1)-W;
    end
end
for n=Nf+1:N
    L(n)=G(n)-L(n-1)+P;
end
theta = L/G_0;

end

