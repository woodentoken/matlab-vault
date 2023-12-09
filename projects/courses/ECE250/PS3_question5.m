%% 5a)

% verify the equivalency of the transfer functions for question 3
% Verify the derived transfer function is equivalent to the one found using
% Mason's Rule.

A_3 = [[0 0 0]; [0 -1 4]; [0 2 0]];
B_3 = [1 1 0]';
C_3 = [1 1 4];
D_3 = [1];

sys_3 = ss(A_3, B_3, C_3, D_3);
[num_3, den_3] = ss2tf(A_3,B_3,C_3,D_3)

% this matches the TF derived in question 3!


%% 5b) part 1

% verify the equivalency of the transfer functions for the block diagram
% question.
% In the first case, using all 5 states

A_4a = [[-1 0 0 0 0];[1 -2 0 0 0];[0 1 -1 0 0];[0 0 0 -1 0];[0 0 0 1 -3];];
B_4a = [1 1 1 1 0]';
C_4a = [[0 1 2 0 3];[0 4 3 0 2]];
D_4a = [0 0]';

% construct a state space system for 4a
sys_4a = ss(A_4a, B_4a, C_4a, D_4a);
[num_4a, den_4a] = ss2tf(A_4a, B_4a, C_4a, D_4a);
zpk(sys_4a)
% this zpk form shows a (s + 1) zero and a (s + 1)^3 pole term
% these would be simplified via pole zero cancellation

%% 5b) part 2

% In the second case, avoiding the use of state x_4.
% check the agreement between the "full" state space and the one that omits
% x_4

A_4b = [[-1 0 0 0];[1 -2 0 0];[0 1 -1 0];[1 0 0 -3];];
B_4b = [1 1 1 0]';
C_4b = [[0 1 2 3];[0 4 3 2]];
D_4b = [0 0]';

% construct a state space system for 4b
sys_4b = ss(A_4b, B_4b, C_4b, D_4b);
[num_4b, den_4b] = ss2tf(A_4b, B_4b, C_4b, D_4b);
zpk(sys_4b)

% this zpk form shows a (s + 1)^2 pole term
% this is therefore equivalent to the simplified zpk of part 4a.

% Note that all other zeros and poles are the same.

% Unfortunately, MATLAB doesn't print the factorizations in the same order,
% but all the terms are the same, just differently ordered.