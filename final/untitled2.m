a = 10;
e = .5;

ax = [-15, 5];
ay = [0, 0];

bx = [-5, -5];
by = [-8.66, 8.66];

%{
r = @(theta) a.*(1-e.^2)./(1+e.*cos(theta));
theta = 0:.01:2*pi;
x = @(r, theta) r.*cos(theta);
y = @(r, theta) r.*sin(theta);
plot(x(r(theta), theta), y(r(theta), theta), 'Color', 'k', 'Linewidth', 2)
axis([-20, 10, -10, 10])
hold on
plot(ax, ay, 'Color', 'k', 'Linewidth', 1)
plot(bx, by, 'Color', 'k', 'Linewidth', 1)
plot(0, 0,'r*', 'MarkerSize', 10)
plot(5, 0, 'r.', 'MarkerSize', 16)
plot(-15, 0, 'r.', 'MarkerSize', 16)
%}


r = @(theta) a.*(1-e.^2)./(1+e.*cos(theta));
theta = 0:.01:2*pi*3;
x = @(r, theta, deltapsi) r.*cos(theta+theta*deltapsi);
y = @(r, theta, deltapsi) r.*sin(theta+theta*deltapsi);
x1 = x(r(theta), theta, .06);
y1 = y(r(theta), theta, .06);

ax1 = [x1(9), x1(305)];
ay1 = [y1(9), y1(305)];

ax2 = [x1(648), x1(944)];
ay2 = [y1(648), y1(944)];

ax3 = [x1(1287), x1(1583)];
ay3 = [y1(1287), y1(1583)];
%s = @(t) t.*(0-y1(305))/(0-x1(305));
%t = -15:.01:10;

plot(x1, y1, 'Color', 'k', 'Linewidth', 2)
axis([-20, 10, -15, 10])
hold on
%plot(ax, ay, 'Color', 'k', 'Linewidth', 1)
plot(ax1, ay1, 'Color', 'k', 'Linewidth', 1)
plot(ax2, ay2, 'Color', 'k', 'Linewidth', 1)
plot(ax3, ay3, 'Color', 'k', 'Linewidth', 1)
%plot(t, s(t), 'Color', 'k', 'Linewidth', 1)
plot(0, 0,'r*', 'MarkerSize', 10)
plot(x1(9), y1(9), 'r.', 'MarkerSize', 16)
plot(x1(305), y1(305), 'r.', 'MarkerSize', 16)
plot(x1(648), y1(648), 'r.', 'MarkerSize', 16)
plot(x1(944), y1(944), 'r.', 'MarkerSize', 16)
plot(x1(1287), y1(1287), 'r.', 'MarkerSize', 16)
plot(x1(1583), y1(1583), 'r.', 'MarkerSize', 16)



