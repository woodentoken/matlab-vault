clear all, close all, clc
load('CylinderFlow.mat');


% CylinderFlow contains flow fields reshaped into column vectors
X = CylinderFlow(:,1:end-1);  % data matrix X
Xp = CylinderFlow(:,2:end);  % data matrix X prime


%% part a:  visualizing the flow field
t= 20; % time instant for ploting the flow field.
plotCylinder(real(reshape(X(:,t),199,449)));


%% part b: 

% complete DMD.m

%% part c: 

r= 5;
[Phi, Lambda, b] = DMD_sol(X,Xp,r);
% complete the rest




%% part d:

x_10 = ;

