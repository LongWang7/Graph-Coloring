% ������� �� ��ʼ��ʱ
clear
clc
% ����ɵ����͹ɵ�����
% b �ɵ�����
% R �ɵ���
b = input('����ɵ�������')
R = input('����ɵ�����')

% �����������е�����
species = input('���룬��������г�����');
maxlength = input('�����г�����󳤶ȣ�');
% VV�����Output��F�ǽ�����о���
V = xlsread('VV.xls');
F = xlsread('F20.xls');
% ��������о���ת��ΪInput
Input = [];     
[row,~] = size(F);
for i = 1:row
    Input = [Input F(i,:)];
end
% train��������е�˳�����
train = zeros(species,maxlength);
type = [1 2 3 4 5 6];
for i = 1:species
    train(i,:) = V(type(i),:);
end
memorizement = Input;         % ����Input

% ��ʼ��Ⱥ������
maxgen = 50;                  % ������
popsize = 40;                 % ��Ⱥ��ģ
pc = 0.9;                     % �������
pm = 0.2;                     % �������
ggap = 0.2;                    % ��ת¼����
gen = 1;                        % ��������gen
chrom = zeros(popsize,species);             % ��Ⱥ��ʼ��
for i = 1:popsize
    chrom(i,:) = randperm(species);
end
value = zeros(popsize,1);          % ��Ⱥ��Ӧ��ֵ��¼
minvalue = zeros(maxgen,1);        % ��¼ÿ��������Ӧ��ֵ
minpath = zeros(maxgen,species); % ��¼ÿ��������·��
% GA��ʼ����
while gen < maxgen
    tic                             % ��ʼÿ����ʱ�ļ�ʱ
    % ������Ⱥ��Ӧ��
    % ����ÿ����Ⱥ����Ӧ��ֵ���������
    % record ��¼ÿ�����������
    % offspring �Ӵ�����
    offspring = [];
    for i = 1:popsize
        % sΪ������У�lenΪs�ĳ���
        [len,s] = operate(train,chrom,i,Input,species,R,b); % �Ե�ǰ������г������Ȳ���
        value(i) = len;            % ��¼ֵ
        if i == 1
            record.queue{gen} = s;
        else
            if length(record.queue{gen}) > length(s)
                record.queue{gen} = s;
            end
        end
    end
    [f,number] = min(value);            % ��¼����ֵ
    [a,signal] = sort(value);           % ��value��������
    person = chrom(signal(36:end),:);   % �������ŵ�5������
    minpath(gen,:) = chrom(number,:);   % ��¼���Ÿ����������
    minvalue(gen) = f;                  % ��¼���Ÿ������Ӧ��ֵ
    % ����
    for m = 1:(popsize/2)
        % tour ��ѡ���н���ı�ѡ����ĸ���
        % off tour����ѡ����Ⱥ �� �ĸ��� ��chrom�е����
        tour = 4;
        for i = 1:tour
            off(i) = randi(popsize);
            len = value(off(i));        % len Ϊ off(i)��chrom�еĺ�����Ӧ��ֵ
            offvalue(i) = len;          % ��¼��tour����Ӧ��ֵ
        end
        [offmin,offtip] = min(offvalue);% �ҵ���Сֵ��Ϊ���游��parent1
        parent1 = chrom(off(offtip),:);
        % ����Ϊ��Ѱ��parent2������������parent1����ͬ
        for i = 1:tour
            off(i) = randi(popsize);
            len = value(off(i));
            offvalue(i) = len;
        end
        [offmin,offtip] = min(offvalue);
        parent2 = chrom(off(offtip),:);
        % ����
        [son1,son2] = intercross(parent1,parent2,pc);
        % ����
        [son1,son2] = mutation(son1,son2,pm);
        % ��ת¼
        [son1,son2] = rever(son1,son2,ggap);
        % ��¼son1��son2��offspring��
        offspring = [offspring;son1;son2];
    end
    signal = randperm(40,35)';              % ��offspring�������ѡ35����Ϊ�Ӵ���Ⱥ
    chrom = [person;offspring(signal,:)];   % ��������5��������35���Ӵ��ںϳ��µ��Ӵ���Ⱥ
    gen = gen + 1;                          % ����gen+1
    fprintf("�Ѿ���ɵ�%d��\n",gen-1);
    disp(['�ô�������Ŵ���Ϊ��',num2str(length(record.queue{gen-1}))]);
    toc
    fprintf('\r\n');                        % ����
end
toc
plot(1:maxgen,minvalue)                     % ������ӻ�
xlabel('����'),ylabel('��Ŵ���'),title('��������')
disp(['���Ž�����У�',num2str(chrom(end,:))])
bestpath = record.queue{maxgen};