

import matplotlib.pyplot as plt
import numpy as np
import math as mh

T = input('How long in hours does it take the satellite to orbit Earth? ')
T=float(T)
T1 = T

"change T to seconds"
T = T*3600

"constants"
G = 6.67*10**(-11)
M = 5.98*10**(24)
R = 6.371*10**(6)

h = (G*M*T**2/(4*mh.pi**2))**(1/3)-R
v = (G*M/(h+R))**(1/2)

"change h to kilometers"
h = h/1000
h1 = h
h = round(h)
v = v/1000
v1 = v
v = round(v)

print("The satellite orbits at a height of", h, "km from Earth's surface with a speed of", v, "km/s")

"plot"
x0 = 0
y0 = 0
width = 1000
height = 1000
    
"plot h vs T"
T = np.array(range(0,648000))
x1 = T/3600
p2 = [2]*648000
T2 = np.power(T, p2)
H = (G*M*T2)
H1 = np.dot(H,1/(4*mh.pi**2))
p13 = [(1/3)]*648000
H2= H1**p13
h = H2-R
y1 = np.dot(h, 1/1000)

plt.subplot(211)
plt.plot(x1, y1, 'b')


y2 = [0]*648000
plt.plot(x1, y2, 'g')

"point of intersection"
plt.plot(1.405, 0, '*r')

"point of height from input period"
plt.plot(T1, h1, 'pk')

"plot h vs T"
h = np.array(range(5000000))
x2 = h/1000
p12 = [(1/2)]*5000000

H3 = h + R
v1 = (G*M/(H3))
v2 = np.power(v1, p12)
y3 = v2/1000
plt.subplot(212)
plt.plot(x2, y3, 'b')

plt.subplots_adjust(hspace=0.8)
plt.subplot(211)
plt.title('Height vs Period')
plt.xlabel('Period (hours)')
plt.ylabel('Height (km)')
plt.subplot(212)
plt.title('Velocity vs Height')
plt.xlabel('Height (km)')
plt.ylabel('Velocity (km/s)')