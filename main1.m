%_____________________________________________________________________________________________ %
%  Butterfly Optimization Algorithm (BOA) source codes demo V1.0                               %
%                                                                                              %
%  Author and programmer: Sankalap Arora                                                       %
%                                                                                              %
%         e-Mail: sankalap.arora@gmail.com                                                     %
%                                                                                              %
%  Main paper: Sankalap Arora, Satvir Singh                                                    %
%              Butterfly optimization algorithm: a novel approach for global optimization	   %
%              Soft Computing, in press,                                                       %
%              DOI: https://doi.org/10.1007/s00500-018-3102-4                                  %
%___________________________________________________________________________________________   %
%

clear all 
clc
warning off all

SearchAgents_no=30; % Number of search agents������Ⱥ��������ʼ��Ϊ30
Max_iteration=30; % Maximum number of iterations��������������ʼ��Ϊ500

Function_name='D_function2';%�������ƣ�������Ը�

[lb,ub,dim,fobj]=Get_Functions_details1(Function_name);

[Best_score,Best_pos,cg_curve]=BOA1(SearchAgents_no,Max_iteration,lb,ub,dim,fobj);

semilogy(cg_curve,'Color','r')%y��Ķ����̶Ȼ�ͼ����������
title('Convergence curve')
xlabel('Iteration');
ylabel('Best score obtained so far');

axis tight
grid off
box on
legend('BOA')

display(['The best solution obtained by BOA is : ', num2str(Best_pos)]);
display(['The best optimal value of the objective funciton found by BOA is : ', num2str(Best_score)]);


