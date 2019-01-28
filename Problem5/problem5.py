#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Jan 23 20:08:36 2019

@author: meganhott
"""
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import scipy.io as sio 

"import data"
"""
absolute path
xlsfile = "/Users/meganhott/Documents/GitHub/MHott/Problem5/GlobalCarbonBudget2018.xlsx"
txtfile = '/Users/meganhott/Documents/GitHub/MHott/Problem5/GlobalTempbyYear.txt'
"""
"relative path"
xlsfile = 'GlobalCarbonBudget2018.xlsx'
txtfile = 'GlobalTempbyYear.txt'
X = pd.read_excel(xlsfile, sheet_name = "Historical Budget", skiprows=114)
T = pd.read_table(txtfile, delimiter="\s+", header=None)

"cumulative sum"
industry = X.iloc[:, 1].values
industrysum = industry.cumsum(axis=0)
land = X.iloc[:, 2].values
landsum = land.cumsum(axis=0)
totalsum = industrysum + landsum

"plots"
year = T.iloc[0:168, 0]
temp = T.iloc[0:168, 1]
plt.figure(figsize=(8,8))
plt.subplot(211)
ax = plt.gca()
ax2 = ax.twinx()
ax.plot(year, totalsum, label = 'Emissions')
ax2.plot(year, temp, 'r')
ax.plot(np.nan, 'r', label = 'Temperature')
ax.legend(loc=0)

plt.title("Cumulative Carbon Emissions vs Year")
ax.grid()
ax.set_xlabel("Year")
ax.set_ylabel("Cumulative Carbon Emissions (10^12 kg)")
y = "Average Global Temperature (" + u'\u00B0' + "C)"
ax2.set_ylabel(y)

plt.subplot(212)
plt.plot(totalsum, temp)
plt.grid(True)

plt.title("Average Global Temperature vs Cumulative Carbon Emissions")
plt.xlabel("Cumulative Carbon Emissions (10^12 kg)")
plt.ylabel("Average Global Temperature (" + u'\u00B0' + "C)")
plt.subplots_adjust(hspace=.5)

"save to mat file"
sio.savemat('problem5datapy.mat', {'Year':year, 'Average Global Temperature':temp, 'Cumulative Carbon Emissions':totalsum})