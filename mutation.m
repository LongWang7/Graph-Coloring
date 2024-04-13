function [son1,son2] = mutation(son1,son2,pm)
% 变异操作
% pm 变异概率
% son1 子代1
% son2 子代2

pick = rand;                % 确定parent1变异概率
while pick == 0
    pick = rand;
end
if pm > pick                % 若能变异
    len = length(son1);
    p1 = ceil(rand*len);
    p2 = ceil(rand*len);
    while p1 == p2          % 使得p1和p2不能相等，否则变异无意义
        p2 = ceil(rand*len);
    end
    temp = son1(p1);
    son1(p1) = son1(p2);
    son1(p2) = temp;
end

pick = rand;                % 确定parent2变异概率
while pick == 0
    pick = rand;
end
if pm > pick                % 若能变异
    len = length(son2);
    p1 = ceil(rand*len);
    p2 = ceil(rand*len);
    while p1 == p2          % 使得p1和p2不能相等，否则变异无意义
        p2 = ceil(rand*len);
    end
    temp = son2(p1);
    son2(p1) = son2(p2);
    son2(p2) = temp;
end