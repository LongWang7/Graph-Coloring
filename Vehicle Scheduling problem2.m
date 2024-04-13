clear
clc
% 输入股道数和股道容量
b = input('输入股道容量：')
R = input('输入股道数：')
% 输入和输出队列的输入
tip=1;
while tip
    Input = input('输入 进入队列：')
    Output = input('输入 输出队列：')
    count1 = zeros(1,max(Input));
    count2 = zeros(1,max(Output));
    for i = 1:length(Input)
        for j = 1:max(Input)
            if Input(i) == j
                count1(j) = count1(j) + 1;
            end
            continue
        end
    end
    for i = 1:length(Output)
        for j = 1:max(Output)
            if Output(i) == j
                count2(j) = count2(j) + 1;
            end
            continue
        end
    end
    count = sum(count1 == count2);
    if length(Output) == length(Input) && count == length(count1)
        tip = 0;
        disp('输入成功')
    else
        disp('输入有误，请重新输入')
    end
end

% 进入循环1 即对股道数‘降维’
[Matrix,L]=dye(Input,Output);
[sequence1,Input,Output,Matrix]=low(Input,Output,Matrix,L,R);
sequence = sequence1;

% 考虑‘降维’后股道容量的约束
% 下面是股道越是下的的溜放序列
i = 1;
j = 1;
sequence2 = [];
time = 0;
track = zeros(L,b+1);
while i <= length(Output)
    if time ~= 0
        clear reset
    end
    [track(sum(Matrix(i,:)),:),flag] = pull(track(sum(Matrix(i,:)),:),Output(i));
    if flag == 1
        i = i + 1;
        if i == length(Output) + 1
            disp('股道容量条件下"溜放"的序列为：')
            sequence
        end
        continue
    else
        [track(sum(Matrix(:,j)),:),flag] = enter(track(sum(Matrix(:,j)),:),Input(j),b);
        if flag == 1
            j = j + 1;
        end
        while flag == 0
            time = time + 1;
            reset(1) = Input(j);
            Input(:,j) = [];
            Input = [Input reset];
            [Matrix,L]=dye(Input,Output);
            sequence2 = [sequence2 reset];
            if L > R
                sequence2
                [sequence1,Input,Output,Matrix,L]=low(Input,Output,Matrix,L,R);
                i = 1;
                time = 0;
                sequence = [sequence sequence2];
                sequence2 = [];
                j=1;
                track = zeros(L,b+1);
            end
            flag = 1;
        end
    end
end
