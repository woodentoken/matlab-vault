% Question 4

% alot of this is scratch work, may not be useful to parse
A = [[0 1 0];[-4 0 0];[0 0 0]];
eig(A);
B = [0;1;0];
C = [1 0 1];

%% reachability
rank([B A*B A*A*B])
Omega = [C' A'*C' A'*A'*C']

p = [-2;-2;-2];

%% testing observer gain
K = acker(A',C',p)

K2 = [0 0 1]*inv(Omega)*[6;12;8]

eig(A-K'*C)

alpha = A'^3 + 6*A'^2 + 12*A' + 8*eye(3)

[0 0 1]*inv(Omega)*alpha

pp = [-2+2j, -2-2j, 0]

[Ao,Bo,Co]=obsvf(A,B,C)

%% testing controller gain
acker(A,B,[pp])

T = [[0 1 0];[1 0 0];[0 0 1]]
inv(T)

[Ac,Bc,Cc] = ctrbf(A,B,C)

eig(Ac)

