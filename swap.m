function a=swap(i,offset,a)
% �ú�����������������Ԫ��ֵ
temp = a(i);
a(i) = a(offset);
a(offset) = temp;