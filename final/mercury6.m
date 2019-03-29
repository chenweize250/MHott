function mercury6()
%correct perihelion precession due to Newtonian effects of outer planets
a = 57909050000; %semi-major axis (m)
e = 0.205630; %eccentricity
%msun = 1.988482635e30; %sun mass (kg)
msun = 1.9885e30;
%radii are currently semi-major axis
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

mmercury = 3.3011e23;

RP = [Rvenus, Rearth, Rmars, Rjupiter, Rsaturn, Ruranus, Rneptune];
MP = [mvenus, mearth, mmars, mjupiter, msaturn, muranus, mneptune];

%theta = linspace(0, (2*pi), 100); 
theta1 = linspace(0, (2*pi)*(365.25*100/87.969),365.25*100/87.969);

r = @(theta) a.*(1-e.^2)./(1+e.*cos(theta));

g = @(r, RP, MP) -MP.*r.^3./(2.*msun.*RP.*(RP.^2-r.^2));

%int = @(theta, i) g(r(theta), RP(i), MP(i)).*cos(theta);

deltapsi = 0;
for i = 1:7
    int = @(theta) g(r(theta), RP(i), MP(i)).*cos(theta);
    deltapsi = deltapsi + (1/e)*integral(int, 0, 2*pi)
end
deltapsi*(365.25*100/87.969)*360*3600/(2*pi)
%detlaphi = (1/e)*integral(int, 0, 2*pi)

x = @(r, theta) r.*((2*pi+deltapsi)./(2*pi)).*cos(theta);
y = @(r, theta) r.*((2*pi+deltapsi)./(2*pi)).*sin(theta);

plot(0, 0, 'y*')
hold on
axis([-8e10,6e10,-6e10,6e10])
%axis([4.598e10,4.602e10,0e10,1.3e9])
set(gcf, 'position', [0, 0, 1000, 1000])
set(gca, 'Color', 'k')
i = animatedline('Color', 'r', 'marker', '.', 'Linewidth', 1);
for k = 1:length(theta1)
    addpoints(i, x(r(theta1(k)), theta1(k)), y(r(theta1(k)), theta1(k)));
    drawnow
end

end