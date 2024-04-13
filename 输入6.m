% 输入股道数和股道容量
b = input('输入股道容量：')
R = input('输入股道数：')

% 输入和输出队列的输入
species = input('输入，需输出的列车数：')
maxlength = input('输入列车的最大长度');
Input = input('输入，进入队列：')
train = zeros(species,maxlength);
for i = 1:species
    fprintf('请输入第%d量列车序列',i)
    train(i,:) = input('')
end
memorizement = Input;

% 获得全排数组
global gen 
global A
gen = 1;
for i = 1:species
    a(i) = i;
end
A=perm(1,a,species);
gen = gen - 1;

% 对获得的全排数组进行遍历，以最终得到最优解
for k = 1:gen
    
    % 删去train中车辆编号为“0”的元素，并合并
    Output = [];
    u = 0;
    y = 0;
    for p = 1:species
        Output = [Output train(A(k,p),:)];
    end
    for q = 1:length(Output)
        if Output(q-u) == 0
            Output(q-u) = [];
            u = u + 1;
        end
    end
    
    % 进入循环1 即对股道数‘降维’
    Input = memorizement;
    sequence=[];
    time1 = 0;
    [Matrix,L]=dye(Input,Output);
    [sequence1,Input,Output,Matrix]=low(Input,Output,Matrix,L,R);
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
                    time1 = time1 + time2;
                    time2 = 0;
                    [sequence1,Input,Output,Matrix,L]=low(Input,Output,Matrix,L,R);
                    i = 1;
                    j = 1;
                    sequence = [sequence sequence1];
                    time1 = time1 + length(sequence1);
                    track = zeros(L,b+1);
                end
                flag = 1;
            end
        end
    end
    time = time1 + time2;
    if k == 1
        temp = time;
        array = sequence;
        send = A(k,:)
    else
        if time > temp
            temp = time;
            array = sequence;
            send = A(k,:);
        end
    end
end
disp('输出车辆次序为：')
send
disp('调回车辆序列为：')
array