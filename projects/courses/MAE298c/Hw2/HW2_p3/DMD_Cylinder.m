clearvars; close all; clc
load('CylinderFlow.mat');

% CylinderFlow contains flow fields reshaped into column vectors
X = CylinderFlow(:,1:end-1); % data matrix X
Xp = CylinderFlow(:,2:end);  % data matrix X prime

%% part a:  visualizing the flow field
time_snaps = [1 10 20 50 100];
figure
subplot(3, 3, 1)
for index = 1:length(time_snaps)
    axisi = subplot(3, 3, index);
    plotCylinder(axisi, real(reshape(X(:,time_snaps(index)),199,449)));
    title(['t = ', num2str(time_snaps(index), '%d')])
end

%% part b: 

% complete DMD.m

%% part c: 

r= 5;
[Phi_5, Lambda_5, b_5] = DMD(X, Xp, r);

r= 20;
[Phi_20, Lambda_20, b_20] = DMD(X, Xp, r);


%% part d:

% x_10 = ;

