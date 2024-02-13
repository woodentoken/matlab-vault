function [Phi, Lambda, b] = DMD(X,Xprime,r)

[U,Sigma,V] = svd(X,'econ');      % Step 1
Ur = ;
Sigmar = ;
Vr = ;

Atilde = ;    % Step 2
[W,Lambda] = ;         % Step 3

Phi = ;       % Step 4
alpha1 = ;
b = ;