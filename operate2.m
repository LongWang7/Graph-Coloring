function len = operate2(train,son1,Input,species,R,b)
% 第二个操作函数
% 用于比较父代与子代的优良性
% 出车操作函数
% 删去train中车辆编号为“0”的元素，并合并
Output = [];
u = 0;
y = 0;
for p = 1:species
    Output = [Output train(son1(p),:)];
end
for q = 1:length(Output)
    if Output(q-u) == 0
        Output(q-u) = [];
        u = u + 1;
    end
end

% 进入循环1 即对股道数‘降维’
sequence=[];
time = 0;
time1 = 0;
[Matrix,L]=dye(Input,Output);
[sequence1,Input,Output,Matrix,L]=low(Input,Output,Matrix,L,R);
sequence = [sequence sequence1];
time1 = time1 + length(sequence1);

% 考虑‘降维’后股道容量的约束
% 下面是股道越是下的的溜放序列
i = 1;
j = 1;
sequence2 = [];
time2 = 0;
track = zeros(L,b+1);
while i <= length(Output)
    if time2 ~= 0
        clear reset
    end
    [track(sum(Matrix(i,:)),:),flag] = pull(track(sum(Matrix(i,:)),:),Output(i));
    if flag == 1
        i = i + 1;
        continue
    else
        [track(sum(Matrix(:,j)),:),flag] = enter(track(sum(Matrix(:,j)),:),Input(j),b);
        if flag == 1
            j = j + 1;
        end
        while flag == 0
            time2 = time2 + 1;
            reset(1) = Input(j);
            Input(:,j) = [];
            Input = [Input reset];
            [Matrix,L]=dye(Input,Output);
            sequence2 = [sequence2 reset];
            if L > R
                sequence=[sequence sequence2];
                sequence2 = [];
                time1 = time1 + time2 + i;
                time2 = 0;
                [sequence2,Input,Output,Matrix,L]=low(Input,Output,Matrix,L,R);
                i = 1;
                j = 1;
                sequence = [sequence sequence2];
                sequence2 = [];
                track = zeros(L,b+1);
            end
            flag = 1;
        end
    end
end
sequence = [sequence sequence2];
len = length(sequence);     % 记录每代种群个体的适应度值