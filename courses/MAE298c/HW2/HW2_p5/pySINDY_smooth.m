clearvars; close all; clc;
dt = 0.01; % sample time for data
n=3; % number of columns
polyorder = 3; % up to third order polynomials of candidate functions

%% question 6.a - smooth noisy SYS1 sparse identification (from data)
% lets add noise for fun :), then smooth it out

load('SYS1.mat')
% noise for SYS2
noise_1 = normrnd(0.1,0.2, size(x,1), size(x,2));

% add noise to measurements
x_1_noisy = x + noise_1;

% noisy data
dx_1_noisy = diff(x_1_noisy)/dt;
dx_1_noisy_full = [dx_1_noisy; dx_1_noisy(end,:)];

% true data (no noise)
dx_1 = diff(x)/dt;
dx_1_full = [dx_1; dx_1(end,:)];

% smoothed data (noise smoothed via sav_gol filter)
for i = 1:3
    x_1_sm(:,i) = smoothed_finite_difference(x(:,i), 3, 11);
end

dx_1_sm = diff(x_1_sm)/dt;
dx_1_sm_full = [dx_1_sm; dx_1_sm(end,:)];

% plot differences
figure(61)
subplot(2,3,1)
index = linspace(0,1,length(x));
axis_labels = ['x', 'y', 'z'];
for i = 1:3
    subplot(2,3,i)
    hold on
    grid on
    plot(index, x_1_noisy(:,i), 'LineWidth', 3)
    plot(index, x_1_sm(:,i), 'LineWidth', 2)
    plot(index, x(:,i), '--', 'LineWidth', 1)
    xlabel('index')
    ylabel(num2str(axis_labels(i)))
    title(['measurements of ', num2str(axis_labels(i))])
    legend('noisy', 'smoothed', 'clean', 'Location', 'best')

    subplot(2,3,i+3)
    hold on
    grid on
    plot(index, dx_1_noisy_full(:,i), 'LineWidth', 3)
    plot(index, dx_1_sm_full(:,i), 'LineWidth', 2)
    plot(index, dx_1_full(:,i), '--', 'LineWidth', 1)
    title(['numerical derivative of ', num2str(axis_labels(i))])
    legend('noisy', 'smoothed', 'clean', 'Location', 'best')
end

Theta = poolData(x_1_sm, n, polyorder); % library of functions

lambda_d1 = [0.01 0.1 0.5];
for index_d1 = 1:length(lambda_d1)
    lambda_d1(index_d1)
    Xi_2_smooth = sparsifyDynamics(Theta, dx_1_sm_full, lambda_d1(index_d1), n);
    poolDataLIST({'x', 'y', 'z'}, Xi_2_smooth, n, polyorder);
end

%% question 6.b - smooth noisy SYS2 sparse identification (from data)
% lets add noise for fun :), then smooth it out
load('SYS2.mat')
% noise for SYS2
noise_2 = normrnd(0.1,0.2, size(x,1), size(x,2))/100;

% add noise to measurements
x_2_noisy = x + noise_2;

% noisy data
dx_2_noisy = diff(x_2_noisy)/dt;
dx_2_noisy_full = [dx_2_noisy; dx_2_noisy(end,:)];

% true data (no noise)
dx_2 = diff(x)/dt;
dx_2_full = [dx_2; dx_2(end,:)];

% smoothed data (noise smoothed via sav_gol filter)
for i = 1:3
    x_2_sm(:,i) = smoothed_finite_difference(x(:,i), 3, 11);
end

dx_2_sm = diff(x_2_sm)/dt;
dx_2_sm_full = [dx_2_sm; dx_2_sm(end,:)];

% plot differences
figure(62)
subplot(2,3,1)
index = linspace(0,1,length(x));
axis_labels = ['x', 'y', 'z'];
for i = 1:3

    subplot(2,3,i)
    hold on
    grid on
    plot(index, x_2_noisy(:,i), 'LineWidth', 3)
    plot(index, x_2_sm(:,i), 'LineWidth', 2)
    plot(index, x(:,i), '--', 'LineWidth', 1)
    xlabel('index')
    ylabel(num2str(axis_labels(i)))
    title(['measurements of ', num2str(axis_labels(i))])
    legend('noisy', 'smoothed', 'clean', 'Location', 'best')

    subplot(2,3,i+3)
    hold on
    grid on
    plot(index, dx_2_noisy_full(:,i), 'LineWidth', 3)
    plot(index, dx_2_sm_full(:,i), 'LineWidth', 2)
    plot(index, dx_2_full(:,i), '--', 'LineWidth', 1)
    title(['numerical derivative of ', num2str(axis_labels(i))])
    legend('noisy', 'smoothed', 'clean', 'Location', 'best')
end

Theta = poolData(x_2_sm, n, polyorder); % library of functions

lambda_d2 = [0.01 0.1 0.5];
for index_d2 = 1:length(lambda_d2)
    lambda_d2(index_d2)
    Xi_2_smooth = sparsifyDynamics(Theta, dx_2_sm_full, lambda_d2(index_d2), n);
    poolDataLIST({'x', 'y', 'z'}, Xi_2_smooth, n, polyorder);
end