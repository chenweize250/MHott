function mercury7()
%correct perihelion precession for GR
a = 57909050000; %semi-major axis (m)
e = 0.205630; %eccentricity
%msun = 1.988482635e30; %sun mass (kg)
msun = 1.9885e30;
G = 6.67408e-11;
c = 299792458; %speed of light (m/s)

r = @(theta) a.*(1-e.^2)./(1+e.*cos(theta));

g = @(r) 3*G*msun*a*(1-e^2)./(c^2.*r.^2);

%int = @(theta, i) g(r(theta), RP(i), MP(i)).*cos(theta);

int = @(theta) g(r(theta)).*cos(theta);
deltapsi = (1/e)*integral(int, 0, 2*pi)

deltapsi*(365.25*100/87.969)*360*3600/(2*pi)


end

