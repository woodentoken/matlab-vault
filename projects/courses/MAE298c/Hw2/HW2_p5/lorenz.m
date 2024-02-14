function dx = lorenz(t,x,Beta)
% x(1) = x
% x(2) = y
% x(3) = z
dx = [
Beta(1)*(x(2)-x(1)); % xdot
x(1)*(Beta(2)-x(3))-x(2); % ydot
x(1)*x(2)-Beta(3)*x(3); % zdot
];