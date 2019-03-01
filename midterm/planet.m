function [pT,pg,v] = planet(M,R,SM,A, units)
%planet takes the mass of the planet, radius of the planet, ortbital
%radius, and mass of planet's star and returns the period of the planet 
%(days), the gravitational force felt on the surface of the planet (m/s^2),
%and the orbital velocity (km/s). The inputs must be in specified units of 
%"SI" or "AU".

G=6.67*10^(-11);
Msun = 1.99*10^(30); %sun's mass in kg
Mearth = 5.98*10^(24); %earth's mass in kg
aearth = 150*10^9; %earth's orbital radius in m
rearth = 6.371*10^6; %earth's radius in m

%pT = 365.25;
%pg = 9.8;
%orbvel = 29750; m/s

period = @(a, sm) (2*pi.*(a.^3./(G.*sm)).^(1/2)./(3600*24)); %days
gravity = @(m, r) G.*m./r.^2; %m/s
orbvel = @(a, sm) ((G.*sm./a).^(1/2))./1000; %km/s

if units == "AU"
    M = M*Mearth;
    R = R*rearth;
    SM = SM*Msun;
    A = A*aearth;

elseif units == "SI"
        
else
    error('Use units of "AU" or "SI"')
end

pT = period(A, SM);
pg = gravity(M, R);
v = orbvel(A, SM);
end

