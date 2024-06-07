% Defining Laplace operator and frequency range
s = tf('s');
w=10^-2:0.01:10^3;
% Defining plant tranfer function matrix
Gp=[4/(s+4) 0;(4*s*(3*s+16))/((s+4)*(s+8)) (8*(s-200))/(s+8)];
%Computation of Unimodular Matrices by new automated approach by tranpose
UL =[ 0 1;...
1 (7247*s)/123200 - (151*s^2)/492800 + 7549/15400];
UR =[ (151*s)/1971200 - 7549/492800 s^2/4 - 49*s - 200;...
-(453*s)/3942400 - 1/6400, - 2*s - (3*s^2)/8];
z=0.707;
wn=7.5;
%Computing Youla and enforcing interpolation condition
% Selecting Youla

Y1=-(wn^2*(s^2+12*s+32)*(s-200))/((s^2+2*z*wn*s+wn^2)*(s+200));
Y2=-(wn^2)/((s^2+2*z*wn*s+wn^2)*(s+200));
My=[Y1 0;0 Y2];
% Transform into coupled system
Y = zpk(minreal(UR*My*UL,1e-3)); % bodemag(Y)
Ty = zpk(minreal(Gp*Y,1e-3)); % bodemag(T)
Sy = zpk(minreal(eye(2)-Ty,1e-3)); % bodemag(S)
% Compution of the closed loop transfer functions for the second node
Tu = zpk(minreal(Y*Gp,1e-3));
Su = zpk(minreal(eye(2)-Tu,1e-3));
% Controller and return ratio computation
Gc = zpk(minreal(Y*Sy^-1,1e-3)); % bodemag(Gc)
%
Ly=zpk(minreal(Gp*Gc));
%define Wdelta
Wdelta1=makeweight(0.5,50,1000); %(0.25,3000,15);
Wd1=tf(Wdelta1);
Wdelta2=makeweight(0.5,50,1000);
Wd2=tf(Wdelta2);
Wdtf=[Wd1 0;0 Wd2];
%define Wp
Wp1=makeweight(1000,5,0.5);
Wp1tf=tf(Wp1);
Wp2=makeweight(1000,5,0.5); %(50/0.0001,70,0.25);
Wp2tf=tf(Wp2);
Wptf=[Wp1tf 0;0 Wp2tf];
%Plots
figure(1)
sigma(Gp,w)
hold on
sigma(Gc,w)
sigma(Y,w)
hold off
legend('Gp','Gc','Y')
grid
set(gca,'Color','w')
figure(2)
sigma(Ly,w)
hold on
sigma(Ty,w)
sigma(Sy,w)
sigma(Wptf,w)
sigma(1/Wdtf,w)
hold off
legend('Ly','Ty','Sy','Wptf','1/Wdtf')
grid
set(gca,'Color','w')
figure(3)
sigma(Sy,w)
hold on
sigma(Su,w)
hold off
legend('Sy','Su')
grid
set(gca,'Color','w')
figure(4)
t=0:0.01:2;
[y] =step(Ty,t);
k=1:length(t);
plot(t,y(k,1,1),'-');
title('Plot of step reponses first input to the first and second output')
hold on
plot(t,y(k,2,1),'--')
legend('y1(t)','y2(t)');
xlabel('time (s)')
grid
set(gca,'Color','w')
figure(5)
t=0:0.01:2;
[y] =step(Ty,t);
k=1:length(t);
plot(t,y(k,1,2),'-');
title('Plot of step reponses second input to the first and second output')
hold on
plot(t,y(k,2,2),'--')
legend('y1(t)','y2(t)');
xlabel('time (s)')
grid
set(gca,'Color','w')
figure(6)
[ya,t] =step(Y);
k=1:length(t);
plot(t,ya(k,1,1),'-');
title('Plot of actuator reponses to the first input')
hold on
plot(t,ya(k,2,1),'-')
legend('u1(t)','u2(t)');
xlabel('time (s)')
grid
set(gca,'Color','w')
figure(7)
[ya,t] =step(Y);
k=1:length(t);
plot(t,ya(k,1,2),'-');
title('Plot of actuator reponses to second input')
hold on
plot(t,ya(k,2,2),'--')
legend('u1(t)','u2(t)');
xlabel('time (s)')
grid
set(gca,'Color','w')
[SVWpSy]=sigma(Wptf*Sy,w);
LmWpSy=20*log10(SVWpSy(1,:));
[SVWdTy]=sigma(Wdtf*Ty,w);
LmWdTy=20*log10(SVWdTy(1,:));
LmRp=20*log10(SVWpSy(1,:)+SVWdTy(1,:));
figure(8);
semilogx(w,LmWpSy,'r',w,LmWdTy,'g',w,LmRp,'b'),grid;
legend('sigma(Wptf*Sy)','sigma(Wdtf*Ty)','sigma(Wptf*Sy)+sigma(Wdtf*Ty)')
xlabel('Frequency (rad/sec)');
ylabel('Gain dB');
grid
set(gca,'Color','w')