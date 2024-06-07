clearvars; close all; clc;

rng(12345)

% config dashboard
order_N = 20;
outputs_P = 20;
inputs_M = 2;
measurements_m = 100;
time_t = linspace(1, measurements_m, measurements_m);

% generate random discrete state space models
random_state_space = drss(order_N, order_N, inputs_M); % we assume all states are in the output
random_state_space.D = zeros(outputs_P, inputs_M); % assume D = 0

% define inputs
Upsilon = randn(inputs_M, measurements_m);

% simulate the random state space
X_out(:,1)=zeros(1,order_N);
for i = 2:measurements_m
    X_out(:,i) = random_state_space.A*X_out(:,i-1)+random_state_space.B*Upsilon(:,i-1);
end

X = X_out(:, 1:measurements_m-1);
X_prime = X_out(:, 2:measurements_m);

% Using the data matrices X, X′ and Υ, the DMDc compu-
% tation can be performed to find an approximation of ˜A and
% ˜B. To compare the generated model and the model produced
% by DMDc, we assign ˜C = ˆU. The assignment allows for the
% comparison of state-space models.

% Step 1 - Collect X, X', and Y, Construct Omega
Omega = [X; Upsilon(:, 1:measurements_m-1)];

% Step 2 - Compute the SVD of Omega
[U_tilde, S_tilde, V_tilde] = svd(Omega, "econ");

% "econ" tends to leave zeros which makes the inversion singular - we
% truncate some additional degrees here
truncator = 1;
S_tilde = S_tilde(1:end-truncator, 1:end-truncator);
U_tilde = U_tilde(:, 1:end-truncator);
V_tilde = V_tilde(:, 1:end-truncator);

% Step 3 - Compute the SVD of the output space X'
[U_hat, S_hat, V_hat] = svd(X_prime, "econ");

% Step 4 - Compute the algorithm approximations of A_tilde and B_tilde
U_tilde_1 = U_tilde(1:outputs_P,:);
U_tilde_2 = U_tilde(outputs_P+1:end,:);

% approximate A and B
A_bar = X_prime * V_tilde * inv(S_tilde) * U_tilde_1';
B_bar = X_prime * V_tilde * inv(S_tilde) * U_tilde_2';

% Reduced order approximation of A
A_tilde = U_hat' * A_bar * U_hat;
B_tilde = U_hat' * B_bar;
C_tilde = U_hat;
D_tilde = random_state_space.D; % zero

spectral_reconstruction_state_space = ss(A_tilde, B_tilde, C_tilde, D_tilde);

eig(U_hat'*spectral_reconstruction_state_space.A*U_hat)
eig(random_state_space.A)

% simulate the low rank approximation of state space
X_out_tilde(:,1)=zeros(1,order_N);
for i = 2:measurements_m
    X_out_tilde(:,i) = U_hat*(A_tilde*U_hat'*X_out_tilde(:,i-1)+random_state_space.B*Upsilon(:,i-1));
end

% plot prediction of dynamics via low rank approximation
ax(1) = subplot(2,1,1);
plot(time_t, X_out)
title('original dynamics')
xlabel('time (s)')
ylabel('states')
grid on

ax(2) = subplot(2,1,2);
plot(time_t, X_out_tilde)
title('dynamics via low rank approximation')
xlabel('time (s)')
ylabel('states')
grid on

linkaxes(ax, 'y')

% sigma comparison
figure(2)
sigma(spectral_reconstruction_state_space)
hold on
sigma(random_state_space)

% investigate the dynamic properties of A
[W, Lambda] = eig(A_tilde);

% Solve for the dynamic modes of A
phi = A_bar*U_hat*W;

