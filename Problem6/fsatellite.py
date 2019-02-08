# -*- coding: utf-8 -*-
"""
This file contains functions related to calculating orbital quantities of satellites
"""
import numpy as np
import matplotlib.pyplot as pyp
from colorama import Fore, Back
G = 6.67*10**(-11);
M = 5.98*10**(24);
R = 6.371*10**(6);


def satellite(T,grph = 0,un='hr'):
    if un=="hr" or un=="hour":
        t = 3600*T;
    elif un == "day" or un == "dy":
        t = 24*3600*T;
    elif un == "min" or un== "m":
        t = 60*T;
    elif un == "s" or un=="sec":
        t=T;
    else:
        print(Fore.RED + "Error: need numerical input with a units of sec, min, hour or day")
        
    mtokm = lambda x: x/1000; #lambda functions are python's anonymous functions

    h= alt(t);
    v =orbvel(h);
    V = mtokm(v);
    H = mtokm(h);
    
    T = 3600*np.arange(1.5,60)
    h = alt(T);
    v = mtokm(orbvel(h));
    h = mtokm(h);
    if grph:
        fig(T,h);
        fig(v,h,'orbital velocity (km/s)');
    return H, V

def alt(t):
     h = (G*M*t**2/(4*np.pi**2))**(1/3) - R;
     return h

def orbvel(h):
    v = np.sqrt(G*M/(h+R));
    return v

def fig(x,y,xlab='period of orbit (hours)',ylab='altitude (km)'):
    pyp.figure()
    pyp.plot(x,y)
    pyp.xlabel(xlab)
    pyp.ylabel(ylab)
    
