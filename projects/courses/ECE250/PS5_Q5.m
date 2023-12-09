%% Question 5

% verify the findings of question 3
A = [[-2 -2];[1/3 -1/3]];
B = [2;0];
C = [1 0];
D = 0;

sys = ss(A,B,C,D);

% transfer function via zpk
zpk(sys)

% zeroes and poles via ss2zp
[Z,P] = ss2zp(A,B,C,D)

% pole zero map via pzmap
pzmap(sys)