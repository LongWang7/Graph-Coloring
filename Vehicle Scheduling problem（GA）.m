% 清除环境 并 开始计时
clear
clc
% 输入股道数和股道容量
% b 股道容量
% R 股道数
b = input('输入股道容量：')
R = input('输入股道数：')

% 输入和输出队列的输入
species = input('输入，需输出的列车数：');
maxlength = input('输入列车的最大长度：');
% VV是输出Output，F是进入队列矩阵
V = xlsread('VV.xls');
F = xlsread('F20.xls');
% 将进入队列矩阵转化为Input
Input = [];     
[row,~] = size(F);
for i = 1:row
    Input = [Input F(i,:)];
end
% train是输出车列的顺序矩阵
train = zeros(species,maxlength);
type = [1 2 3 4 5 6];
for i = 1:species
    train(i,:) = V(type(i),:);
end
memorizement = Input;         % 记忆Input

% 初始种群的生成
maxgen = 50;                  % 最大代数
popsize = 40;                 % 种群规模
pc = 0.9;                     % 交叉概率
pm = 0.2;                     % 变异概率
ggap = 0.2;                    % 逆转录概率
gen = 1;                        % 代数变量gen
chrom = zeros(popsize,species);             % 种群初始化
for i = 1:popsize
    chrom(i,:) = randperm(species);
end
value = zeros(popsize,1);          % 种群适应度值记录
minvalue = zeros(maxgen,1);        % 记录每代最优适应度值
minpath = zeros(maxgen,species); % 记录每代的最优路径
% GA开始迭代
while gen < maxgen
    tic                             % 开始每代用时的计时
    % 计算种群适应度
    % 保存每代种群的适应度值，输出队列
    % record 记录每代的溜放序列
    % offspring 子代矩阵
    offspring = [];
    for i = 1:popsize
        % s为溜放序列，len为s的长度
        [len,s] = operate(train,chrom,i,Input,species,R,b); % 对当前个体进行车辆调度操作
        value(i) = len;            % 记录值
        if i == 1
            record.queue{gen} = s;
        else
            if length(record.queue{gen}) > length(s)
                record.queue{gen} = s;
            end
        end
    end
    [f,number] = min(value);            % 记录最优值
    [a,signal] = sort(value);           % 对value进行排序
    person = chrom(signal(36:end),:);   % 保留最优的5个父代
    minpath(gen,:) = chrom(number,:);   % 记录最优个体输出序列
    minvalue(gen) = f;                  % 记录最优个体的适应度值
    % 交叉
    for m = 1:(popsize/2)
        % tour 挑选进行交叉的备选个体的个数
        % off tour个备选个体群 中 的个体 在chrom中的序号
        tour = 4;
        for i = 1:tour
            off(i) = randi(popsize);
            len = value(off(i));        % len 为 off(i)在chrom中的函数适应度值
            offvalue(i) = len;          % 记录下tour个适应度值
        end
        [offmin,offtip] = min(offvalue);% 找到最小值作为交叉父代parent1
        parent1 = chrom(off(offtip),:);
        % 以下为了寻找parent2，代码意义与parent1的相同
        for i = 1:tour
            off(i) = randi(popsize);
            len = value(off(i));
            offvalue(i) = len;
        end
        [offmin,offtip] = min(offvalue);
        parent2 = chrom(off(offtip),:);
        % 交叉
        [son1,son2] = intercross(parent1,parent2,pc);
        % 变异
        [son1,son2] = mutation(son1,son2,pm);
        % 逆转录
        [son1,son2] = rever(son1,son2,ggap);
        % 记录son1、son2到offspring中
        offspring = [offspring;son1;son2];
    end
    signal = randperm(40,35)';              % 从offspring中随机挑选35个作为子代种群
    chrom = [person;offspring(signal,:)];   % 父代最优5个个体与35个子代融合成新的子代种群
    gen = gen + 1;                          % 代数gen+1
    fprintf("已经完成第%d代\n",gen-1);
    disp(['该代最优溜放次数为：',num2str(length(record.queue{gen-1}))]);
    toc
    fprintf('\r\n');                        % 换行
end
toc
plot(1:maxgen,minvalue)                     % 结果可视化
xlabel('代数'),ylabel('溜放次数'),title('迭代过程')
disp(['最优进入队列：',num2str(chrom(end,:))])
bestpath = record.queue{maxgen};