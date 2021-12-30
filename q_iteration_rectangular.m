function [Cp,Cw,Ci] = q_iteration_rectangular( M, N, Nf, gamma_0, F, W, Cf,G_0,L0,L, K )
%Q_ITERATION �˴���ʾ�йش˺�����ժҪ
%����Q����
%�Ե�i����ּ���Ax=b
dm = 10;
d=zeros(1,3);
err = 1.0005*10.^(-4);%�����������Ϊ10^(-6)
omega = 0.5;%�ɳ�����0.35
q=ones(1, N);
qnew=ones(1,N);
k = 3 ;%���������Ϊ�ؼ����
Cw=Cf*ones(1 ,N);%9�������ÿһ����ƶ������
Cwn=zeros(N,1);%�����ʱ�����ĳ���ƶ�Ϸ��
Cp=Cf*ones(1, N);%9�������ÿһ���ľ�������
Ci=Cf*ones(1, N);%9�������ÿһ���Ĺ�������
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

%�������Ϸ�ȼ���
for i=1:K
   for j=1:N
   Cp(i,j)=q(1,j)*gamma_0^(M(k)-M(i))*Cw(i,j);
   end
end

%�������Ϸ�ȼ���
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

for j=1:N     %��j��
    for i=1:K   %��j��������ַ��֮��
    ca(1,j)=ca(1,j)+Ci(i,j); 
    cb(1,j)=cb(1,j)+Cp(i,j);
    cc(1,j)=cc(1,j)+Cw(i,j);
    end
end

%qֵ����
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

