clear all, close all, clc


%% Load Data
load('SYS1.mat')
dt = 0.01; % sample time for data
n=3; 

%% Compute Derivative


%% part a 

Beta = [10; 28; 8/3]; % Lorenz's parameters (chaotic)
for i=1:length(x)
    dx(i,:) = lorenz(0,x(i,:),Beta);
end



%////////////////////////////////////
%% part b


% for i=1:length(x)
%     dx(i,:) = dynamic_p5(0,x(i,:));
% end


%% part c
% for i=1:3
%     dx(:,i) = diff(x(:,i))/dt;
% end
% dx = [dx; dx(end,:)];
% 
% 
%% part d
% lets add noise for fun :)
% noise for SYS1
% noise = normrnd(0.1,0.2, size(x,1), size(x,2));

% noise for SYS2
% noise = normrnd(0.1,0.2, size(x,1), size(x,2))/100;
% 
% x = x+noise;
% 
% 
% for i=1:3
%     dx(:,i) = diff(x(:,i))/dt;
% end
% dx = [dx; dx(end,:)];


%% Build library and compute sparse regression
polyorder = 3; % up to third order polynomials
Theta = poolData(x,n,polyorder); 
lambda = 0.01;      % lambda is our sparsification knob.
Xi = sparsifyDynamics(Theta,dx,lambda,n)
poolDataLIST({'x','y','z'},Xi,n,polyorder);

