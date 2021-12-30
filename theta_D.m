clear all
%矩形级联square/rectangular cascade
%已知参量
F = 80; %外部供料流量80g/h
N_1 = 20; %一共20级级联
Nf_1 = 11; %给定供料级
G_01 = 18.5 * F;%矩形级联流量是供料流量10倍
Nc = 9;  %给定待分离组分数,Xe有9种组分
Cf=[0.00093;0.0009;0.01917;0.2644;0.0408;0.2118;0.2689;0.1044;0.0887];  %给定供料Xe各组分天然丰度
M=[124,126,128,129,130,131,132,134,136];  %1*NC矩阵，给定待分离各组分的分子质量

gamma_0 = 1.4;%基本全分离系数
G_1 = G_01 * ones(1,N_1);%各级流量,以单台机器计算，矩形级联各级流量相同
%矩形级联，N+1个补充方程相当于是给出各级流量G，以及总分流比theta。
%给出总的分流比theta_1_out，相当于给出W(P)的值，然后通过L_rectangular可以算出水力学参数，
%之后通过q_iteration可以求丰度方程。

%theta_1_out = 0.2864;%分流比等于前4个组分之和0.2864之时，D最大为0.9906
%theta_1_out = 0.28605;%分流比等于前4个组分之和0.28605之时，D最大为0.9906
%theta_1_out = 0.28587;
theta_1_out = 0.28631;
P_1 = F * theta_1_out;
W_1 = F - P_1;
%第一级计算
[L_1, L0_1,theta_in_1] = L_rectangular_cascade( F, W_1, G_01, G_1, Nf_1, N_1);
[Cp_1,Cw_1,Ci_1] = q_iteration_rectangular( M, N_1, Nf_1, gamma_0, F, W_1, Cf, G_01, L0_1, L_1, Nc );
%目标函数D函数
Nc2 = 4; %前4种组分
sum1=0;
sum2=0;
for i = 1:Nc2
    sum1 = sum1 + Cp_1(i,N_1);
end
for i = Nc2+1:Nc
    sum2 = sum2 + Cw_1(i,1);
end
D = P_1/F*(sum1) + W_1/F*(sum2);