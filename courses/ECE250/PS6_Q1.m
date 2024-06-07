%% Question 1
A = [[1 1 0];[0 1 0];[0 0 1]];
B = [0;1;1];
C = [[1 1 0];[0 1 0]];
D = 0;

Omega_r = [B A*B A*A*B];
rank(Omega_r);

Omega_o = [C;C*A;C*A*A];
rank(Omega_o);
null(Omega_o)

%% Question 2.b
syms omega
A = [[0 1 0 0];[3*omega^2 0 0 2*omega];[0 0 0 1];[0 -2*omega 0 0]];
B = [[0 0];[1 0];[0 0];[0 1]];

Omega_r = [B A*B A*A*B A*A*A*B]
if rank(Omega_r) ~= min(size(A))
    fprintf('the system is not fully reachable')
else
    fprintf('the system is fully reachable')
end

%% Question 2.c - no axial thruster
syms omega
A = [[0 1 0 0];[3*omega^2 0 0 2*omega];[0 0 0 1];[0 -2*omega 0 0]];
B = [[0 0];[0 0];[0 0];[0 1]];

Omega_r = [B A*B A*A*B A*A*A*B]
if rank(Omega_r) ~= min(size(A))
    fprintf('the system with no axial thruster is not fully reachable')
else
    fprintf('the system is fully reachable, even without an axial thruster')
end

%% Question 2.d - no tangential thruster
syms omega
A = [[0 1 0 0];[3*omega^2 0 0 2*omega];[0 0 0 1];[0 -2*omega 0 0]];
B = [[0 0];[1 0];[0 0];[0 0]];

Omega_r = [B A*B A*A*B A*A*A*B]
if rank(Omega_r) ~= min(size(A))
    fprintf('the system with no tangential thruster is not fully reachable')
else
    fprintf('the system is fully reachable, even without a tangential thruster')
end

%% Question 2.e - transfer function computation
syms omega s
A = [[0 1 0 0];[3*omega^2 0 0 2*omega];[0 0 0 1];[0 -2*omega 0 0]];

adjoint((s*eye(4) - A))

%% Question 3 - circuit analysis
A = [[-2 0];[0 2]];
B = [0; 1];
C = [1 0];

Omega_r = [B A*B]
Omega_o = [C;C*A]

%% Question 4 & 5 - checking chariot eigendecomposition
a = 0.2; % ratio of d to M
b = 2; % ratio of gravity to length l
A = [[0 1 0 0]; [0 -a 0 0]; [0 0 0 1]; [-b 0 b 0]];

[V,D,W] = eig(A)

syms l g d M
A_p = [[0 1 0 0]; [0 -d/M 0 0]; [0 0 0 1]; [-g/l 0 g/l 0]]
C_p = [[0 0 1/l 0];[1 0 1 0]]
Omega_o = [C_p;C_p*A_p;C_p*A_p*A_p;C_p*A_p*A_p*A_p]
rank(Omega_o)