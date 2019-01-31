#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Jan 30 23:57:26 2019

@author: meganhott
"""

import numpy as np

V = input('What is the initial speed? ')
v, unitv = V.split(" ")
v=float(v)

theta = input('What is the launch angle? ')
theta = float(theta)

if unitv == "mph":
    v = v/2.237
elif unitv == "m/s":
    v = v
else:
    print('Invalid input. Use units of "m/s" or "mph"')

if theta<90 and theta>0:
    a =1 
else:
    print("Input an angle between 0 and 90 degrees")
    
theta = np.radians(theta)
vx = v*np.cos(theta)
vy = v*np.sin(theta)
g = 9.81

t = 2*vy/g
range = vx*t

if unitv == "mph":
    range = range*3.281
    print("The flight time of the projectile is", t, "seconds and the range is", range, "feet")
else:
    print("The flight time of the projectile is", t, "seconds and the range is", range, "meters")