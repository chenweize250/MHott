#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Jan 21 21:24:26 2019

@author: meganhott
"""

# Starting program for Jan. 17

import numpy as np
import matplotlib.pyplot as plt

test=np.loadtxt("smallperiodictable.txt", dtype={'names': ('AN','name', 'symbol', 'AW','density','isotopes','year'), 'formats': ('i1', 'U16', 'U2','f4','f4','i4','i4')})

"Q1"
d = test['density']>1
d1 = np.count_nonzero(d == True)
density_l = test['name'][d]
print("There are", d1, "elements denser than water in their natural form. These elements are", density_l)
print()

"Q2"
i = test['isotopes']>100
i1 = np.count_nonzero(i == True)
isotopes_l = test['name'][i]
print("There are", i1, "elements with over 100 isotopes. These elements are", isotopes_l)
print()

"Q3"
j = test['year']<1900
j1 = np.count_nonzero(j == True)
year_l = test['name'][j]
print(j1,"elements were discovered before 1900. These elements are", year_l)
print()

"Q4"
plt.plot(test['AW'], test['density'])
plt.title("Density vs Atomic Weight")
plt.xlabel("Atomic Weight")
plt.ylabel("Density")