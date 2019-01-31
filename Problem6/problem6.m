V = input('What is the initial speed? ', 's');
V = string(V);
newV = split(V);
v = double(newV(1));
unitv = newV(2);

theta = input('What is the launch angle? ');
%theta = input('What is the launch angle?', 's');
%theta = string(theta);
%newtheta = split(theta);
%theta = double(newtheta(1));
%unittheta = newtheta(2);

switch unitv
    case "mph"
        v = v/2.237;
    case "m/s"
        v = v;
    otherwise
        error('Invalid input. Use units of "m/s" or "mph"')
end

if theta < 90 & theta > 0
    
else
    error("Input an angle between 0 and 90 degrees")
end

vx = v*cosd(theta);
vy = v*sind(theta);
g = 9.81;

t = 2*vy/g;
range = vx*t;

t = round(t, 2);

switch unitv
    case "mph"
        range = range*3.281;
        range = round(range, 2);
        formatSpec = "The flight time of the projectile is %d seconds and the range is %d feet";
        sprintf(formatSpec, t, range)
    case "m/s"
        range = round(range, 2);
        formatSpec = "The flight time of the projectile is %d seconds and the range is %d meters";
        sprintf(formatSpec, t, range)
end