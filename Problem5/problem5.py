#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Jan 23 20:08:36 2019

@author: meganhott
"""
import pandas as pd
import matplotlib.pyplot as plt

"import data"
xlsfile = "/Users/meganhott/Documents/GitHub/MHott/Problem5/GlobalCarbonBudget2018.xlsx"
X = pd.read_excel(xlsfile, sheet_name = "Historical Budget", skiprows=114)

txtfile = '/Users/meganhott/Documents/GitHub/MHott/Problem5/GlobalTempbyYear.txt'
T = pd.read_table(txtfile, delimiter="\s+", header=None)


"cumulative sum"
industry = X.iloc[:, 1].values
industrysum = industry.cumsum(axis=0)
land = X.iloc[:, 2].values
landsum = land.cumsum(axis=0)
totalsum = industrysum + landsum

"plots"
year = T.iloc[0:168, 0]
plt.subplot(211)
plt.plot(year, totalsum)
plt.title("Cumulative Carbon Emissions vs Year")
plt.xlabel("Cumulative Carbon Emissions")
plt.ylabel("Average Global Temperature")

temp = T.iloc[0:168, 1]
plt.subplot(212)
plt.plot(totalsum, temp)
plt.title("Average Global Temperature vs Cumulative Carbon Emissions")
plt.xlabel("Cumulative Carbon Emissions")
plt.ylabel("Average Global Temperature")
plt.subplots_adjust(hspace=1.6)