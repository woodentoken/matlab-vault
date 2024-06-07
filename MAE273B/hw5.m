%% Problem 1

%% Problem 2

%% Problem 3
s = tf('s');
%syms s;
Gptfm = [1/(s+2)^2 (s+1)/(s+2); -(s+1)/(s+2) (s+1)/(s+2)];
%GpH2 = h2norm(Gptfm)

%% Problem 4
% syms s;
s = tf('s');
P = 100*[s s 1;1 1 1];
Gp = P/(s+1);

UL = [1 -s;0 1];
UR = [0 1 -1;-1 0 1;1 0 0];
MP = 100*[1-s 0 0;0 1 0];
MP = MP/(s+1);

P_validate = inv(UL)*MP*inv(UR);

Y1 = 1/(s+1)^2;
Y2 = (1-s)/(s+1)^2;
MY = 1/100*[Y1 0; 0 Y2;0 0];
MT = MY*MP;

Gc = simplify(UR*inv(eye(3) - MY*MP)*MY*UL);

Ly = Gp*Gc;
Lu = Gc*Gp;

Sy = inv(eye(2)+Ly);
Su = inv(eye(3)+Lu);
Ty = Sy * Ly;
Y = inv(eye(3)+Lu)*Gc;

figure(1)
opts = sigmaoptions;
opts.XLim = [0.001, 1000];
sigmaplot(Ty, 'c', Sy, 'r', Su, 'b-.', Y, 'm--', opts)
legend('Ty', 'Sy', 'Su', 'Y')
grid on

figure(2)
sigmaplot(Gc, 'k', Gp, 'g', Ly, 'r', Y, 'm--', opts)
legend('Gc', 'Gp', 'Ly', 'Y')
grid on
%% Problem 5