import sys
import matplotlib as mpl
from mpl_toolkits.mplot3d import Axes3D
import numpy as np
import matplotlib.pyplot as plt
import math as maths

data_loc_soln = sys.argv[1]
filename = sys.argv[2]

points, approximate, exact = np.loadtxt(data_loc_soln, unpack=True)

plt.figure(1)

plt.plot(points, approximate, 'b-', label="Approximation")
plt.grid(True)
plt.xlabel("x")
plt.ylabel("u")
plt.title("Solution Plot")
plt.legend(loc="lower right")

plt.savefig('./outputs/' + filename + '-solution.png')