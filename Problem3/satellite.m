T = input('How long in hours does it take the satellite to orbit Earth? ');
T1 = T; %used for plot at end

%change T to seconds
T = T*3600;

%constants
G = 6.67*10^(-11);
M = 5.98*10^(24);
R = 6.371*10^(6);

h = (G*M*T^2/(4*pi^2))^(1/3)-R;
v = (G*M/(h+R))^(1/2);

if h>=0
    %change h to kilometers
    h = h/1000;
    h1 = h; %used for plot at end
    h = round(h);

    %change v to km/h
    v = v/1000;
    v1 = v; %used for plot at end
    v = round(v);
    
    %output
    formatSpec = "The satellite orbits at a height of %d km from Earth's surface with a speed of %d km/s";
    sprintf(formatSpec, h, v)

    %plot
    x0 = 0;
    y0 = 0;
    width = 1000;
    height = 1000;
    set(gcf, 'position', [x0, y0, width, height])
    
    ax1 = subplot(2,1,1);
    ax2 = subplot(2,1,2);
 
    %plot h vs T
    T = 0:648000;
    x1 = T/3600;
    h = (G*M*T.^2/(4*pi.^2)).^(1/3)-R;
    y1 = h/1000;

    plot(ax1, x1, y1, 'b')
    hold (ax1, 'on')

    y2 = zeros(1, 648001);
    plot(ax1, x1, y2, 'g')

    %point of intersection
    plot(ax1, 1.405, 0, '*r')

    %point of height from input period
    plot(ax1, T1, h1, 'pk', 'MarkerSize', 12)
    
    %plot h vs T
    h = 0:50000000;
    x2 = h/1000;
    v = (G*M./(h+R)).^(1/2);
    y3 = v/1000;
    plot(ax2, x2, y3, 'b')
    
    %point of velocity from calculated height from input period
    hold (ax2, 'on')
    plot(ax2, h1, v1, 'pk', 'MarkerSize', 12)
    
    title(ax1, 'Height vs Period')
    xlabel(ax1, 'Period (hours)')
    ylabel(ax1, 'Height (km)')
    
    title(ax2, 'Velocity vs Height')
    xlabel(ax2, 'Height (km)')
    ylabel(ax2, 'Velocity (km/s)')
    
else
    %output
    formatSpec = "The period of the satellite is too low";
    sprintf(formatSpec)
end