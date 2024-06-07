%% Problem 1
clearvars; clc; close all;
I = eye(2);
%syms s;
s = tf('s');
A = [[0 1];[-2 -3]];
B = [[10 0];[0 25]];
C = [[1 -1];[0 2]];
D = [[0 1];[0 0]];

Gp = C*inv((s*eye(2)-A))*B + D;

% common plotting options
sigma_opts = sigmaoptions;
sigma_opts.XLimMode = 'manual';
sigma_opts.YLimMode = 'manual';
sigma_opts.XLim=[0.1, 1000];
sigma_opts.YLim=[-20, 20];

step_opts = RespConfig;
step_opts.Delay = 1;

step_tf_final = 2;

%% vary the value of Ki with Kp constant:
Kp = [0.25 1 1 1 1];
Ki = [1 1 10 25 100];
colors = ['r', 'o', 'y', 'g'];
step_tf_final = 2;
time = [0:0.001:step_tf_final];
r1 = [ones(length(time), 1) zeros(length(time), 1)];
r2 = [zeros(length(time), 1) ones(length(time), 1)];
for i=1:length(Kp)
    Gc = [Kp(i)+Ki(i)/s 0; 0 Kp(i)+Ki(i)/s];

    Ly = simplify(Gp*Gc);
    Lu = simplify(Gc*Gp);

    Sy = simplify(inv(I + Ly));
    Ty = simplify(Sy*Ly);
    Y = simplify(inv(I+Lu)*Gc);

    figure(110)
    sigmaplot(Ty, sigma_opts)
    hold on

    figure(120)
    lsim(Ty, r1, time);
    hold on

    figure(125)
    lsim(Ty, r2, time);
    hold on

    figure(130)
    lsim(Y, r1, time);
    hold on

    figure(135)
    lsim(Y, r2, time);
    hold on
end
figure(110)
legend('Ki = 0', 'Ki = 1', 'Ki = 10', 'Ki = 25', 'Ki = 100', 'Location', 'best')
title('Sigma response to step input, Kp = 1')
grid on
saveas(gcf, 'sigma_Ki.png')
hold off

figure(120)
legend('Ki = 0', 'Ki = 1', 'Ki = 10', 'Ki = 25', 'Ki = 100', 'Location', 'best')
title('Output response to step input (input 1), Kp = 1')
grid on
saveas(gcf, 'output_Ki_input1.png')
hold off

figure(125)
legend('Ki = 0', 'Ki = 1', 'Ki = 10', 'Ki = 25', 'Ki = 100', 'Location', 'best')
title('Output response to step input (input 2), Kp = 1')
grid on
saveas(gcf, 'output_Ki_input2.png')
hold off

figure(130)
legend('Ki = 0', 'Ki = 1', 'Ki = 10', 'Ki = 25', 'Ki = 100', 'Location', 'best')
title('Actuation response to step input (input 1), Kp = 1')
grid on
saveas(gcf, 'actuation_Ki_input1.png')
hold off

figure(135)
legend('Ki = 0', 'Ki = 1', 'Ki = 10', 'Ki = 25', 'Ki = 100', 'Location', 'best')
title('Actuation response to step input (input 2), Kp = 1')
grid on
saveas(gcf, 'actuation_Ki_input2.png')
hold off

%% vary the value of Kp with Ki constant:
close all;
Kp = [0 0.25 0.5 1 2];
Ki = [1 1 1 1 1];

for i=1:length(Kp)
    Gc = [Kp(i)+Ki(i)/s 0; 0 Kp(i)+Ki(i)/s];

    Ly = simplify(Gp*Gc);
    Lu = simplify(Gc*Gp);

    Sy = simplify(inv(I + Ly));
    Ty = simplify(Sy*Ly);
    Y = simplify(inv(I+Lu)*Gc);

    figure(111)
    sigmaplot(Ty, sigma_opts)
    hold on
    figure(121)
    lsim(Ty, r1, time);
    hold on

    figure(126)
    lsim(Ty, r2, time);
    hold on

    figure(131)
    lsim(Y, r1, time);
    hold on

    figure(136)
    lsim(Y, r2, time);
    hold on
end
figure(111)
legend('Kp = 0', 'Kp = 0.25', 'Kp = 0.5', 'Kp = 1', 'Kp = 2', 'Location', 'best')
title('Sigma response to step input, Ki = 1')
grid on
saveas(gcf, 'sigma_Kp.png')
hold off

figure(121)
legend('Kp = 0', 'Kp = 0.25', 'Kp = 0.5', 'Kp = 1', 'Kp = 2', 'Location', 'best')
title('Output response to step input (input 1), Ki = 1')
grid on
saveas(gcf, 'output_Kp_input1.png')
hold off

figure(126)
legend('Kp = 0', 'Kp = 0.25', 'Kp = 0.5', 'Kp = 1', 'Kp = 2', 'Location', 'best')
title('Output response to step input (input 2), Ki = 1')
grid on
saveas(gcf, 'output_Kp_input2.png')
hold off

figure(131)
legend('Kp = 0', 'Kp = 0.25', 'Kp = 0.5', 'Kp = 1', 'Kp = 2', 'Location', 'best')
title('Actuation response to step input (input 1), Ki = 1')
grid on
saveas(gcf, 'actuation_Kp_input1.png')
hold off

figure(136)
legend('Kp = 0', 'Kp = 0.25', 'Kp = 0.5', 'Kp = 1', 'Kp = 2', 'Location', 'best')
title('Actuation response to step input (input 2), Ki = 1')
grid on
saveas(gcf, 'actuation_Kip_input2.png')
hold off

%% Problem 2
clc
I = eye(2);
syms s;
%s = tf('s');
A = [[0 1];[-2 -3]];
B = [[10 0];[0 25]];
C = [[1 -1];[0 2]];
D = [[0 1];[0 0]];

G = C*inv((s*eye(2)-A))*B + D;
P = simplify((s+1)*(s+2)*G);

% found via row/column operations:
UL = [0 -1/4; 1 (s+5)/4];
UR = [1/10 5*s/54; 0 2/27];

Y1 = 2;
Y2 = 2/((s+1)*(s+2));
MY = [Y1 0; 0 Y2];
Mp_base = [1 0; 0 (s+1)*(s+2)];
Mp = simplify(Mp_base/((s+1)*(s+2)));

% closed loop smith form
MT = simplify(MY*Mp);

% Controller and plant reconstruction
Gc = UR * inv( I - MT ) * MY * UL;
Gc = simplify(Gc);
Gp = simplify(G);

% open loop transfer functions
Lu = Gc*Gp;
Ly = Gp*Gc;

% % alternative formulation of the characteristic TFM % %
% Sy = inv(eye(2) + Ly);
% Ty = Sy * Ly;
% Y = inv(eye(2) + Lu)*Gc;

% % closed loop transfer functions
Ty = inv(UL) * MT * UL;
Sy = I - Ty;

% Youla transfer function
Y = UR*MY*UL;

s = tf('s');
Sy = [(s*(s+3))/(s^2 + 3*s +2) 0; 0 (s*(s+3))/(s^2+3*s+2)];
Ty = I - Sy;
Y = [5*s/(27*(s^2+3*s+2)) -(s^2-22*s+27)/(270*(s^2+3*s+2)); 4/(27*(s^2+3*s+2)) (s+5)/(27*(s^2+3*s+2))];

step_tf_final = 5;
time = [0:0.001:step_tf_final];
r1 = [ones(length(time), 1) zeros(length(time), 1)];
r2 = [zeros(length(time), 1) ones(length(time), 1)];

% singular value plots
figure(21)
sigmaplot(Sy, 'r', Ty, 'c', Y, 'y');
legend('Sy', 'Ty', 'Youla', 'Location', 'best');
grid on

% step response 1?
figure(22)
lsim(Ty, r1, time)
title('output response to step reference input (input 1)')
legend('output')
grid on;

% step response 1?
figure(122)
lsim(Y, r1, time)
title('actuation response to step reference input (input 1)')
legend('actuation')
grid on;

% step response 2?
figure(23)
lsim(Ty, r2, time);
title('output response to step reference input (input 2')
legend('output', 'actuation')
grid on;

% step response 1?
figure(122)
lsim(Y, r2, time)
title('actuation response to step reference input (input 1)')
legend('actuation')
grid on;

%% Problem 3
s = tf('s');
Gp = [[0 -1/(s+1)];[1 1/(s*(s+1))]];
P = [[0 -s];[s*(s+1) 1]];

Mp = [s 0;0 1/(s*(s+1))];
MY = [1/(s*(s+1)^2) 0; 0 s/(s+1)];
MT = Mp*MY;

UL = [1 s;0 1];
UR = [1 0; -s*(s+1) 1];

Gc = UR * inv(eye(2) - MY * Mp) * MY * UL;

Lu = Gc*Gp;
Ly = Gp*Gc;

Sy = inv(eye(2) + Ly);
Ty = Sy * Ly;
Y = inv(eye(2) + Lu)*Gc;

sigmaplot(Sy, 'r', Ty, 'c', Y, 'y');
legend('Sy', 'Ty', 'Youla', 'Location', 'best');
grid on

step(Ty, [0 10])

%% Problem 4
clearvars; clc;
syms s;
clc;
%s = tf('s');
I = eye(2);

%Gp = [[-1/s (-s+1)/s];[1/(s^2+1) 0]];
P = [-(s^2+1) (-1-s)*(s^2+1) ; s 0];
del=s*(s^2+1);
%simplify(P/del)
%[UL_, UR_, Mp_del] = smithForm(P);

UL = [-1 -s;-s -1-s^2];
UR = [1 -s^3-s^2-s-1;0 1];

Mp = 50*[1/(s*(s^2+1)) 0; 0 (s+1)];
Gp = simplify(inv(UL)*Mp*inv(UR)); % checking

% selecting by hand
Y1 = (1/50)*(s^2+1)*s*(-15*s^2+1)/(s+1)^8;
Y2 = (1/50)*(-15*s^2+1)/((s+1)^(8)*(s+1));
MY = [Y1 0 ; 0 Y2];

MT = simplify(Mp*MY);
Ty_base = inv(UL)*MT*UL;
Sy_base = inv(UL)*(I-MT)*UL;

% my Ty satisfies the interpolation condition, but Y is not stable...
% (poles on imaginary axis)

Gc = UR * inv(eye(2) - MY * Mp) * MY * UL;

Ly = Gp*Gc;
Lu = Gc*Gp;
Y = inv(eye(2) + Lu)*Gc;

sigma_opts = sigmaoptions;
sigma_opts.XLimMode = 'manual';
% sigma_opts.YLimMode = 'manual';
sigma_opts.XLim=[0.001, 1000];
% sigma_opts.YLim=[-2, 20];

% sigmaplot(Sy, 'r', Ty, 'c', Y, 'y');
%sigmaplot(Sy_base, 'r', Ty_base, 'c', Y, 'y', sigma_opts);
%legend('Sy', 'Ty', 'Youla', 'Location', 'best');

MT = [(-15*s^2+1)/(s+1)^8 0;0 (-15*s^2+1)/(s+1)^8];
MY = [Y1 0;0 Y2];

Gc = UL*inv(I-MT)*MY*UR

%% Problem 5
