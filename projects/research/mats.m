clearvars; close all; clc

s = tf('s')
sys_u2 = (0.5/((s-0.2)*(s-0.2)));
sys_u = (0.1/((s-0.5+3j)*(s-0.5-3j)));
sys_s = (1/((s+0.3+1*j)*(s+0.3-1*j)));
sys_s2 = (1.2/((s+1)*(s+1)));
sys_m = (0.05/((s)*(s)));
t = linspace(0,12,100)

[y_unstable2,t_u2] = impulse(sys_u2,t);
[y_unstable,t_u] = impulse(sys_u,t);

[y_stable,t_s] = impulse(sys_s,t);
[y_stable2,t_s2] = impulse(sys_s2,t);

figure
hold on
box on

plot(t, zeros(length(t),1), 'LineWidth',3, 'Color','k')
plot([0,0], [-1,1], 'LineWidth',3, 'Color','k')

plot(t, y_stable2, 'LineWidth',9, 'Color', [(1/255) (133/255) (113/255)])
plot(t, y_stable, '-.', 'LineWidth', 9, 'Color', [(128/255) (205/255) (193/255)])
%plot(t_m, y_marginal, 'LineWidth', 6, 'Color', [(129/255) (160/255) (24/255)])
ylim([-0.5 1])
xlim([-0.5 12])
xticklabels([])
yticklabels([])
set(gca(), 'YColor', [1 1 1])

set(gca(), 'YColor', [1 1 1])
set(gca,'TickLength',[0, 0])



yyaxis right
plot(t, y_unstable, '-.', 'LineWidth', 9, 'Color', [(223/255) (194/255) (125/255)])
plot(t, y_unstable2, '-', 'LineWidth', 9, 'Color', [(166/255) (97/255) (26/255)])
ylim([-5 10])
xlim([-0.5 12])
xticklabels([])
yticklabels([])
yticks([])
set(gca(), 'YColor', [1 1 1])
set(gca(), 'XColor', [1 1 1])
set(gca,'TickLength',[0, 0])
box off

x0=10;
y0=10;
width=1600;
height=400;
set(gcf,'position',[x0,y0,width,height])