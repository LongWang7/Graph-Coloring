function [sequence1,Input,Output,Matrix,L]=low(Input,Output,Matrix,L,R)
% 该函数用来对股道数进行减少，即“降维”
% 返回被“溜放”的车辆序列
% Input 进入队列
% Output 输出队列
% Matrix 染色矩阵
% L 染色后得到的股道数
% R 约束条件--股道数
% sequence1 溜放车辆序列

time = 0;
sequence1=[];
while L > R                      % 进行“降维”操作
    flag = 0;
    color = zeros(1,L-1);
    for i = 1:length(Input)      % 找到第一条L边
        if max(Matrix(:,i)) == L    
            for j = 1:length(Output)
                if Matrix(j,i) == L
                    row = j;
                    column = i;
                    flag = 1;
                    break
                end
            end
            if flag == 1
                break
            end
        end
    end
    % 确认要染成0的颜色和边
    for m = 1:length(Input)
        for n = 1:length(Output)
            if Matrix(n,m) ~= 0 && ( n < row && m > column || n > row && m < column )
                color(Matrix(n,m)) = color(Matrix(n,m)) +1;
                break
            end
        end
    end
    minimum = max(color);
    for k = 1:length(color)
        if color(k) ~= 0 && color(k) <= minimum
            minimum = color(k);
            dcolor = find(color == minimum);
        end
    end
    if length(dcolor) ~= 1
        dcolor = dcolor(1);
    end
    % 对要染成‘0’的车辆进行溜放
    needle = 0;
    if time ~=0
        clear reset
        clear record
    end
    time = 0;
    for m = 1:length(Input)
        sign = 0;
        for n = 1:length(Output)
            if ( n < row && m > column || n > row && m < column ) && Matrix(n,m) == dcolor
                time = time + 1;
                reset(time) = Input(m);
                record(time) = m;
                break
            end
        end
    end
    j=0;
    for i = 1:length(record)
        if i == 1
            Input(:,record(i)) = [];
            j = j + 1; 
        else
            Input(:,record(i)-j) = [];
            j = j + 1;
        end           
    end
    Input = [Input reset];
    sequence1=[sequence1 reset];
    [Matrix,L]=dye(Input,Output);
end
clear reset