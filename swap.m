function a=swap(i,offset,a)
% 该函数用来交换向量的元素值
temp = a(i);
a(i) = a(offset);
a(offset) = temp;