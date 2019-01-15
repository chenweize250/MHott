T = input('How long in hours does it take the satellite to orbit Earth? ');
T1 = T; %used for plot at end

%change T to seconds
T = T*3600;

%constants
G = 6.67*10^(-11);
M = 5.98*10^(24);
R = 6.371*10^(6);

h = (G*M*T^2/(4*pi^2))^(1/3)-R;

if h>=0
    %change h to kilometers
    h = h/1000;
    h = round(h);
    h1 = h; %used for plot at end

    %output
    formatSpec = "The satellite orbits at a height of %d km from Earth's surface";
    sprintf(formatSpec, h)

    %plot
    T = 0:648000;
    x = T/3600;
    h = (G*M*T.^2/(4*pi.^2)).^(1/3)-R;
    y1 = h/1000;

    plot(x, y1, 'b')
    hold on

    y2 = zeros(1, 648001);
    plot(x, y2, 'g')

    title('Period vs Height Above Earth')
    xlabel('Period (hours)')
    ylabel('Height (km)')

    %point of intersection
    plot(1.405, 0, '*r')

    %point of height from input period
    plot(T1, h1, 'pk', 'MarkerSize', 12)

else
    %output
    formatSpec = "The period of the satellite is too low";
    sprintf(formatSpec)
end