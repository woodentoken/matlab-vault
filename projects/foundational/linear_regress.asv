%%% INTRO
% the goal of this code is to create a linear function with a slope 'm' and
% then add lots of noise to that function. Then, we us the SVD to recover
% the "best" fit of the noisy data in a linear regression sense, and
% compare the slope of that line 'mtilde' to that of the underlying slope
% 'm'

%%% SETUP
m = 3;
x = linspace(0,pi, 10)';

% extremelly noisy measurement
noise = 5*randn(size(x));

%%% CALCULATION
y = m*x + 1*noise;
% plot best fit (slop)
plot(x,m*x,'k', DisplayName="de noised slope")
hold on

% plot noisy data
plot(x,y, 'rx', DisplayName="noisy data")
grid on

legend("Position", [0.31845,0.82094,0.18929,0.077566])

[U,S,V] = svd(x,'econ')

% recover the weights of 
mtilde = V*inv(S)*U'*y

% plot best linear regression via SVD
plot(x, mtilde*x, 'b--', DisplayName="best fit (linear regression)")
hold off