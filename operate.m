function [len,s] = operate(train,chrom,k,Input,species,R,b)
% �������Ȳ�������
% train ������е����о���
% chrom ������Ⱥ
% k �����н��в����ĵ�k����
% Input �������
% species ��������г���
% R �ɵ���
% b �ɵ�����

% �ϳ�Output����
Output = [];
u = 0;
y = 0;
for p = 1:species
    Output = [Output train(chrom(k,p),:)];
end
% ɾȥtrain�г������Ϊ��0����Ԫ�أ����ϲ�
for q = 1:length(Output)
    if Output(q-u) == 0
        Output(q-u) = [];
        u = u + 1;
    end
end

% ����ѭ��1 ���Թɵ�������ά��
sequence=[];     % ��¼�������   
time1 = 0;
[Matrix,L]=dye(Input,Output);                                   % Ⱦɫ����
[sequence1,Input,Output,Matrix,L]=low(Input,Output,Matrix,L,R); % �Թɵ����С���ά��
sequence = [sequence sequence1];                                % ����ά��������кϵ�sequence��
time1 = time1 + length(sequence1);

% ���ǡ���ά����ɵ�������Լ��
% �����ǹɵ�Խ���µĵ��������
i = 1;                  % i Outputָ��
j = 1;                  % j Inputָ��
sequence2 = [];         % �ɵ�����Լ���£�������еļ�¼
time2 = 0;
trace = zeros(L,b+1);   % R���ɵ�b�������ĵ����������һ�м�¼���Ǹùɵ��ڳ���������
while i <= length(Output)
    if time2 ~= 0
        clear reset
    end
    % ��������
    [trace(sum(Matrix(i,:)),:),flag] = pull(trace(sum(Matrix(i,:)),:),Output(i));
    if flag == 1    % ����������������һ��ѭ���ж�
        i = i + 1;
        continue
    else            % �����ܣ�����복��
        % ���복��
        [trace(sum(Matrix(:,j)),:),flag] = enter(trace(sum(Matrix(:,j)),:),Input(j),b);
        if flag == 1                        % ����ܽ��복����������һ��ѭ��
            j = j + 1;
        end                         
        while flag == 0                     % �����ܣ�������ţ�������Ⱦɫ
            time2 = time2 + 1;
            reset(1) = Input(j);
            Input(:,j) = [];
            Input = [Input reset];
            [Matrix,L]=dye(Input,Output);
            sequence2 = [sequence2 reset];
            if L > R                        % Ⱦ��ɫ���ɵ�Լ�������㣬�򷵻ؽ��С���ά��
                sequence=[sequence sequence2];
                sequence2 = [];
                time1 = time1 + time2 + i;
                time2 = 0;
                [sequence2,Input,Output,Matrix,L]=low(Input,Output,Matrix,L,R); % ��ά
                i = 1;                      % ��ά���൱�����½��йɵ�����Լ��
                j = 1;                      % �ʽ�i��j���¸�ֵΪ1
                sequence = [sequence sequence2];    % ��¼������е�sequence
                sequence2 = [];                     % sequence����
                trace = zeros(L,b+1);               % �������ڳ�������
            end
            flag = 1;                               % flag=1��ʹ������ѭ��
        end
    end
    if i == 239
        pp = 1;
    end
end
sequence = [sequence sequence2];
len = length(sequence);     % ��¼ÿ����Ⱥ�������Ӧ��ֵ
s = sequence;