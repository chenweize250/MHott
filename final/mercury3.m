function mercury3()

a = 57909050000; %semi-major axis (m)
e = 0.205630; %eccentricity
msun = 1.988482635e30; %sun mass (kg)
%msun = 1.9891e30;
%msun = 1.9885e30;
%radii are currently semi-major axis
mvenus = 4.8675e24; %venus mass (kg)
Rvenus = 108208000000; %venus radius (m)
mearth = 5.97237e24; %earth mass (kg)
Rearth = 149598023000; %earth radius (m)
mmars = 6.4171e23; %mars mass (kg)
Rmars = 227939200000; %mars radius (m)
mjupiter = 1.8982e27; %jupiter mass (kg)
Rjupiter = 778.57e9; %jupiter radius (m)
msaturn = 5.6834e26; %saturn mass (kg)
Rsaturn = 1433.53e9; %saturn radius (m)
muranus = 8.681e25; %uranus mass (kg)
Ruranus = 2.87503e12; %uranus radius (m)
mneptune = 1.02413e26; %neptune mass (kg)
Rneptune = 4.504e12; %neptune radius (m)
G = 6.67408e-11;

mmercury = 3.3011e23;

RP = [Rvenus, Rearth, Rmars, Rjupiter, Rsaturn, Ruranus, Rneptune];
MP = [mvenus, mearth, mmars, mjupiter, msaturn, muranus, mneptune];

c = 1;
%T = 0:1:c*100;
%t = T.*60*60*24*365.25
%t = 0:60*60*24*87.969:60*60*24*365.24*100*c;
%87.96861
%t = linspace(0,60*60*24*365.24*100*c,1000);
t = 60*60*24*365.24*100*c;
p = 0;
for i = 1:7
    p = p+G*MP(i)/(2*RP(i)*(RP(i)^2-a^2));
end

n = ((G*msun/a^3)-p)^(1/2);
n
%mean anomaly as function of time (s)
M = @(t) t.*n;

%((60*60*24*87.969)*acos(cos(t*2*pi/(60*60*24*87.969)))/(2*pi))

%M = @(t) (t-mod(t,60*60*24*87.969)*60*60*24*87.969).*n^(1/2);


%eccentric anomaly (Newton-Raphson method)
EA = @(E) E-e.*sin(E)-M(t);
EAprime = @(E) 1-e.*cos(E);
E = NRmethod(EA, EAprime, M(t), 1e-20);

%true anomaly
sintheta = @(E) ((1-e^2)^(1/2).*sin(E))./(1-e.*cos(E));
costheta = @(E) (cos(E)-e)./(1-e.*cos(E));

%cartesian coordinates
r = @(costheta) a*(1-e^2)./(1+e.*costheta);
x = @(r, costheta) r(costheta(E)).*costheta(E);
y = @(r, sintheta) r(costheta(E)).*sintheta(E);

x1 = x(r, costheta);
y1 = y(r, sintheta);



tan((y1(end))/(x1(end)))/(2*pi)*360*60*60

plot(0, 0, 'y*')
axis([-8e10,6e10,-6e10,6e10])
%axis([4.598e10,4.602e10,0e10,1.3e9])
set(gcf, 'position', [0, 0, 1000, 1000])
set(gca, 'Color', 'k')
hold on
i = animatedline('Color', 'r', 'marker', '.', 'Linewidth', 1);
for k = 1:length(t)
    addpoints(i, x1(k), y1(k));
    drawnow
end

 
end

function E = NRmethod(f, fprime, E0, accuracy)
    E = E0;
    error = -1*(f(E)./fprime(E));
    while abs(error) > accuracy
        error = -1*(f(E)./fprime(E));
        E = E+error;
    end
end