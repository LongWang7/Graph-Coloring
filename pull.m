function [queue,signal]=pull(queue,car)
% 该函数用来调出车辆
% car 需要拉出的车辆
% queue 调车场对应股道内车辆的排列队列
% signal 判断是否拉车成功

l = length(queue);      % 队列长度，即b
if queue(1) == car      % 如过car在queue的第一个，将car拉出
    queue(1) = 0;
    signal = 1;         % 标记为1
else
    signal = 0;         % 若不是，标记为0
end
if signal == 1          % 标记为1后，拉出队列内的车辆全部向前移动一位
    for i = 1:l-1
        if i == l-1
            queue(l-1) = 0;
            break
        end
        queue(i) = queue(i+1);
    end
    queue(l) = queue(l) - 1;
end
% 返回queue和signal