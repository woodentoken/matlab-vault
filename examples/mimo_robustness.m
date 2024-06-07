%% Example - MIMO Robustness to uncertainty

% 2 input 2 output system with aprametric uncertainty in state space
% matrices
% create uncertain parameter p
% create matrices A and C dependent on p
% assume B is known

p_nom = 10;
p_uncer = 10;
p = ureal('p', p_nom, 'percentage', p_uncer);

p_known = p_nom;

A = [0 p; -p 0]; % looks like oscillation to me
A_known = [0 p_known; -p_known 0];
B = eye(2);
C = [1 p; -p 1];
D = zeros(2);

H_known = ss(A_known,B,C,D);
H = ss(A,B,C,D);

% plot the known open loop response so we can compare it to uncertain
% responses
% step(sys_known, [0 10]);

get(H)

%% add actuator uncertainty
% this system includes no actuator dynamics, we assume that the actuators
% merely pass the input signals at all frequencies

% lets add uncertainty to the first channel actuator:
% - actuator 1: uncertain at low frequency and not modelled beyond 20 rad/s
% - actuator 2: uncertain at low frequency (20%) and not modelled beyond 45 rad/s

% makeweight creates filters 
W1 = makeweight(0.4, 40, 50); % DC, Crossover, High Frequency
W2 = makeweight(0.1, 50, 50);

Delta1 = ultidyn('Delta1', [1 1]);
Delta2 = ultidyn('Delta2', [1 1]);

% addes frequency domain uncertainty to our model which captures the
% uncertainty in the actuator dynamics
% function of the weighting filters
% function of the uncertain "Delta" system
G = H*blkdiag(1 + W1*Delta1, 1 + W2*Delta2);
stepplot(G,2)

load('mimoKexample.mat')

%% loop sensitivity
% all the relevant sensitivity transfer functions for the system
F = loopsens(G, K);

bodemag(F.PSi.NominalValue, 'r+', F.PSi, 'b-', {1e-1 100})

%% disk margin
[DMo, MMo] = diskmargin(G*K); % output margin
[DMi, MMi] = diskmargin(K*G); % input margin

% this is the margin at the plant ouput for the second feedback channel
DMo(2)

% independent variation in input channels
MMi;

% multiloop margins at the plant outputs (similar to the input margins but
% that is not always the case)
MMo;

% simultaneous variation in input and output
MMio = diskmargin(G,K); % margins against variations at input and output (simultaneously)

%$ robstab considers the variation with uncertainty and is more realistic
%ont he whole, diskmargin considers only the nominal system with no
%uncertainty
opt = robOptions('Display', 'on');
stabmarg = robstab(F.So, opt);

%% Worst case gain analysis
% plot the output sensitivity of the nominal system
bodemag(F.So.NominalValue, {1e-1 100})
[PeakNom, freq] = getPeakGain(F.So.NominalValue);
[maxgain, wcu] = wcgain(F.So);
maxgain;

% compare the step response of the nominal value to the worst case
% uncertainty system
step(F.To.NominalValue, usubs(F.To, wcu), 5)

% examine the closed loop system worst case performance against nominal
% performance in terms of singular values
wcsigmaplot(F.To, {1e-1, 100})