%{
a = 57909050000; %semi-major axis of mercury (m)
e = 0.205630; %eccentricity of merciry's orbit

theta = linspace(0, (2*pi)*(365.25/87.969)*0.25,24*(2*pi)*(365.25/87.969)*0.24); %models one orbit
r = @(theta) a.*(1-e.^2)./(1+e.*cos(theta));
%converts polar coords to cartesian

x = @(r, theta) r.*cos(theta);
y = @(r, theta) r.*sin(theta);
%{
ax1 = [0, 46001200000];
ay1 = [0, 0];
ax2 = [0, -1.813e10];
ay2 = [0, 5.634e10];
%}


plot(0,0,'y*')
hold on
set(gca, 'Color', 'k')
axis([-8e10,8e10,-8e10,8e10], 'square')
%plot(ax1, ay1, 'w', 'Linewidth', 2)
%plot(ax2, ay2, 'w', 'Linewidth', 2)
plot(0,0,'y.', 'MarkerSize', 35)
p1 = plot(x(r(theta), theta), y(r(theta), theta), 'Color', 'r', 'Linewidth', 1, "DisplayName", "None");
%plot(-1.813e10, 5.634e10, 'Color', [.5,.5,.5], 'marker', '.', 'MarkerSize', 28)


g = @(r, RP, MP) -MP.*r.^3./(2.*msun.*RP.*(RP.^2-r.^2));

deltapsiP = 0;
for i = 1:7
    int = @(theta) g(r(theta), RP(i), MP(i)).*cos(theta);
    deltapsiP = deltapsiP + (1/e)*integral(int, 0, 2*pi);
end

g = @(r) 3*G*msun*a*(1-e^2)./(c^2.*r.^2);

int = @(theta) g(r(theta)).*cos(theta);
deltapsiGR = (1/e)*integral(int, 0, 2*pi);
amp = 10000;
x = @(r, theta, deltapsi) r.*cos(theta+amp*theta*deltapsi);
y = @(r, theta, deltapsi) r.*sin(theta+amp*theta*deltapsi);
p2 = plot(x(r(theta), theta, deltapsiP), y(r(theta), theta, deltapsiP), 'Color', 'y', 'Linewidth', 1, "DisplayName", "Planets");
p3 = plot(x(r(theta), theta, deltapsiP+deltapsiGR), y(r(theta), theta, deltapsiP+deltapsiGR), 'Color', 'c', 'Linewidth', 1, "DisplayName", "Planets and GR");
lgd = legend([p1, p2, p3],'TextColor', 'w');
legend('boxoff')
title(lgd, 'Effect from:')
%}


a = 10;
e = .5;

ax = [-15, 5];
ay = [0, 0];

bx = [-5, -5];
by = [-8.66, 8.66];




r = @(theta) a.*(1-e.^2)./(1+e.*cos(theta));
theta = 0:.01:2*pi;
x = @(r, theta) r.*cos(theta);
y = @(r, theta) r.*sin(theta);
plot(x(r(theta), theta), y(r(theta), theta), 'Color', 'r', 'Linewidth', 1)
axis([-20, 10, -10, 10])
set(gca, 'Color', 'k')
hold on
plot(ax, ay, 'Color', 'w', 'Linewidth', 1)
plot(bx, by, 'Color', 'w', 'Linewidth', 1)
plot(0, 0,'y.', 'MarkerSize', 25)
plot(5, 0, '.', 'Color', [.5,.5,.5], 'MarkerSize', 16)
plot(-15, 0, '.','Color', [.5,.5,.5], 'MarkerSize', 16)


%{
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

plot(x1, y1, 'Color', 'r', 'Linewidth', 1)
axis([-20, 10, -15, 10])
set(gca, 'Color', 'k')
hold on
%plot(ax, ay, 'Color', 'k', 'Linewidth', 1)
plot(ax1, ay1, 'Color', 'w', 'Linewidth', 1)
plot(ax2, ay2, 'Color', 'w', 'Linewidth', 1)
plot(ax3, ay3, 'Color', 'w', 'Linewidth', 1)
%plot(t, s(t), 'Color', 'k', 'Linewidth', 1)
plot(0, 0,'y.', 'MarkerSize', 25)
plot(x1(9), y1(9), '.', 'Color', [.5,.5,.5], 'MarkerSize', 16)
plot(x1(305), y1(305), '.', 'Color', [.5,.5,.5], 'MarkerSize', 16)
plot(x1(648), y1(648), '.', 'Color', [.5,.5,.5], 'MarkerSize', 16)
plot(x1(944), y1(944), '.', 'Color', [.5,.5,.5], 'MarkerSize', 16)
plot(x1(1287), y1(1287), '.', 'Color', [.5,.5,.5], 'MarkerSize', 16)
plot(x1(1583), y1(1583), '.', 'Color', [.5,.5,.5], 'MarkerSize', 16)
%}


