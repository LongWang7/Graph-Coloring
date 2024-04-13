function [son1,son2] = intercross(parent1,parent2,pc)
% ���溯��
% parent1 ����1
% parent2 ����2
% pc �������
% son1 �Ӵ�1
% son2 �Ӵ�2

ind1 = parent1;
ind2 = parent2;
pick = rand;                                % ȷ���������
while pick == 0
    pick = rand;
end
if pc > pick                                % ���ܽ���
    len = length(parent1);          
    position = ceil(rand*len);              % ����λ�õ�ȷ��       
    temp = ind1(position:end);                % ����
    ind1(position:end) = ind2(position:end);
    ind2(position:end) = temp;
    
    % ��Ϊ������Ӵ��Ļ����ͻ������ͬ������������� ���ֽ��淨 �����޸Ļ�����
    % ��parent1�����޸�
    a = parent1;
    for j = 1:length(ind1)
        for k = 1:len
            if a(k) == ind1(j)
                a(k) = [];
                len = length(a);
                break;
            end
        end
    end
    for j = 1:(length(ind1)-1)
        for k = j+1:length(ind1)
            if ind1(j) == ind1(k) && k >= position  
                tip = randperm(length(a),1);
                ind1(k) = a(tip);
                a(tip) = [];
            end
        end
    end
    % ��parent2�����޸�
    a = parent2;
    for j = 1:length(ind2)
        for k = 1:len
            if a(k) == ind2(j) 
                a(k) = [];
                len = length(a);
                break;
            end
        end
    end
    for j = 1:(length(ind2)-1)
        for k = j+1:length(ind2)
            if ind2(j) == ind2(k) && k >= position
                tip = randperm(length(a),1);
                ind2(k) = a(tip);
                a(tip) = [];
            end
        end
    end
    son1 = ind1;
    son2 = ind2;
else
    son1 = parent1;
    son2 = parent2;
end