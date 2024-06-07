%% Question 1
A = [[0 -1 1];[1 -1 1];[-1 1 -1]];
B = [[0 0];[1 1];[0 -1]];
C = [[0 1 0];[-1 0 0]]; % already transposed
D = [[0 0];[0 0]];

syms s
G1 = C*inv(s*eye(3)-A)*B + D;
pretty(simplify(G1))

%% Question 2
G2 = tf([1, 3], [1, 7, 10]);
[A,B,C,D] = tf2ss([1,3], [1,7,10]);
[z, nrank] = tzero(G2)

%% Question 3
syms s
a = 1/(s+1);
b = 1/((s+1)*(s+2));
c = s/((s+1)*(s+2));
d = 2*s+1/((s+1)*(s+2));
G3 = [[a b];[c d]];

%% Question 4
syms s
N = [[s+1 1];[1 1]];
D = [[s*(s+3) 0];[0 s*(s+3)]];
W = [[1 1];[s 0]];

% if this is equivalent to G(s), then W is a right common factor
pretty(simplify(N*W*inv(D*W)))

%% Question 5 - this is actually from HW2...
syms s
NR = [[(s+2) (s+2)];[(s+1) (s+1)*(s+3)]];
DR = [[(s+1)^2*(s+2) 0];[0 (s+1)*(s+2)^2]];
M = [DR;NR];
UL = [[1 1 -s*(s+2) -1];[1 1 -(s+1)^2 0];[(s+2) (s+1) -(s+1)^2-(s+1)^3 0];[-(s+2) -(s+2) (s+1)^2 - (s+1-(s+1)^3) (s+2)]];
pretty(simplify(UL*M))

