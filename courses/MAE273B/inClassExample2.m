% Hinf example problem
w=logspace(-2,4);
s=tf('s');
% define plant

Gtf=[4/(s+4) 0;(4*s*(3*s+16))/((s+4)*(s+8)) (8*(s-200))/(s+8)];
Gtf=minreal(Gtf);
Gtfss=ss(Gtf);
[Ag,Bg,Cg,Dg]=ssdata(Gtfss);

%define Wdelta
Wdelta1=makeweight(0.5,50,1000);
Wd1=tf(Wdelta1);
Wdelta2=makeweight(0.5,50,1000);
Wd2=tf(Wdelta2);
%
Wdtf=[Wd1 0;0 Wd2];
Wdtfss=ss(Wdtf);
[Ad,Bd,Cd,Dd]=ssdata(Wdtfss);
[Ad,Bd,Cd,Dd]=minreal(Ad,Bd,Cd,Dd);
%define Wp
Wp1=makeweight(1000,5,0.5);
Wp1tf=tf(Wp1);
Wp2=makeweight(1000,5,0.5);
Wp2tf=tf(Wp2);
%
Wptf=[Wp1tf 0;0 Wp2tf];
Wptfss=ss(Wptf);
[Ap,Bp,Cp,Dp]=ssdata(Wptfss);
[Ap,Bp,Cp,Dp]=minreal(Ap,Bp,Cp,Dp);
%
%define Wy
Wynum={0.01 0; 0 0.01}; Wyden={1 1; 1 1};
Wy=tf(Wynum,Wyden);
Wyss=ss(Wy);
[Au,Bu,Cu,Du]=ssdata(Wyss);
[Au,Bu,Cu,Du]=minreal(Au,Bu,Cu,Du);
%compute augmented plant
[A,B1,B2,C1,C2,D11,D12,D21,D22]=...
augss(Ag,Bg,Cg,Dg,...
Ap,Bp,Cp,Dp,...
Au,Bu,Cu,Du,...
Ad,Bd,Cd,Dd);
B=[B1 B2];
C=[C1;C2];
D=[D11 D12;D21 D22];
Gaug=ss(A,B,C,D);
%compute Hinf controller

[Gc,CL,GAM]=hinfsyn(Gaug,2,2);

[acp,bcp,ccp,dcp]=ssdata(Gc);
K=ss(acp,bcp,ccp,dcp);
K=minreal(K);

Yo = loopsens(Gtfss, K);

Ly=Gtfss*K;
Ly=minreal(Ly);
Ty=feedback(Ly,eye(2));
Ty=minreal(Ty);
Sy=(eye(2)+Ly)^-1;
Sy=minreal(Sy);
Y=K*Sy;
Y=minreal(Y);
Tu = zpk(minreal(Y*Gtf,1e-3));
Su = zpk(minreal(eye(2)-Tu,1e-3));
%
[SVWpSy]=sigma(Wptf*Sy,w);
LmWpSy=20*log10(SVWpSy(1,:));
[SVWdTy]=sigma(Wdtf*Ty,w);
LmWdTy=20*log10(SVWdTy(1,:));
LmRp=20*log10(SVWpSy(1,:)+SVWdTy(1,:));

Yo.Lo
Ly
%%
figure(1)
sigma(Ly);
hold on
sigma(Wptf,w);
hold on
sigma(1/Wdtf,w);
hold off
legend('Ly','Wp','1/Wd')
grid
set(gca,'Color','w')

figure(2)
sigma(Sy,w);
hold on
sigma(Ty,w);
hold on
sigma(Wptf,w);
hold on
sigma(1/Wdtf,w);
legend('Sy','Ty','Wp','1/Wd')
grid
set(gca,'Color','w')

figure(3)
sigma(Y,w)
hold on
sigma(Gtf,w)
hold on
sigma(K,w)
legend('Y','G','K')
grid
set(gca,'Color','w')

figure(4)
[y,t] =step(Ty);
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
[y,t] =step(Ty);
k=1:length(t);
plot(t,y(k,1,2),'-');
title('Plot of step reponses second input to the first and second output')
hold on
plot(t,y(k,2,2),'--')
legend('y1(t)','y2(t)');
xlabel('time (s)')
grid
set(gca,'Color','w')

figure(55)
step(Ty)

figure(6)
t=0:0.001:0.2;
[ya] =step(Y,t);
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
t=0:0.001:0.2;
[ya] =step(Y,t);
k=1:length(t);
plot(t,ya(k,1,2),'-');
title('Plot of actuator reponses to second input')
hold on
plot(t,ya(k,2,2),'--')
legend('u1(t)','u2(t)');
xlabel('time (s)')
grid
set(gca,'Color','w')

figure(77)
step(Y,t)

figure(8);
semilogx(w,LmWpSy,'r',w,LmWdTy,'g',w,LmRp,'b'),grid;
legend('sigma(Wptf*Sy)','sigma(Wdtf*Ty)','sigma(Wptf*Sy)+sigma(Wdtf*Ty)')
xlabel('Frequency (rad/sec)');
ylabel('Gain dB');
grid
set(gca,'Color','w')