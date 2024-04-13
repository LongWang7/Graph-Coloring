function [queue,signal]=enter(queue,car,b)
% 该函数用来向股道内拉入车辆
% car 需要拉出的车辆
% queue 调车场对应股道内车辆的排列队列
% signal 判断是否拉车成功
% b 股道容量

l = length(queue);          % l 股道容量
if queue(end) >= b          % 如果股道内车辆数》=b
    signal = 0;
else
    signal = 1;
end
if signal == 1              % 如果判断拉车成功，则进行拉车操作，并将queue(end)+1
    for i = 1:l-1
        if queue(i) == 0
            queue(i) = car;
            break
        end
    end
    queue(end) = queue(end) + 1;
end