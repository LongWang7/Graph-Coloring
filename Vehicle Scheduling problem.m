tic
% ����ɵ����͹ɵ�����
b = input('����ɵ�������')
R = input('����ɵ�����')

% �����������е�����
species = input('���룬��������г�����')
maxlength = input('�����г�����󳤶�');
Input = input('���룬������У�')
train = zeros(species,maxlength);
for i = 1:species
    fprintf('�������%d���г�����',i)
    train(i,:) = input('')
end
memorizement = Input;

% ���ȫ������
global gen 
global A
gen = 1;
for i = 1:species
    a(i) = i;
end
A=perm(1,a,species);
gen = gen - 1;

total = zeros(1,gen);
T = zeros(1,gen);
tic
% �Ի�õ�ȫ��������б����������յõ����Ž�
for k = 1:gen
    
    % ɾȥtrain�г������Ϊ��0����Ԫ�أ����ϲ�
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
    
    % ����ѭ��1 ���Թɵ�������ά��
    sequence=[];
    time = 0;
    time1 = 0;
    [Matrix,L]=dye(Input,Output);
    [sequence1,Input,Output,Matrix,L]=low(Input,Output,Matrix,L,R);
    sequence = [sequence sequence1];
    time1 = time1 + length(sequence1);
    
    % ���ǡ���ά����ɵ�������Լ��
    % �����ǹɵ�Խ���µĵ��������
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
                    time1 = time1 + time2 + i;
                    time2 = 0;
                    [sequence2,Input,Output,Matrix,L]=low(Input,Output,Matrix,L,R);
                    i = 1;
                    j = 1;
                    sequence = [sequence sequence2];
                    sequence2 = [];
                    track = zeros(L,b+1);
                end
                flag = 1;
            end
        end
    end
    sequence = [sequence sequence2];
    total(k) = length(sequence);
    time = time1 + time2;
    T(k) = time;
    if k == 1
        temp = length(sequence);
        array = sequence;
        send = A(k,:);
        T1 = temp;
        T2 = temp;
    else
        if length(sequence) < T1
            T1 = length(sequence);
            array1 = sequence;
            send1 = A(k,:);
        elseif length(sequence) > T2
            T2 = length(sequence);
            array2 = sequence;
            send2 = A(k,:);
        end
    end
    Input = memorizement;
end
disp('��ý����')
send1;
array1;
disp('����')
send2;
array2;
toc