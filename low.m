function [sequence1,Input,Output,Matrix,L]=low(Input,Output,Matrix,L,R)
% �ú��������Թɵ������м��٣�������ά��
% ���ر�����š��ĳ�������
% Input �������
% Output �������
% Matrix Ⱦɫ����
% L Ⱦɫ��õ��Ĺɵ���
% R Լ������--�ɵ���
% sequence1 ��ų�������

time = 0;
sequence1=[];
while L > R                      % ���С���ά������
    flag = 0;
    color = zeros(1,L-1);
    for i = 1:length(Input)      % �ҵ���һ��L��
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
    % ȷ��ҪȾ��0����ɫ�ͱ�
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
    % ��ҪȾ�ɡ�0���ĳ����������
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