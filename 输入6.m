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
    Input = memorizement;
    sequence=[];
    time1 = 0;
    [Matrix,L]=dye(Input,Output);
    [sequence1,Input,Output,Matrix]=low(Input,Output,Matrix,L,R);
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
                    time1 = time1 + time2;
                    time2 = 0;
                    [sequence1,Input,Output,Matrix,L]=low(Input,Output,Matrix,L,R);
                    i = 1;
                    j = 1;
                    sequence = [sequence sequence1];
                    time1 = time1 + length(sequence1);
                    track = zeros(L,b+1);
                end
                flag = 1;
            end
        end
    end
    time = time1 + time2;
    if k == 1
        temp = time;
        array = sequence;
        send = A(k,:)
    else
        if time > temp
            temp = time;
            array = sequence;
            send = A(k,:);
        end
    end
end
disp('�����������Ϊ��')
send
disp('���س�������Ϊ��')
array