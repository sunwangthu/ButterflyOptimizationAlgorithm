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
% lb is the lower bound
% up is the uppper bound
% dim is the number of variables 
function [lb,ub,dim,fobj] = Get_Functions_details1(F)

    switch F
        case 'D_function2'
            fobj = @D_function2;
            lb=0;
            ub=1;
            dim=1;%һά����
        
    end   

end

%D_function2����ΪD_function�����ĵ�����xӦ��Ϊ��������ʽ�ı�������ʼʱ�Ա���Ϊ������theta��ά��Ϊ1
function o = D_function2(x)
o = 1./ D_function(x);
end

