t = [0:.1:10]';
f1 = exp(-t);
f2 = t.*exp(-t);
f3 = exp(-2*t);
M = [f1 f2 f3];

plot(t, M)
grid on
legend('f1', 'f2', 'f3')

rank([f1 f2 f3])