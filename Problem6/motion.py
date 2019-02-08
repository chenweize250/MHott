#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Feb  5 12:25:06 2019

@author: meganhott
"""

import numpy as np
import matplotlib.pyplot as plt
import matplotlib.animation as animation

def projectile(v, theta, u = "m/s", h=0):
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
        print('Invalid input. Use units of "m/s", "mph", or "ft/s" for speed.')
   
    #check if 90 degrees breaks program
    if theta < 0 or theta > 90:
        raise Exception('Input an angle between 0 and 90 degrees')

    
    "add initial height to kinematic equation: use quadratic equation"
    theta = np.radians(theta)
    vx = v*np.cos(theta)
    vy = v*np.sin(theta)
    g = 9.81
    

#0=h+vyT-.5gT^2

    roots = np.roots([-.5*g, vy, h])
    T = roots[0]
    r = vx*T  
    
    #change to account for initial height: calculate in terms of vy=0
    ymax = vy*(T/2)-.5*g*(T/2)**2 
    "chage step size of t based on how large input is"
    t = np.arange(0, T, 0.1)
    
    ypos = lambda x: vy*x-.5*g*x**2; #might have to change because of h
    xpos = lambda x: vx*x;
    
    if u == "m/s":
        plt.plot(xpos(t),ypos(t))
    elif u == "mph" or u == "ft/s":    
        plt.plot(3.281*xpos(t),3.281*ypos(t))
        r = r*3.281
        ymax = ymax*3.281
    
    "animate plot"

    
    "change outputs to correct units"
    
    
    print(r, T, ymax)
    return r, T, ymax






"""
ffunction [r,T] = fprojectile(v, theta, vunit)
%FPROJECTILE takes the initial velocity, launch angle, and units of the
%initial velocity (either "m/s" or "mph") and returns the range in units of 
%meters or feet and flight time in units of seconds

switch vunit
    case "m/s"
        
    case "mph"
        v = v/2.237;
    otherwise
        error('Invalid input. Use units of "m/s" or "mph" for speed.')
end

if theta < 90 & theta > 0
    
else
    error("Input an angle between 0 and 90 degrees")
end

vx = v*cosd(theta);
vy = v*sind(theta);
g = 9.81;

T = 2*vy/g;
r = vx*T;

figure
t = 0:0.01:T;
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
"""