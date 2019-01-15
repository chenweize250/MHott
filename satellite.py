import math as mh
T = input('How long in hours does it take the satellite to orbit Earth? ')
T=float(T)
"change T to seconds"
T = T*3600

"constants"
G = 6.67*10**(-11)
M = 5.98*10**(24)
R = 6.371*10**(6)

h = (G*M*T**2/(4*mh.pi**2))**(1/3)-R

"change h to kilometers"
h = h/1000
h = round(h)

print("The satellite orbits at a height of", h, "km from Earth's surface")