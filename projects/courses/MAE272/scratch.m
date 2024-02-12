%% 1
A = [[1 2 3];[0 0 6];[0 1 7]]
B = [[1 1];[0 0];[0 0]]
C = [[1 0 0];[0 1 0]]

ctrb(A,B)

%% 2
A = [[1 1];[-1 -1]]
B = [1;-1]
C = [1 0]
D = 1

sys = ss(A,B,C,D)
[Abar, Bbar, Cbar] = ctrbf(A,B,C)
rank(ctrb(A,B))

T = [[1 0];[1 1]]
Tinv = inv(T)

Abar_ = T*A*Tinv 

[Ao, Bo, Co] = obsvf(A,B,C)
rank(obsv(A,C))

%% 3

%% 4
R = [[1 0];[0 2]]
[[3 3];[3 3]]*inv(R) * [[3 3];[3 3]]

[3 3]*[[1 1];[1 1]]*[3;3]