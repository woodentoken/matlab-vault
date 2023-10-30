m1 = 2;
m2 = 1;
k1 = 100;
c = 20;
k2 = 10;

A = [[0 1 0 0]; [-(k1+k2)/m1 -c/m1 k2/m1 c/m1]; [0 0 0 1]; [k2/m2 c/m2 -k2/m2 -c/m2]];
B = [[0];[k1/m1];[0];[0]];
C = eye(4);
D = zeros(4,1);

sys = ss(A,B,C,D);
impulse(sys)

ss2tf(sys)