clc; clear; close all

%% Question 1
A1 = [[1 -2];[1 -2];[-2 1];[1 -3]];
b = [-2 5 1 -3]';

least_square_system = [A1'*A1 A1'*b];
rref(least_square_system)

%% Question 5
%% 5.a
a = [[8 -8 -2];[4 -3 -2];[3 -4 1]];
a = sym(a);
[Vaa, Daa] = eig(a);
[Va,Ja] = jordan(a) % three distinct eigenvalues

%% 5.b
b = [[1 0 -4];[0 3 0];[-2 0 -1]];
b = sym(b);
[Vbb, Dbb] = eig(b);
[Vb,Jb] = jordan(b) % two distinct eigenvalues, one repeated eigenvalue

%% 5.c
c = [[2 1 1];[0 3 1];[0 -1 1]];
c = sym(c);
[Vcc, Dcc] = eig(c);
[Vc,Jc] = jordan(c) % one eigenvalue

