function [queue,signal]=enter(queue,car,b)
% �ú���������ɵ������복��
% car ��Ҫ�����ĳ���
% queue ��������Ӧ�ɵ��ڳ��������ж���
% signal �ж��Ƿ������ɹ�
% b �ɵ�����

l = length(queue);          % l �ɵ�����
if queue(end) >= b          % ����ɵ��ڳ�������=b
    signal = 0;
else
    signal = 1;
end
if signal == 1              % ����ж������ɹ����������������������queue(end)+1
    for i = 1:l-1
        if queue(i) == 0
            queue(i) = car;
            break
        end
    end
    queue(end) = queue(end) + 1;
end