clearvars; close all; clc
load('CylinderFlow.mat');

% CylinderFlow contains flow fields reshaped into column vectors
X = CylinderFlow(:,1:end-1); % data matrix X
Xp = CylinderFlow(:,2:end);  % data matrix X prime

%% part a:  visualizing the flow field
time_snaps = [1 10 20 30 50 100];
figure
subplot(2, 3, 1)
for index = 1:length(time_snaps)
    axisi = subplot(2, 3, index);
    plotCylinder(axisi, real(reshape(X(:,time_snaps(index)),199,449)));
    title(['t = ', num2str(time_snaps(index), '%d')])
end

%% part b: 

% complete DMD.m

%% part c: 

r= 5;
[Phi_5, Lambda_5, b_5] = DMD(X, Xp, r);
Lambda_5_vec = diag(Lambda_5);

r= 20;
[Phi_20, Lambda_20, b_20] = DMD(X, Xp, r);
Lambda_20_vec = diag(Lambda_20);

% Compare Lambda (the eigenvalues)
figure(10)
hold on
plot(real(Lambda_20_vec), imag(Lambda_20_vec), 'bo', 'DisplayName', 'r=20')
plot(real(Lambda_5_vec), imag(Lambda_5_vec), 'ro', 'MarkerSize', 3, 'DisplayName', 'r=5')
grid on
axis equal
xlabel('Real')
ylabel('Imag')
title('Comparison of Lambda')
legend()

% Compare b (the mode amplitude weightings)
figure(11)
hold on
plot(real(b_20), imag(b_20), 'bs', 'DisplayName', 'r=20')
plot(real(b_5), imag(b_5), 'rs', 'MarkerSize', 3, 'DisplayName', 'r=5')
grid on
xlabel('Real')
ylabel('Imag')
title('Comparison of b')
legend()


%% part d:
figure(20)
subplot(2,2,1)
time_checks = [10 20 50 100];
time_checks = [10];
for indexd = 1:length(time_checks)
    axisd = subplot(2,2,indexd);
    x_approx_5 = Phi_5 * Lambda_5 ^time_checks(indexd) * b_5;
    x_approx_5 = real(reshape(x_approx_5, 199, 449));
    plotCylinder(axisd, x_approx_5)
    title(['t = ', num2str(time_checks(indexd), '%d')])

    axise = subplot(2,2,indexd);
    approx_difference = real(X(:,time_checks(indexd))) - x_approx_5;
    plotCylinder(axise, real(approx_difference))
    title(['difference, real and approx at t = ', num2str(time_checks(index), '%d')])
end