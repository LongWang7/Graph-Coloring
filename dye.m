function [Matrix,L]=dye(Input,Output)
% 该函数用来对输入和输出所构成二部图进行连边，再‘染色’
% Input 进入队列
% Output 输出队列
% Matix 染色矩阵
% L 染色所用最大颜色即所用股道数

% 下面先连边
Matrix = zeros(length(Input));
count1 = zeros(1,length(Output));       % 用于计数，便于正确连边
for i = 1:length(Input)                 % 连边
    for j = 1:length(Output)
        if Input(i) == Output(j)
            if count1(j) == 0
                Matrix(j,i) = 1;
                count1(j) = 1;
                break
            end
        end
    end
end

% 接下来是染色
% 第一道染色i>=j
count2=zeros(1,length(Input));
criterion = 0;
for i = 1: length(Input)
    for j = 1:length(Output)
        if Matrix(j,i) == 1 && count2(i) == 0 && j > criterion
            if j >= i
                Matrix(j,i) = 1;
                count2(i) = 1;
                criterion = j;
                break
            end
        end
    end
end

% 第二道染色
flag = 0;
for i = 1:length(Input)
    Maximum = 1;
    if count2(i) == 1
        continue
    end
    for j = 1:length(Output)
        if Matrix(j,i) == 1 
            for m = 1:length(Input)
                if count2(m) == 1 
                    for n = 1:length(Output)
                        if Matrix(n,m) ~= 0
                            if (i > m && n > j) || (j > n && m > i)
                                if Maximum <= Matrix(n,m)
                                    Maximum = Matrix(n,m);
                                    flag = 1;
                                end
                            end
                        end
                    end
                end
            end
            if flag == 1
                Matrix(j,i) = Maximum + 1; 
                count2(i) = 1;
                flag = 0;
            end
            break
        end
    end
end

% 输出初始解所用的最大股道数
L=max(max(Matrix));