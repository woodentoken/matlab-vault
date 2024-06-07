close all; clearvars; clc
set(groot,'defaultLineLineWidth',2)
%% Problem 1
A=[0 1;-1 -2];
B=[10 0;0 25];
C=[1 -1;0 2];
D=[0 1;0 0];

s = tf('s');
G_p = simplify( C * inv( s*eye(2) - A) * B + D);
I = eye(2);
G_c = I;

% return ratios
Ly = G_p*G_c;
Lu = G_c*G_p; % in this case, Lu = Ly

% characteristic transfer function matrices
Ty = simplify( inv(I + Ly) * Ly );
Sy = I - Ty;
Y = simplify( inv(I + Lu) * G_c );

figure(1);
sp = sigmaplot(Sy, 'r', Ty, 'c', Y, 'y--');
legend();
title('system principal gains');
grid on

%% Problem 2
A = [ 1 -1 ; 2 3 ; 1 6];
Sigma = [ 6.9875  0; 0 1.7817];
V = [0.2488 -0.9685; 0.9685 0.2488];
U = A*V*inv(Sigma)
% I think this shortcut only works if A is square...
% refer to HW2 for the calculation of U

%% Problem 3

%% Problem 4
% just doing some checking here - might not actually work at all...
syms s
P = [-47*s+2 56*s; -42*s 50*s+2];
lambda = eig(P);
X = [1.1429 1.1667;1 1];

%% Problem 5
w = logspace(-4,10,100000);  
In = eye(2); Im = eye(4);  
mnyq = zeros(size(w));  
for k = 1:length(w) 
	mnyq(k) = det(In + Cly * inv(1i*w(k)*Im-Aly) * Bly + Dly);  
end % end for k  
plot(real(mnyq),imag(mnyq),real(mnyq),-imag(mnyq))  

