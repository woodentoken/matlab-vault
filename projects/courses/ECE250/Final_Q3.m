%% Final Q3
A = [[-1 1 0];
    [1 -2 1];
    [0 1 -1]];

[V,D,W]=eig(A)
W*D*V

A*A'
A'*A

%%% MEMS
syms a b s k m o

mem3 = [[0 2*o 0 0];[-2*o 0 0 0];[k/m 0 0 0];[0 k/m 0 0]]
det(s*eye(4)-mem3)
mem = [[0 0 1 0];[0 0 0 1];[b 0 0 -a];[0 -b -a 0]];
k=5
m=20
o=12
mem2 = [[0 0 1 0];[0 0 0 1];[k/m 0 0 -2*o];[0 -k/m -2*o 0]]
det(s*eye(4)-mem)
det(s*eye(4)-mem2)

eig(mem2)