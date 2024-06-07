function [Phi, Lambda, b] = DMD(X, Xprime, r)

% Step 1 : Perform SVD and truncate based on r
[U, Sigma, V] = svd(X, 'econ');
Ur = U(:, 1:r);
Sigmar = Sigma(1:r, 1:r);
Vr = (V(:, 1:r));

% Step 2 : Reconstruct a simplified matrix A tilde
Atilde = Ur'*Xprime*Vr/Sigmar;

% Step 3 : Reduced order eigenvalues and eigenvectors, note, Lambda should
% match the eigenvalues of Sigmar
[W, Lambda] = eig(Atilde);

% Step 4 : 
Phi = Xprime*(Vr/Sigmar)*W;
alpha1 = Sigmar*Vr(1,:)';
b = (W*Lambda)\alpha1;