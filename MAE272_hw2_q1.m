%% Question 1 part d)

m = 1;
k = 1;
M = 2;
b = 1;

A = [[0 1 0 0]; [-k/m -b/m k/m b/m]; [0 0 0 1]; [k/M b/M -k/M -b/M]];
B = [0 0 0 1/M]';
C = eye(4);
D = zeros(4,1);

sys_q1 = ss(A,B,C,D);

% step response of the system (constant input u) - don't forget to model in
% simulink!
step(sys_q1)

%% Question 3
A = [[0 1]; [-2 -3]];
B = [1 1]';
C = [3 2];
D = zeros(1,1);

sys = ss(A,B,C,D);

% ideally, this goes to 4...
[y_step, t_step, x_step] = step(sys);
[y_ic, t_ic, x_ic] = initial(sys, [1 0]');

y_total = y_step + y_ic;
plot(t_step,y_total)
% initial(sys, [1 0]')

%% Questions 5?
A = [[-1 0];[0 -2]];
B = [1 1]';
C = [6 -12];
D = 1;

sys = ss(A,B,C,D);
zpk(sys)


%% Question 6

A = [[0 1 0];[0 0 1];[-2 1 2]];
C = eye(3);
sys = ss(A, [], C, []);

% this inital condition should go to zero despite the unstable modes.
initial(sys, [1 -1 2]')

%% Questions 7

A = [[0 1 0 0]; [0 0 1 0]; [0 0 0 1]; [6 -5 -5 5]];
B = [0 0 0 5]';
C = [-6 11 -6 1];
D = zeros(1,1);

% the steady state value here should be 5.
sys_q7 = ss(A,B,C,D);
grid on
step(sys_q7)
