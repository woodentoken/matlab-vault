%% Common setup
clearvars, close all, clc

dt = 0.01; % sample time for data
n=3; % number of columns
polyorder = 3; % up to third order polynomials of candidate functions

%% part a - SYS1 sparse identification
load('SYS1.mat')
Theta = poolData(x, n, polyorder); % library of functions
Beta = [10; 28; 8/3]; % Lorenz's parameters (chaotic)
for i=1:length(x)
    dx_1(i,:) = lorenz(0, x(i,:), Beta);
end

lambda_1 = [0.01 0.025 1];
for index_1 = 1:length(lambda_1)
    lambda_1(index_1)
    Xi_1 = sparsifyDynamics(Theta, dx_1, lambda_1(index_1), n);
    poolDataLIST({'x', 'y', 'z'}, Xi_1, n, polyorder);
end

%% part b - SYS2 sparse identification
load('SYS2.mat')
Theta = poolData(x, n, polyorder); % library of functions

for i=1:length(x)
    dx_2(i,:) = dynamic_p5(0, x(i,:));
end

lambda_2 = [0.001 0.025 0.5];
for index_2 = 1:length(lambda_2)
    lambda_2(index_2)
    Xi_2 = sparsifyDynamics(Theta, dx_2, lambda_2(index_2), n);
    poolDataLIST({'x', 'y', 'z'}, Xi_2, n, polyorder);
end

%% part c.a - SYS1 sparse identification (from data)
load('SYS1.mat')
Theta = poolData(x, n, polyorder); % library of functions

dx_data_1 = diff(x)/dt;
dx_data_1_full = [dx_data_1; dx_data_1(end,:)];
lambda_d1 = [0.001 0.025 1];
for index_d1 = 1:length(lambda_d1)
    lambda_d1(index_d1)
    Xi_1d = sparsifyDynamics(Theta, dx_data_1_full, lambda_d1(index_d1), n);
    poolDataLIST({'x', 'y', 'z'}, Xi_1d, n, polyorder);
end

%% part c.b - SYS2 sparse identification (from data)
load('SYS2.mat')
Theta = poolData(x, n, polyorder); % library of functions

dx_data_2 = diff(x)/dt;
dx_data_2_full = [dx_data_2; dx_data_2(end,:)];
lambda_d2 = [0.01 0.025 0.5];
for index_d2 = 1:length(lambda_d2)
    lambda_d2(index_d2)
    Xi_2d = sparsifyDynamics(Theta, dx_data_2_full, lambda_d2(index_d2), n);
    poolDataLIST({'x', 'y', 'z'}, Xi_2d, n, polyorder);
end
 
%% part d.a  - noisy SYS1 sparse identification (from data)
% lets add noise for fun :)
load('SYS1.mat')
% noise for SYS1
noise_1 = normrnd(0.1,0.2, size(x,1), size(x,2));

% add noise to measurements
x_1_noisy = x + noise_1;
dx_1_noisy = diff(x_1_noisy)/dt;
dx_1_noisy_full = [dx_1_noisy; dx_1_noisy(end,:)];

Theta = poolData(x_1_noisy, n, polyorder); % library of functions

lambda_d1 = [0.001 0.025 1];
for index_d1 = 1:length(lambda_d1)
    lambda_d1(index_d1)
    Xi_1d = sparsifyDynamics(Theta, dx_1_noisy_full, lambda_d1(index_d1), n);
    poolDataLIST({'x', 'y', 'z'}, Xi_1d, n, polyorder);
end

%% part d.b - noisy SYS1 sparse identification (from data)
% lets add noise for fun :)
load('SYS2.mat')
% noise for SYS2
noise_2 = normrnd(0.1,0.2, size(x,1), size(x,2))/100;

% add noise to measurements
x_2_noisy = x + noise_2;
dx_2_noisy = diff(x_2_noisy)/dt;
dx_2_noisy_full = [dx_2_noisy; dx_2_noisy(end,:)];

Theta = poolData(x_2_noisy, n, polyorder); % library of functions

lambda_d2 = [0.01 1 3];
for index_d2 = 1:length(lambda_d2)
    lambda_d2(index_d2)
    Xi_2d_noisy = sparsifyDynamics(Theta, dx_2_noisy_full, lambda_d2(index_d2), n);
    poolDataLIST({'x', 'y', 'z'}, Xi_2d_noisy, n, polyorder);
end

