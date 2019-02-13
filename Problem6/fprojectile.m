function [r,T] = fprojectile(v, theta, vunit)
%FPROJECTILE takes the initial velocity, launch angle, and units of the
%initial velocity (either "m/s" or "mph") and returns the range in units of 
%meters or feet and flight time in units of seconds
%{
try
    switch vunit
        case "m/s"
        
        case "mph"
            v = v/2.237;
    end
catch ME
    if vunit == "ms"
        vunit = "m/s";
    else 
        error('Invalid input. Use units of "m/s" or "mph" for speed.') 
    end
end
%}
try
    switch vunit
        case "m/s"
        
        case "mph"
            v = v/2.237;
        otherwise
            error('Invalid input. Use units of "m/s" or "mph" for speed.')
    end
catch 
    if vunit == "ms"
        vunit = "m/s";
    else
        error('Invalid input. Use units of "m/s" or "mph" for speed.') 
    end
end  

if theta < 0 | theta > 90
    error("Invalid input. Input an angle between 0 and 90 degrees.")
end 

if v < 0
    error("Invalid input. Input a positive initial speed.")
end

vx = v*cosd(theta);
vy = v*sind(theta);
g = 9.81;

T = 2*vy/g;
r = vx*T;

figure
t = 0:0.1:T;
i = animatedline('Color', 'b', 'Linewidth', 3);
title("Trajectory")

switch vunit
    case "m/s"
        h = @(t) vy.*t-.5.*g.*t.^2;
        x = @(t) vx.*t;
        ymax = vy*(T/2)-.5*g*(T/2)^2;
        
        axis([0, r, 0, ymax+2])
        xlabel("Range (m)")
        ylabel("Height (m)")
        for k=1:length(t)
            addpoints(i, x(t(k)), h(t(k)));
            drawnow
           
        end
    case "mph"
        r = r*3.281;
        h = @(t) (vy.*t-.5.*g.*t.^2)*3.281;
        x = @(t) (vx.*t)*3.281;
        ymax = (vy*(T/2)-.5*g*(T/2)^2)*3.281;
        
        axis([0, r, 0, ymax+2])
        xlabel("Range (ft)")
        ylabel("Height (ft)")
        for k=1:length(t)
            addpoints(i, x(t(k)), h(t(k)));
            drawnow
        end 
end

T=round(T, 2);
r=round(r, 2);
end