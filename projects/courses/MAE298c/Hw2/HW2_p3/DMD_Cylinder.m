clearvars; close all; clc
load('CylinderFlow.mat');

% CylinderFlow contains flow fields reshaped into column vectors
X = CylinderFlow(:,1:end-1); % data matrix X
Xp = CylinderFlow(:,2:end);  % data matrix X prime

%% part a:  visualizing the flow field
time_snaps = [1 10 20 30 50 100];
figure
subplot(2, 3, 1)
sgtitle('flow time history')
for index = 1:length(time_snaps)
    axisi = subplot(2, 3, index);
    plotCylinder(axisi, real(reshape(X(:,time_snaps(index)),199,449)));
    title(['t = ', num2str(time_snaps(index), '%d')])
end

%% part b:

% complete DMD.m - Done

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
plot(real(Lambda_5_vec), imag(Lambda_5_vec), 'ro', 'MarkerFaceColor', 'r', 'MarkerSize', 5, 'DisplayName', 'r=5')
plot(real(Lambda_20_vec), imag(Lambda_20_vec), 'co', 'MarkerFaceColor', 'c', 'MarkerSize', 3, 'DisplayName', 'r=20')

grid on
axis equal
xlabel('Real')
ylabel('Imag')
title('Comparison of Lambda')
legend()

% Compare b (the mode amplitude weightings)
figure(11)
hold on
plot(real(b_5), imag(b_5), 'rs', 'MarkerFaceColor', 'r', 'MarkerSize', 5, 'DisplayName', 'r=5')
plot(real(b_20), imag(b_20), 'cs', 'MarkerFaceColor', 'c', 'MarkerSize', 3, 'DisplayName', 'r=20')

grid on
xlabel('Real')
ylabel('Imag')
title('Comparison of b')
legend()


%% part d:

time_checks = [10 20 50 100];
r_vec = [1 5 20];

% consider multiple truncations
for index_r = 1:length(r_vec)
    r = r_vec(index_r);
    figure(r+100)
    subplot(2,2,1)
    sgtitle(['difference real and approximate, r = ', num2str(r)])

    % evaluate at each time step
    for index_approx = 1:length(time_checks)

        [Phi, Lambda, b] = DMD(X, Xp, r);
        Lambda_vec = diag(Lambda);

        % plot the reconstructed flow field
        axis_reconstruction = subplot(2,2,index_approx);
        
        % I assume we use this form of the X approximation, 
        X_approx = Phi * Lambda^(time_checks(index_approx)) * b;
        X_approx = real(reshape(X_approx, 199, 449));

        plotCylinder(axis_reconstruction, X_approx)
        title(['t = ', num2str(time_checks(index_approx), '%d')])

        % plot the difference between true and approximate
        axis_difference = subplot(2,2,index_approx);
        approx_difference = real(reshape(X(:, time_checks(index_approx)),199,449)) - X_approx;

        plotCylinder(axis_difference, real(approx_difference))
        title(['t = ', num2str(time_checks(index_approx), '%d')])

        rmse_matrix = rmse(real(reshape(X(:, time_checks(index_approx)),199,449)), X_approx);
        rmse_vec(index_approx) = sum(rmse_matrix);
    end

    % plot the sum of the root mean square errors for each time point
    figure(200)
    plot(time_checks, rmse_vec, '-o', 'LineWidth', 2, 'DisplayName', ['r = ', num2str(r)])
    hold on
    xlabel('time')
    ylabel('sum of root mean square error, per timestep')
end
legend()