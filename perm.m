function A=perm(offset,a,species)
% 该函数用来遍历所有的出车排列情况
global gen
global A
if offset == species
    % 此时得到数组，进行判断
    A(gen,:) = a;
    gen = gen + 1;
else
    for i = offset:species
        a=swap(i,offset,a);
        A=perm(offset+1,a,species);
        a=swap(i,offset,a);
    end
end