%% Problem 1
close all; clearvars; clc
A=[0 1;-1 -2];
B=[10 0;0 25];
C=[1 -1;0 2];
D=[0 1;0 0];

syms s;
G_p = simplify( C * inv( s*eye(2) - A) * B + D);
I = eye(2);
G_c = I;

% return ratios
Ly = G_p*G_c;
Lu = G_c*G_p; % in this case, Lu = Ly

% characteristic transfer function matrices
%Sy = simplify( inv(I + Ly));
Ty = simplify( inv(I + Ly) * Ly );

%Ty = I - Sy;
Sy = I - Ty;
Y = simplify( inv(I + Lu) * G_c );

figure(1);
sp = sigmaplot(Sy, 'r', Ty, 'c', Y, 'y--');
legend();
title('system principal gains');
grid on

%% Problem 4 part d
close all; clearvars; clc
s = tf('s');
P = [-47*s+2 56*s; -42*s 50*s+2];

lambda_1 = s+2;
lambda_2 = 2*s+2;

eig_1 = lambda_1*eye(2)-P;
eig_2 = lambda_2*eye(2)-P;

syms s
P = [-47*s+2 56*s; -42*s 50*s+2];
[UL,UR,M]=smithForm(P)

s = tf('s');
lambda_tf = [2/(s+2) 0;0 1/(s+2)]

figure(4)
subplot(1,2,1)
margin(lambda_tf(1,1))
subplot(1,2,2)
margin(lambda_tf(2,2))


%% Problem 5
close all; clearvars; clc;
A = [-3 -2 0 0 ; 1 0 0 0 ; 0 0 -3 -2 ; 0 0 1 0];
B = [8 0 ; 0 0 ; 0 8; 0 0 ];
C = [-5.8750 0.25 7 0; -5.25 0 6.25 0.25];
D = [0 0; 0 0];

K_p = [1 0;0 1];
K_p_alt = [1.13 0; 0 0.88];

K(:,:,1) = [1 0;0 1];
K(:,:,2) = [1.13 0;0 0.88];

syms s;

figure(5)
for index = 2:2
    Aly = A;
    Bly = B*K(:,:,index);
    Cly = C;
    Dly = D*K(:,:,index);

    w = logspace(-4,10,100000);
    In = eye(2); Im = eye(4);
    mnyq = zeros(size(w));
    Lym = det(In + Cly * inv(s*Im - Aly) * Bly + Dly);

    for k = 1:length(w)
    	mnyq(k) = det(In + Cly * inv(1i*w(k)*Im - Aly) * Bly + Dly);
    end % end for k
    ax(index) = subplot(1,2,index);
    plot(real(mnyq),imag(mnyq),real(mnyq),-imag(mnyq))
    grid on
    hold on
    xlim([-4,4])
    ylim([-4,4])
    xline(0)
    yline(0)
    plot(0, 0, '+', 'linewidth', 2, 'color', 'k') % plot the -1 point for Nyquist encirclements
end % end for index

%title(ax(1), 'Kp = I')
%title(ax(2), 'Kp != I')
