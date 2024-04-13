function [son1,son2] = intercross(parent1,parent2,pc)
% 交叉函数
% parent1 父代1
% parent2 父代2
% pc 交叉概率
% son1 子代1
% son2 子代2

ind1 = parent1;
ind2 = parent2;
pick = rand;                                % 确定交叉概率
while pick == 0
    pick = rand;
end
if pc > pick                                % 若能交叉
    len = length(parent1);          
    position = ceil(rand*len);              % 交叉位置的确定       
    temp = ind1(position:end);                % 交叉
    ind1(position:end) = ind2(position:end);
    ind2(position:end) = temp;
    
    % 因为交叉后，子代的基因型会出现相同的情况，下面用 部分交叉法 进行修改基因型
    % 对parent1进行修复
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
    % 对parent2进行修复
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