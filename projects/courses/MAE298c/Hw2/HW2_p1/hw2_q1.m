A = [[0.3536 0 0.25 0.25];[0 -1.4142 -1 -1];[0.6124 0 0.433 0.433]];
b = [1;1;1];


A_square = A'*A

[V, S_squared] = eig(A_square)

%% 1.a
% non-zero eigenvectors (orthonormal)
V1 = V(:,3:4);

%% 1.b
% zero eigenvectors
V2 = V(:,1:2);

%% 1.c
% i am reversing some directions here due to how MATLAB returns eigenvalues
A_square_2 = [V2 V1] * S_squared * [V2';V1']

%% 1.d
% we only have two singular values here, so we select them for S
S_tilde = S_squared(3:4,3:4)

% calculate left singular vectors
U1 = A*V1*S_tilde

% if this is zero, then U1 is orthonormal
dot(U1(:,1),(U1(:,2)))

%% 1.e
% selected by inspection
U2 = [-1.7320;0;1];

%% 1.f
V_tilde = V1;
% normalize U
U_tilde = [U1(:,1)/norm(U1(:,1)) U1(:,2)/norm(U1(:,2))];

% calculate using the SVD
A_dagger = V_tilde * inv(sqrt(S_tilde)) * U_tilde';

% solve for least square x
x_tilde = A_dagger*b

