function [len,s] = operate(train,chrom,k,Input,species,R,b)
% 车辆调度操作函数
% train 输出车列的序列矩阵
% chrom 父代种群
% k 父代中进行操作的第k个体
% Input 进入队列
% species 需输出的列车数
% R 股道数
% b 股道容量

% 合成Output向量
Output = [];
u = 0;
y = 0;
for p = 1:species
    Output = [Output train(chrom(k,p),:)];
end
% 删去train中车辆编号为“0”的元素，并合并
for q = 1:length(Output)
    if Output(q-u) == 0
        Output(q-u) = [];
        u = u + 1;
    end
end

% 进入循环1 即对股道数‘降维’
sequence=[];     % 记录溜放序列   
time1 = 0;
[Matrix,L]=dye(Input,Output);                                   % 染色操作
[sequence1,Input,Output,Matrix,L]=low(Input,Output,Matrix,L,R); % 对股道进行“降维”
sequence = [sequence sequence1];                                % 将降维的溜放序列合到sequence中
time1 = time1 + length(sequence1);

% 考虑‘降维’后股道容量的约束
% 下面是股道越是下的的溜放序列
i = 1;                  % i Output指针
j = 1;                  % j Input指针
sequence2 = [];         % 股道容量约束下，溜放序列的记录
time2 = 0;
trace = zeros(L,b+1);   % R个股道b个容量的调车场，最后一列记录的是该股道内车辆的数量
while i <= length(Output)
    if time2 ~= 0
        clear reset
    end
    % 拉出车辆
    [trace(sum(Matrix(i,:)),:),flag] = pull(trace(sum(Matrix(i,:)),:),Output(i));
    if flag == 1    % 若能拉出，进行下一次循环判断
        i = i + 1;
        continue
    else            % 若不能，则进入车辆
        % 进入车辆
        [trace(sum(Matrix(:,j)),:),flag] = enter(trace(sum(Matrix(:,j)),:),Input(j),b);
        if flag == 1                        % 如果能进入车辆，进入下一次循环
            j = j + 1;
        end                         
        while flag == 0                     % 若不能，进行溜放，并重新染色
            time2 = time2 + 1;
            reset(1) = Input(j);
            Input(:,j) = [];
            Input = [Input reset];
            [Matrix,L]=dye(Input,Output);
            sequence2 = [sequence2 reset];
            if L > R                        % 染完色若股道约束不满足，则返回进行“降维”
                sequence=[sequence sequence2];
                sequence2 = [];
                time1 = time1 + time2 + i;
                time2 = 0;
                [sequence2,Input,Output,Matrix,L]=low(Input,Output,Matrix,L,R); % 降维
                i = 1;                      % 降维完相当于重新进行股道容量约束
                j = 1;                      % 故将i，j重新赋值为1
                sequence = [sequence sequence2];    % 记录溜放序列到sequence
                sequence2 = [];                     % sequence归零
                trace = zeros(L,b+1);               % 调车场内车辆清零
            end
            flag = 1;                               % flag=1，使得跳出循环
        end
    end
    if i == 239
        pp = 1;
    end
end
sequence = [sequence sequence2];
len = length(sequence);     % 记录每代种群个体的适应度值
s = sequence;