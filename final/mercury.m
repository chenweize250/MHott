function mercury()

a = 57909050000; %semi-major axis (m)
e = 0.205630; %eccentricity
msun = 1.9885e30; %sun mass (kg)
G = 6.67408e-11;

t = 0:60*60*24:60*60*24*88;

%mean anomaly as function of time (s)
M = @(t) t.*(msun.*G./a.^3)^(1/2);

%eccentric anomaly (Newton-Raphson method)
EA = @(E) E-e.*sin(E)-M(t);
EAprime = @(E) 1-e.*cos(E);
E = NRmethod(EA, EAprime, M(t), 1e-16);

%true anomaly
sintheta = @(E) ((1-e^2)^(1/2).*sin(E))./(1-e.*cos(E));
costheta = @(E) (cos(E)-e)./(1-e.*cos(E));

%cartesian coordinates
r = @(costheta) a*(1-e^2)./(1+e.*costheta);
x = @(r, costheta) r(costheta(E)).*costheta(E);
y = @(r, sintheta) r(costheta(E)).*sintheta(E);

x1 = x(r, costheta);
y1 = y(r, sintheta);

%plot(t, x1, t, y1)
%plot(x1, y1)
%hold on

plot(0, 0, 'y*')
axis([-8e10,6e10,-6e10,6e10])
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