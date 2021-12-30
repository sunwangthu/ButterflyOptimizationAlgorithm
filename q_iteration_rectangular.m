function [Cp,Cw,Ci] = q_iteration_rectangular( M, N, Nf, gamma_0, F, W, Cf,G_0,L0,L, K )
%Q_ITERATION 此处显示有关此函数的摘要
%进行Q迭代
%对第i种组分计算Ax=b
dm = 10;
d=zeros(1,3);
err = 1.0005*10.^(-4);%迭代误差设置为10^(-6)
omega = 0.5;%松弛因子0.35
q=ones(1, N);
qnew=ones(1,N);
k = 3 ;%第四种组分为关键组分
Cw=Cf*ones(1 ,N);%9种组分在每一级的贫料流量
Cwn=zeros(N,1);%存放临时计算的某组分贫料丰度
Cp=Cf*ones(1, N);%9种组分在每一级的精料流量
Ci=Cf*ones(1, N);%9种组分在每一级的供料流量
P = F - W;
stage=1;
while dm>err
     A=zeros(N,N);
    b=zeros(N,1);
    ca=zeros(1,N);
    cb=zeros(1,N);
    cc=zeros(1,N);
    e=zeros(1,N);
for i=1:K 
  for j=1:N
    for j=1
        b(j)=0;
        A(j,j)=L(1)*q(1,j)*gamma_0^(M(k)-M(i))+W;
        A(j,j+1)=-(W+L(1));
     end
     for j=2:Nf-1
        b(j)=0;
        A(j,j-1)=-L(j-1)*q(1,j-1)*gamma_0^(M(k)-M(i));
        A(j,j)=(L(j-1)+W)+L(j)*q(1,j)*gamma_0^(M(k)-M(i));
        A(j,j+1)=-(L(j)+W);
     end
     for j=Nf
        b(j)= F*Cf(i);
        A(j,j-1)=-L(j-1)*q(1,j-1)*gamma_0^(M(k)-M(i));
        A(j,j)=(L(j-1)+W)+L(j)*q(1,j)*gamma_0^(M(k)-M(i));
        A(j,j+1)=-(L(j)-P);
     end
     for j=Nf+1:N-1
        b(j)=0;
        A(j,j-1)=-L(j-1)*q(1,j-1)*gamma_0^(M(k)-M(i));
        A(j,j)=(L(j-1)-P)+L(j)*q(1,j)*gamma_0^(M(k)-M(i));
        A(j,j+1)=-(L(j)-P);
     end
     for j=N
        b(j)=0;
        A(j,j-1)=-L(j-1)*q(1,j-1)*gamma_0^(M(k)-M(i));
        A(j,j)=(L(j-1)-P)+P*q(1,j)*gamma_0^(M(k)-M(i));
     end
  end
    Cwn=systri(A,b);
    Cw(i,1:N)=Cwn';
end

%各级精料丰度计算
for i=1:K
   for j=1:N
   Cp(i,j)=q(1,j)*gamma_0^(M(k)-M(i))*Cw(i,j);
   end
end

%各级供料丰度计算
for i=1:K
  for j=1:N
    for j=1
     Ci(i,j)=(L(j)*Cp(i,j)+(L0+W)*Cw(i,j))/G_0;
    end
    for j=2:Nf
     Ci(i,j)=(L(j)*Cp(i,j)+(L(j-1)+W)*Cw(i,j))/G_0;
    end
    for j=Nf+1:N
     Ci(i,j)=(L(j)*Cp(i,j)+(L(j-1)-P)*Cw(i,j))/G_0;
    end
  end 
end

for j=1:N     %第j级
    for i=1:K   %第j级所有组分丰度之和
    ca(1,j)=ca(1,j)+Ci(i,j); 
    cb(1,j)=cb(1,j)+Cp(i,j);
    cc(1,j)=cc(1,j)+Cw(i,j);
    end
end

%q值计算
for n=1:N
  for i=1:K
   e(1,n)=e(1,n)+Cw(i,n)*gamma_0^(M(k)-M(i));
   end
   qnew(1,n)=ca(1,n)/e(1,n);
   q(1,n)=(1-omega)*q(1,n)+omega*qnew(1,n); 
end
    
d(1)=max(abs(ca-1));
d(2)=max(abs(cb-1));
d(3)=max(abs(cc-1));
dm=max(d);  
stage=stage+1;
end

end

