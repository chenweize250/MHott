# -*- coding: utf-8 -*-
"""
This file contains functions related to calculating orbital quantities of satellites
"""
import numpy as np

G = 6.67*10**(-11);
Mearth = 5.98*10**(24); #mass of earth in kg
Rearth = 6.371*10**(6); #radius of earth in m
Msun = 1.99*10**(30); #mass of sun in kg
Orbitearth = 150*10^9; # orbital radius of earth in m

def planet(m,r,ms,a):
    
    T = period(a);
    v = orbvel(a);
    g = grav(a);
    
    return T,g,v

def period(a):
    T = 365;
    return T

def orbvel(a):
    v = 11.2;
    return v

def grav(a):
    g=9.8;
    return g


    
