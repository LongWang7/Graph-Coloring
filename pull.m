function [queue,signal]=pull(queue,car)
% �ú���������������
% car ��Ҫ�����ĳ���
% queue ��������Ӧ�ɵ��ڳ��������ж���
% signal �ж��Ƿ������ɹ�

l = length(queue);      % ���г��ȣ���b
if queue(1) == car      % ���car��queue�ĵ�һ������car����
    queue(1) = 0;
    signal = 1;         % ���Ϊ1
else
    signal = 0;         % �����ǣ����Ϊ0
end
if signal == 1          % ���Ϊ1�����������ڵĳ���ȫ����ǰ�ƶ�һλ
    for i = 1:l-1
        if i == l-1
            queue(l-1) = 0;
            break
        end
        queue(i) = queue(i+1);
    end
    queue(l) = queue(l) - 1;
end
% ����queue��signal