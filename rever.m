function [son1,son2] = rever(son1,son2,ggap)
% 逆转录操作
% gaap 逆转录概率
% son1 子代1
% son2 子代2

pick = rand;                % 确定逆转录概率
while pick == 0
    pick = rand;
end
if ggap > pick              % 若能进行逆转录，则开始操作
    son1 = fliplr(son1);
end
pick = rand;
while pick == 0
    pick = rand;
end
if ggap > pick
    son2 = fliplr(son2);
end