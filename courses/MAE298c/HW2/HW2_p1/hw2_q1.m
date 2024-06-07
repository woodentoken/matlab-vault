A = [[0.3536 0 0.25 0.25];[0 -1.4142 -1 -1];[0.6124 0 0.433 -0.433]];
b = [1;1;1];

A_squared = A'*A
[V, S] = eig(A_squared);

% have to flip these because the MATLAB eig function returns them in an
% unexpected order
S_squared = fliplr(flipud(S))
%% 1.a
% non-zero eigenvectors (orthonormal)
V1 = fliplr(V(:,2:4))

%% 1.b
% zero eigenvectors
V2 = fliplr(V(:,1))

%% 1.c
A_squared_2 = [V1 V2] * S_squared * [V1'; V2']

%% 1.d
% we only have two (nonzero) singular values here, so we select them for S
S_tilde = sqrt(S_squared(1:3,1:3))

% calculate left singular vectors - using the non-zero singular values
U1 = A*V1*S_tilde
U1_tilde = [U1(:,1)/norm(U1(:,1)) U1(:,2)/norm(U1(:,2)) U1(:,3)/norm(U1(:,3))]

% if this is zero, then U1 is orthogonal
dot(U1(:,1),(U1(:,2)))

%% 1.e
% selected by inspection
U2 = [0; 0 ;0];
U2_tilde = [U2(:,1)/norm(U2(:,1))]

%% 1.f - Actually solve Ax=b
V1_tilde = V1;

% calculate using the SVD
A_dagger = V1_tilde * inv(S_tilde) * U1_tilde';

% solve for least square x
x_tilde = A_dagger*b