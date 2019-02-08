import matplotlib.pyplot as plt
import numpy as np
import math as mh

T = input('How long does it take the satellite to orbit Earth? ')

T, u = T.split(" ")
T=float(T)

if u == "hr" or u == "hour":
    T1 = T
    T = T*3600
elif u == "min" or u =="minutes":
    T1 = T/60
    T = T*60
elif u == "sec" or u == "seconds":
    T1 = T/3600
    T = T
else:
    print("Invalid input")

#constants
G = 6.67*10**(-11)
M = 5.98*10**(24)
R = 6.371*10**(6)

#equations
heightm = lambda x: ((G*M*x**2)/(4*mh.pi**2))**(1/3)-R
heightkm = lambda x: (((G*M*x**2)/(4*mh.pi**2))**(1/3)-R)/1000
velocitykms = lambda x: ((G*M/(x+R))**(1/2))/1000

#outputs
h = heightkm(T)
h1 = h
v = velocitykms(heightm(T))
v1 = v
v = round(v)
h = round(h)

print("The satellite orbits at a height of", h, "km from Earth's surface with a speed of", v, "km/s")

#plot
x0 = 0
y0 = 0
width = 1000
height = 1000
    
#plot h vs T
T = np.array(range(0,648000))
x1 = lambda x: x/3600

plt.subplot(211)
plt.plot(x1(T), heightkm(T), 'b')

#point of intersection
#plt.plot(1.405, 0, '*r')

#point of height from input period
plt.plot(T1, h1, 'pk')

#plot v vs h
h = np.array(range(20000000))
x2 = lambda x: x/1000

plt.subplot(212)
plt.plot(x2(h), velocitykms(h), 'b')

#plot formatting
plt.subplots_adjust(hspace=0.8)
plt.subplot(211)
plt.title('Height vs Period')
plt.xlabel('Period (hours)')
plt.ylabel('Height (km)')
plt.subplot(212)
plt.title('Velocity vs Height')
plt.xlabel('Height (km)')
plt.ylabel('Velocity (km/s)')
plt.show()