% Hinf example problem

w=logspace(-3,3);

s=tf('s');


Gtf= 100*[s/(s+1) s/(s+1) 1/(s+1);1/(s+1) 1/(s+1) 1/(s+1)];

Gtf=minreal(Gtf);
Gtfss=ss(Gtf);
[Ag,Bg,Cg,Dg]=ssdata(Gtfss);
[Ag,Bg,Cg,Dg]=minreal(Ag,Bg,Cg,Dg);

%define Wd (Robust uncertainty filter)

Wdtf=[(0.25*(0.2*s+1))/(10^-3*s+1) 0;0 (0.25*(0.2*s+1))/(10^-3*s+1)];
Wd=makeweight(0.25, [13 0.70],50);
Wdtf1=tf(Wd);
%% By students, define a new robust uncertanity filter

Wdss=ss(Wdtf);
[Ad,Bd,Cd,Dd]=ssdata(Wdss);
[Ad,Bd,Cd,Dd]=minreal(Ad,Bd,Cd,Dd);


%define Wu (Actuator filter)

Wutf=[0.0005 0 0;0 0.0005 0;0 0 0.0005];
Wuss=ss(Wutf);
[Au,Bu,Cu,Du]=ssdata(Wuss);
[Au,Bu,Cu,Du]=minreal(Au,Bu,Cu,Du);

% you can test an empty matrix for Wutf;
%Wutf=[];

%define Wp (Performance filter)

Wptf=[(0.4*s+1)/((s+0.01)) 0;0  (0.4*s+1)/((s+0.01))];
Wp=makeweight(100, [1.7 0.7], 0.4);
Wptf1=tf(Wp);

%% By students, define a new performance filter

Wpss=ss(Wptf); [Ap,Bp,Cp,Dp]=ssdata(Wpss);
[Ap,Bp,Cp,Dp]=minreal(Ap,Bp,Cp,Dp);

%compute augmented plant
[A,B1,B2,C1,C2,D11,D12,D21,D22]=...
    augss(Ag,Bg,Cg,Dg,...
          Ap,Bp,Cp,Dp,...
          Au,Bu,Cu,Du,...
          Ad,Bd,Cd,Dd);     

P = augw(Gtf,Wptf,Wutf,Wdtf);
%Compute Hinf controller - two approaches 1- using hinfopt command 2- using
%hinfsyn command
%[Gamma,acp,bcp,ccp,dcp,acl,bcl,ccl,dcl]=...
  %hinfopt(A,B1,B2,C1,C2,D11,D12,D21,D22);
[K,CL,Gamma]=hinfsyn(P,2,3);
[acp,bcp,ccp,dcp]=ssdata(K);
[acl,bcl,ccl,dcl]=ssdata(CL);


%% By students, compute Tzw using lft command

%controller

[acp,bcp,ccp,dcp]=minreal(acp,bcp,ccp,dcp);

% open loop
[aly,bly,cly,dly]=series(acp,bcp,ccp,dcp,Ag,Bg,Cg,Dg);
[aly,bly,cly,dly]=minreal(aly,bly,cly,dly);
[alu,blu,clu,dlu]=series(Ag,Bg,Cg,Dg,acp,bcp,ccp,dcp);
[alu,blu,clu,dlu]=minreal(alu,blu,clu,dlu);
%closed loop
[at,bt,ct,dt]=cloop(aly,bly,cly,dly,-1);
[at,bt,ct,dt]=minreal(at,bt,ct,dt);
as=at;
bs=bt;
cs=-ct;
ds=eye(2)-dt;
[atu,btu,ctu,dtu]=cloop(alu,blu,clu,dlu,-1);
[atu,btu,ctu,dtu]=minreal(atu,btu,ctu,dtu);
asu=atu;
bsu=btu;
csu=-ctu;
dsu=eye(3)-dtu;

[ay,by,cy,dy]=series(as,bs,cs,ds,acp,bcp,ccp,dcp);
[ay,by,cy,dy]=minreal(ay,by,cy,dy);

figure(1);
sigma(aly,bly,cly,dly)
hold on
sigma(Gamma.*inv(Wdtf(2,2)),w)
hold on
sigma(Gamma.*Wptf(1,1),w)
legend('Ly sigular values','1/Wd','Wp')


figure(2)
sigma(at,bt,ct,dt,w)
hold on
sigma(as,bs,cs,ds,w)
hold on
sigma(asu,bsu,csu,dsu,w)
hold on
sigma(Gamma.*inv(Wdtf(2,2)),w)
hold on
sigma(Gamma.*inv(Wptf(1,1)),w)
legend('T','S','Su','1/Wd','1/Wp')
hold off


figure(3)
sigma(ay,by,cy,dy,w)
legend('Youla singular values')

%closed loop time response
t=0:0.01:10;
figure(4)
step(at,bt,ct,dt,1,t)
legend('step responses to the first input')
figure(5)
step(at,bt,ct,dt,2,t)
legend('step responses to the second input')


figure(6)
sigma(Gtf)
legend('Plant singular values')

figure(7)
sigma(K)
legend('Controller singular values')

figure (8)
%% By students, compute the maximum sigular value of Tzw from lft computation
Tzw=lft(P,K);
Kinf=norm(Tzw,inf);
Kinflog=20*log10(Kinf);
Kinflog=Kinflog*ones(size(w));
sigma(Tzw)
hold on
semilogx(w,Kinflog)
hold on
sigma(acl,bcl,ccl,dcl)
legend('Inf norm of Tzw')



