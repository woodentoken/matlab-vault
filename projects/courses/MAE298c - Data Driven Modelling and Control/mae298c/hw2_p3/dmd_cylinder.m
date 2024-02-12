clearvars; close all; clc
load('cylinderflow.mat');

% CylinderFlow contains flow fields reshaped into column vectors
X = CylinderFlow(:,1:end-1);  % data matrix X
Xp = CylinderFlow(:,2:end);  % data matrix X prime

%% part a:  visualizing the flow field
time_snaps = [1 10 20 50 100];
figure
subplot(length(time_snaps), 1, 1)
for index = 1:length(time_snaps)
    axisi = subplot(length(time_snaps), 1, index);
    plotcylinder(axisi, real(reshape(X(:,time_snaps(index)),199,449)));
    title(['t = ',num2str(time_snaps(index), '%d')])
end

%% part b: 

% complete DMD.m

%% part c: 

r= 5;
%[Phi, Lambda, b] = DMD_sol(X,Xp,r);
% complete the rest


%% part d:

%x_10 = ;
