function [son1,son2] = mutation(son1,son2,pm)
% �������
% pm �������
% son1 �Ӵ�1
% son2 �Ӵ�2

pick = rand;                % ȷ��parent1�������
while pick == 0
    pick = rand;
end
if pm > pick                % ���ܱ���
    len = length(son1);
    p1 = ceil(rand*len);
    p2 = ceil(rand*len);
    while p1 == p2          % ʹ��p1��p2������ȣ��������������
        p2 = ceil(rand*len);
    end
    temp = son1(p1);
    son1(p1) = son1(p2);
    son1(p2) = temp;
end

pick = rand;                % ȷ��parent2�������
while pick == 0
    pick = rand;
end
if pm > pick                % ���ܱ���
    len = length(son2);
    p1 = ceil(rand*len);
    p2 = ceil(rand*len);
    while p1 == p2          % ʹ��p1��p2������ȣ��������������
        p2 = ceil(rand*len);
    end
    temp = son2(p1);
    son2(p1) = son2(p2);
    son2(p2) = temp;
end