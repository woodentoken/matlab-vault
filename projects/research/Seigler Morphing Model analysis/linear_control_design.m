clearvars; clc; close all;
% This is a recreation of a pitch-attitude hold autopilot design that will
% achieve a desired pitch reference command during transition from loiter
% to dash

% we design a control law for both the loiter and dash configurations
% separately, using rigid aircraft equations. Assuming the control
% structure is the same for both configurations, the gains can be scheduled
% during transition based on the c.g. location. 

% steady state conditions are chosen as follows:
alpha = 2; % degrees
M = 0.5; % mach
h = 30000; % feet
VT = 500; % ft/s

% loiter
xcg=10.8;
Cm_alpha=-0.1373;
Jy_star=0.2537;
Cm_q_star=-0.0508;
Cm_alpha_dot_star=-0.0253;
Cz_d_e=0.8136;
Cm_d_e=2.8533;

% Dash
xcg=13.2;
Cm_alpha=-0.7269;
Jy_star=0.3088;
Cm_q_star=-0.3088;
Cm_alpha_dot_star=-0.02875;
Cz_d_e=0.8193;
Cm_d_e=1.9940;

B_both = [0;0;0;0;20.2];
C=[0 0 1 0 0];
D=0;



%% Loiter
A_loiter = [0 -499.7 499.7  0 0; 0 -0.9913 0 1 0.1351; 0 0 0 1 0; 0 -0.5736 0 -0.3899 14.58; 0 0 0 0 -20.2];
loiter_sys = ss(A_loiter,B_both,C,D);

[NUM_loiter, DEN_loiter]=ss2tf(A_loiter,B_both,C,D);
pitch_angle_tf_loiter = tf(NUM_loiter, DEN_loiter);

f=figure(1);
subplot(1,2,1)
rlocus(pitch_angle_tf_loiter)
xlim([-1.5, 0])
ylim([-3,3])
title('Loiter Root Locus')
set(gca, 'XGrid', 'on')
set(gca, 'YGrid', 'on')
zpk(pitch_angle_tf_loiter)

%% Dash
A_dash = [0 -499.7 499.7  0 0; 0 -0.6567 0 1 0.1361; 0 0 0 1 0; 0 -2.029 0 -0.1659 5.71; 0 0 0 0 -20.2];
dash_sys = ss(A_dash, B_both, C, D);

[NUM_dash, DEN_dash]=ss2tf(A_dash,B_both,C,D);
pitch_angle_tf_dash = tf(NUM_dash, DEN_dash);

subplot(1,2,2)
rlocus(pitch_angle_tf_dash)
xlim([-1.5, 0])
ylim([-3,3])
title('Dash Root Locus')
set(gca, 'XGrid', 'on')
set(gca, 'YGrid', 'on')
zpk(pitch_angle_tf_dash)

f.Position = [100 100 800 400];


