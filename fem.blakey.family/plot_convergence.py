import sys
import matplotlib as mpl
from mpl_toolkits.mplot3d import Axes3D
import numpy as np
import matplotlib.pyplot as plt
import math as maths

data_loc_convergence = sys.argv[1]
filename = sys.argv[2]

dof, error, indicator = np.loadtxt(data_loc_convergence, unpack=True)

plt.figure(1)

plt.loglog(dof,  error,                'bo-',                       label="Energy error")
plt.loglog(dof,  indicator,            'go-',                       label="Error estimator")
plt.grid(True)
plt.xlabel("DoF")
plt.ylabel("error")
plt.title("Convergence Plot")
plt.legend(loc="upper right")

plt.savefig('./outputs/' + filename + '-convergence.png')