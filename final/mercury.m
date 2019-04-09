function mercury(varargin)
%Models the orbit of Mercury. Optional inputs: time in centuries and 
%amplification of precession. Defaults are 1 century and 10000x
%amplification. Returns the orbital precession in arcseconds for the
%specified number of centuries.
a = 57909050000; %semi-major axis (m)
e = 0.205630; %eccentricity
msun = 1.9885e30; %sun mass (kg)
mvenus = 4.867e24; %venus mass (kg)
Rvenus = 108208000000; %venus radius (m)
mearth = 5.976e24; %earth mass (kg)
Rearth = 149598023000; %earth radius (m)
mmars = 6.421e23; %mars mass (kg)
Rmars = 227939200000; %mars radius (m)
mjupiter = 1.899e27; %jupiter mass (kg)
Rjupiter = 778.57e9; %jupiter radius (m)
msaturn = 5.686e26; %saturn mass (kg)
Rsaturn = 1433.53e9; %saturn radius (m)
muranus = 8.681e25; %uranus mass (kg)
Ruranus = 2.87503e12; %uranus radius (m)
mneptune = 1.02413e26; %neptune mass (kg)
Rneptune = 4.504e12; %neptune radius (m)
G = 6.67408e-11;
c = 299792458; %speed of light (m/s)

RP = [Rvenus, Rearth, Rmars, Rjupiter, Rsaturn, Ruranus, Rneptune];
MP = [mvenus, mearth, mmars, mjupiter, msaturn, muranus, mneptune];

switch nargin
    case 0
        cent = 1;
        amp = 10000;
    case 1
        cent = cell2mat(varargin(1));
        amp = 10000;
    case 2
        cent = cell2mat(varargin(1));
        amp = cell2mat(varargin(2));
    otherwise
        error('Maximum number of inputs is 2')
end

theta = linspace(0, (2*pi)*(365.25*100*cent/87.969),24*(2*pi)*(365.25*100*cent/87.969));

r = @(theta) a.*(1-e.^2)./(1+e.*cos(theta));

g = @(r, RP, MP) -MP.*r.^3./(2.*msun.*RP.*(RP.^2-r.^2));

%planets
deltapsiP = 0;
for i = 1:7
    int = @(theta) g(r(theta), RP(i), MP(i)).*cos(theta);
    deltapsiP = deltapsiP + (1/e)*integral(int, 0, 2*pi);
end
fprintf("Orbital precession due to planets: %f arcseconds per orbit; %f arcseconds per century \n\n", deltapsiP*(360*3600/(2*pi)), deltapsiP*(365.25*100/87.969)*360*3600/(2*pi))

%GR
g = @(r) 3*G*msun*a*(1-e^2)./(c^2.*r.^2);
int = @(theta) g(r(theta)).*cos(theta);
deltapsiGR = (1/e)*integral(int, 0, 2*pi);
fprintf("Orbital precession due to general relativity: %f arcseconds per orbit; %f arcseconds per century \n\n", deltapsiGR*(360*3600/(2*pi)), deltapsiGR*(365.25*100/87.969)*360*3600/(2*pi))

%total
deltapsi = deltapsiP+deltapsiGR;
fprintf("Total orbital precession per century: %f arcseconds \n\n", deltapsi*(365.25*100/87.969)*360*3600/(2*pi))

fprintf("Orbital precession for %f centuries: %f arcseconds \n\n", cent, cent*deltapsi*(365.25*100/87.969)*360*3600/(2*pi));

x = @(r, theta, deltapsi) r.*cos(theta+amp*theta*deltapsi);
y = @(r, theta, deltapsi) r.*sin(theta+amp*theta*deltapsi);

f = figure;
tabgp = uitabgroup(f);
set(f, 'Position',[0, 0, 1000, 1000])
tab1 = uitab(tabgp,'Title','None');
tab2 = uitab(tabgp,'Title','Planets');
tab3 = uitab(tabgp,'Title','Planets & GR');
tab4 = uitab(tabgp,'Title','All');

tab1ax = axes('parent', tab1);
hold(tab1ax, 'on')
tab2ax = axes('parent', tab2);
hold(tab2ax, 'on')
tab3ax = axes('parent', tab3);
hold(tab3ax, 'on')
tab4ax = axes('parent', tab4);
hold(tab4ax, 'on')

axis(tab1ax, [-8e10,8e10,-8e10,8e10], 'square')
axis(tab2ax, [-8e10,8e10,-8e10,8e10], 'square')
axis(tab3ax, [-8e10,8e10,-8e10,8e10], 'square')
axis(tab4ax, [-8e10,8e10,-8e10,8e10], 'square')

plot(tab1ax, 0, 0, 'y*')
plot(tab2ax, 0, 0, 'y*')
plot(tab3ax, 0, 0, 'y*')
plot(tab4ax, 0, 0, 'y*')

set(tab1ax, 'Color', 'k')
set(tab2ax, 'Color', 'k')
set(tab3ax, 'Color', 'k')
set(tab4ax, 'Color', 'k')

i1 = animatedline(tab4ax, 'Color', 'r', 'marker', '.', 'Linewidth', 1, 'DisplayName', 'None');
i2 = animatedline(tab4ax, 'Color', 'y', 'marker', '.', 'Linewidth', 1, 'DisplayName', 'Planets');
i3 = animatedline(tab4ax, 'Color', 'c', 'marker', '.', 'Linewidth', 1, 'DisplayName', 'Planets & GR');
i4 = animatedline(tab1ax, 'Color', 'r', 'marker', '.', 'Linewidth', 1);
i5 = animatedline(tab2ax, 'Color', 'y', 'marker', '.', 'Linewidth', 1);
i6 = animatedline(tab3ax, 'Color', 'c', 'marker', '.', 'Linewidth', 1);

lgd = legend(tab4ax, [i1,i2,i3], 'TextColor', 'w');
legend(tab4ax, 'boxoff')
title(lgd, 'Effect from:')

for k = 1:length(theta)
    %tab 1
    addpoints(i4, x(r(theta(k)), theta(k), 0), y(r(theta(k)), theta(k), 0));
    %tab 2
    addpoints(i5, x(r(theta(k)), theta(k), deltapsiP), y(r(theta(k)), theta(k), deltapsiP));
    %tab 3
    addpoints(i6, x(r(theta(k)), theta(k), deltapsi), y(r(theta(k)), theta(k), deltapsi));
    %tab 4
    addpoints(i1, x(r(theta(k)), theta(k), 0), y(r(theta(k)), theta(k), 0));
    addpoints(i2, x(r(theta(k)), theta(k), deltapsiP), y(r(theta(k)), theta(k), deltapsiP));
    addpoints(i3, x(r(theta(k)), theta(k), deltapsi), y(r(theta(k)), theta(k), deltapsi));
    drawnow
end
end