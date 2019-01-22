# Starting program for Jan. 17

import numpy as np

test=np.loadtxt("smallperiodictable.txt", dtype={'names': ('AN','name', 'symbol', 'AW','density','isotopes','year'), 'formats': ('i1', 'U16', 'U2','f4','f4','i4','i4')})