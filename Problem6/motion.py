#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Feb  5 12:25:06 2019

@author: meganhott
"""

import numpy as np
import math as mh
import matplotlib.pyplot as plt
#import matplotlib.animation as animation

def projectile(v, theta, u = "m/s", h=0):
    
    #if user switches u and h in input this switches them back
    try:
        h = float(h)
    except:
        units = h
        h = u
        u = units
        
    #if user switches theta and u this switches them back
    try:
        theta = float(theta)
    except:
        units = theta
        theta = u
        u = units
        
    #unit switcher    
    if u =="m/s":
        v = v
        h = h
    elif u == "mph":
        v = v/2.237
        h = h/3.281
    elif u == "ft/s":
        v = v/3.281
        h = h/3.281
    else:
        raise Exception('Invalid input. Use units of "m/s", "mph", or "ft/s" for speed.')
   
    #checks if inputs are valid
    if theta < 0 or theta > 90:
        raise Exception('Invalid input. Input an angle between 0 and 90 degrees.')

    if v < 0:
        raise Exception('Invalid input. Input a positive initial speed.')
        
    if h < 0:
        raise Exception('Invalid input. Input a positive initial height') 
        
    #calculations
    theta = np.radians(theta)
    vx = v*np.cos(theta)
    vy = v*np.sin(theta)
    g = 9.81
    
    #range
    roots = np.roots([-.5*g, vy, h])
    T = roots[0]
    r = vx*T  
    
    #maximum height of projectile
    ymax = (vy**2+2*g*h)/(2*g)
    t = np.arange(0, T, 0.1)
    
    ypos = lambda x: h+vy*x-.5*g*x**2;
    xpos = lambda x: vx*x;
    
    #plot and change outputs to correct units
    if u == "m/s":
        plt.plot(xpos(t),ypos(t))
        plt.xlabel("Range (m)")
        plt.ylabel("Height (m)")
    elif u == "mph" or u == "ft/s":    
        plt.plot(3.281*xpos(t),3.281*ypos(t))
        plt.xlabel("Range (ft)")
        plt.ylabel("Height (ft)")
        r = r*3.281
        ymax = ymax*3.281
    plt.title("Trajectory")
    
    r = round(r, 2)
    T = round(T, 2)
    ymax = round(ymax, 2)
    
    #print(r, T, ymax)
    return r, T, ymax


def satellite(T, u):
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

    #print("The satellite orbits at a height of", h, "km from Earth's surface with a speed of", v, "km/s")
    
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
    plt.plot(h1, v1, 'pk')

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
    
    #print(h, v)
    return h, v