function A=perm(offset,a,species)
% �ú��������������еĳ����������
global gen
global A
if offset == species
    % ��ʱ�õ����飬�����ж�
    A(gen,:) = a;
    gen = gen + 1;
else
    for i = offset:species
        a=swap(i,offset,a);
        A=perm(offset+1,a,species);
        a=swap(i,offset,a);
    end
end