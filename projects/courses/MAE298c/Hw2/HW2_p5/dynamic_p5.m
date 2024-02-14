function dx = dynamic_p5(t, x)
% x(1) = x
% x(2) = y
% x(3) = z
dx = [
-x(1)+0.1*x(2)^2+0.01*x(2)*x(3); % xdot
x(1)*x(3)-0.02*x(2)-x(1)^2*x(2); % ydot
0.01*x(1)*x(2)+0.1*x(3)-0.1*x(3)^2; % zdot
];