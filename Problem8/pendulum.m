function [period,sol] = pendulum(L,theta0,thetad0) %length/radius, initial angle, initial angular velocity
% Finds the period of a nonlinear pendulum given the length of the pendulum
% arm and initial conditions. All angles in radians.

%Setting initial conditions
if nargin==0
    error('Must input length and initial conditions')
end
if nargin==1
   theta0 = pi/2;
   thetad0=0;
end
if nargin==2
    thetad0 = 0;
end

y0 = [theta0; thetad0];
g = 9.81;
N = 10;
T = 2*pi*sqrt(L/g);
tspan = [0, N*T];
[t,w] = ode45(@pend, tspan, y0);

theta = @(t) theta0*cos(sqrt(g/L)*t);
figure()
plot(t, w(:, 1), t, theta(t))
figure()
plot(t, w(:, 1) - theta(t))

%first derivative w(:, 2)
%period = w(w(:, 2)==0, 2) doesn't work bc graph is made of tiny points
%that are close but not equal to 0
%but will change sign twice over one period: multiply solution by itself
%and see where the sign is negative: negative sign means the axis is
%crossed

ind = find(w(:, 2).*circshift(w(:, 2), -1) <= 0); %shifts array by -1
%remove ends of array to remove false positives
ind = chop(ind, 4);
period = 2*mean(diff(t(ind)));

    function ydot = pend(t, y)
        ydot = [y(2); -g/L*sin(y(1))]; %-4*y(1).^3 (force) can replace -g/L*sin(y(1)) (potential) because origianl potential function is x^4
    end

end

%force is derivative of potential
