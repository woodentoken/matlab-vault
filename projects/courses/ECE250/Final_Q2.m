%% Final Q2
A = [[-3/2 0 0 0];
     [0 -2/3 1/3 0];
     [0 1/3 -2/3 0];
     [0 0 0 -1]];
B = [1/2;1/3;1/3;0];
C = [0 2/3 2/3 -1];
D = -1/3;

% state space representation
sys=ss(A,B,C,D);

% identify the basis of each:
ctrb_reduced = rref(ctrb(A,B)); % -> pivot columns identify basis
obsv_reduced = rref(obsv(A,C)); % -> pivot rows identify basis

% throwback to homework 1
fundamental_subspaces(obsv(A,C))
% probably has some bug, I am ignoring the clearly erroneous result ([0 1 0
% 0]')

% confirm [1 0 0 0]^T resides in R
reachable_basis = [1/2 -3/4; 1/3 -1/9; 1/3 -1/9 ; 0 0];
human_reachable_basis = [reachable_basis(:,1)*3 reachable_basis(:,2)*9]
rref([human_reachable_basis [1;0;0;0]])

% transformation matrix to Kalman Decomposition
T = [[0 1 0 0];[1 0 0 1];[1 0 0 -1];[0 0 1 0]];
Tinv = inv(T);

% kalman decomposition
A_tilde = Tinv*A*T
B_tilde = Tinv*B
C_tilde = C*T
D_tilde = D

