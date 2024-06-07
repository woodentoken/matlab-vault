s = tf('s');
G = [0 -1/(s+1); 1 1/(s*(s+1))];
%G = minreal(G);

w = 10^-3:0.001:10^3;

Gss = ss(G);
[Ag, Bg, Cg, Dg] = ssdata(Gss);

%% p uncertainty filter (T)
W_delta = makeweight(0.5, 5, 1000);
W_d = tf(W_delta);
W_dtf = [W_d 0; 0 W_d];
W_d_ss = ss(W_dtf);
[Ad, Bd, Cd, Dd] = ssdata(W_d_ss);
%[Ad, Bd, Cd, Dd] = minreal(Ad, Bd, Cd, Dd);

%% P Performance filter (S)
W_p = makeweight(500, 50, 0.01);
W_p = tf(W_p);
W_ptf = [W_p 0; 0 W_p];
W_p_ss = ss(W_ptf);
[Ap, Bp, Cp, Dp] = ssdata(W_p_ss);
%[Ap, Bp, Cp, Dp] = minreal(Ap, Bp, Cp, Dp);

%% Y actuation filter (Y)
W_y_num = {5 0; 0 5};
W_y_den = {1 1; 1 1};
W_y = tf(W_y_num, W_y_den);
W_y_ss = ss(W_y);
[Au, Bu, Cu, Du] = ssdata(W_y_ss);
%[Au, Bu, Cu, Du] = minreal(Au, Bu, Cu, Du);

%% augment the plant matrix with the filters
[A, B1, B2, C1, C2, D11, D12, D21, D22] = augss(...
    Ag, Bg, Cg, Dg, ...
    Ap, Bp, Cp, Dp, ...
    Au, Bu, Cu, Du, ...
    Ad, Bd, Cd, Dd ...
);

B = [B1   B2];
C = [C1 ; C2];
D = [D11 D12; D21 D22];

G_augmented = ss(A,B,C,D);

%% compute Hinf controller
[G_c, T_zw, gamma] = hinfsyn(G_augmented, 2, 2);

[Ac, Bc, Cc, Dc] = ssdata(G_c);
Kss = ss(Ac, Bc, Cc, Dc);
Kss = minreal(Kss);

%% matrices

ltf = loopsens(Gss, Kss);
loop_poles = ltf.Poles;
loop_stable = ltf.Stable;
ltf = rmfield(ltf, 'Poles');
ltf = rmfield(ltf, 'Stable');

% get minimum realization of every loop transfer function
loop_fields = fieldnames(ltf);
for i = 1:length(loop_fields)
    ltf.(loop_fields{i}) = minreal(ltf.(loop_fields{i}));
end

%% confirming loopsens is equivalent to hand calculation
Ly_l = ltf.Lo;
Ly = Gss*Kss;
sigma(Ly, 'r', Ly_l, 'c--')

Ty_l = ltf.To;
Ty = feedback(Ly, eye(2));
sigma(Ty, 'r', Ty_l, 'c--')

Y = minreal(Kss*ltf.So);

%% plotting
figure(1)
subplot(3,1,1)
sigma( ...
    ltf.Lo, 'm', ...
    W_ptf, '', ...
    1/W_dtf, 'c'...
    )
legend('Ly', 'Wp', '1/Wd')
grid
set(gca,'Color','k')

subplot(3,1,2)
sigma( ...
    ltf.So, 'r', ...
    ltf.To, 'w', ...
    W_ptf, '', ...
    1/W_dtf, 'c'...
    )
legend('Sy', 'Ty', 'Wp', '1/Wd')
grid
set(gca,'Color','k')

subplot(3,1,3)
sigma( ...
    Y, 'y', ...
    G, '', ...
    G_c, '' ...
    )
legend('Y', 'Gp', 'Gc')
grid
set(gca,'Color','k')

figure(2)
step(ltf.To)
title('closed loop step response')
grid

figure(3)
step(Y)
title('actuator activity under step response')
grid

%% Problem 2
Tzw = lft(G_augmented, Kss);
%subplot(3,1,2)
% sigma( ...
%     ltf.To, 'r', ...
%     Gtf, 'm', ...
%     G_c, 'w' ...
%     )
% legend('Y', 'Gp', 'Gc')
% grid
% set(gca,'Color','k')
% 
% subplot(3,1,3)
% sigma( ...
%     ltf.To, 'r', ...
%     Gtf, 'm', ...
%     G_c, 'w' ...
%     )
% legend('Y', 'Gp', 'Gc')
% grid
% set(gca,'Color','k')



