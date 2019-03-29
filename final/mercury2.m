function mercury2()

a = 57909050000; %semi-major axis (m)
e = 0.205630; %eccentricity
msun = 1.9885e30; %sun mass (kg)
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

%{
g = MP(1)*a^3/(2*msun*RP(1)*(RP(1)^2-a^2));
g = 1-g;
sum = 0;
for i = 1:4
    sum = sum + g*cos((i-.5)*pi*.25)
end

psi = .5*pi*sum/e
%}


p = 0;

for i = 1:7
    p = p+G*MP(i)/(2*RP(i)*(RP(i)^2-a^2));
end

%{
p = 0;
for i = 1:7
    p = p+G*MP(i)*mmercury*a/(2*RP(i)*(RP(i)^2-a^2));
    %disp(p)
end
p
%}


n = ((G*msun/a^3)-p)^(1/2);


%h = 87.9691;
c = 1;
%60*60*24*87.9691
%60*60*24*365.25*100*c
t = 0:60*60*24*87.96:60*60*24*365.24*100*c;

%mean anomaly as function of time (s)
%M = @(t) (60*24*87.969*abs(acos(cos(t)))/(2*pi)).*n;
M = @(t) t.*n;

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

xdiff = diff(x1);
ydiff = diff(y1);
disp(sum(ydiff))
disp(sum(xdiff))
l = 0;

for i = 1:length(xdiff)
    l = l + (xdiff(i)^2+ydiff(i)^2)^(1/2);
end
disp(l)

%((x1(end)-x1(1))^2+(y1(end)-y1(1))^2)^(1/2)


%disp(x1(1))
%disp(x1(end))
%disp(y1(1))
%disp(y1(end))
%plot(t, x1, t, y1)
%plot(x1, y1)
%hold on

plot(0, 0, 'y*')

axis([4.598e10,4.602e10,0e10,1e9])
%axis([-8e10,6e10,-6e10,6e10])
set(gcf, 'position', [0, 0, 1000, 1000])
set(gca, 'Color', 'k')
hold on
%{
i1 = animatedline('Color', 'r', 'marker', '.');
for k = 1:length(t(1:f/h))
    addpoints(i1, x1(k), y1(k));
end

red = 1;
blue = 0;
color = [red, 0, blue];
i2 = animatedline('Color', color, 'marker', '.');

n1 = length(t(1:f/h));
n2 = length(t)/length(t(1:f/h));
for k = n1:n2
    for i = k:k+n1
        addpoints(i2, x1(k), y1(k));
       
    end
end
%}
i = animatedline('Color', 'r', 'marker', '.');
for k = 1:length(t)
    %i.Color = color;
    addpoints(i, x1(k), y1(k));
    %red = red - 0.005;
    %blue = blue + 0.005;
    %color = [red, 0, blue];
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
