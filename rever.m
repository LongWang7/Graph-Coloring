function [son1,son2] = rever(son1,son2,ggap)
% ��ת¼����
% gaap ��ת¼����
% son1 �Ӵ�1
% son2 �Ӵ�2

pick = rand;                % ȷ����ת¼����
while pick == 0
    pick = rand;
end
if ggap > pick              % ���ܽ�����ת¼����ʼ����
    son1 = fliplr(son1);
end
pick = rand;
while pick == 0
    pick = rand;
end
if ggap > pick
    son2 = fliplr(son2);
end