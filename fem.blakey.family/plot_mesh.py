import sys
import matplotlib as mpl
from mpl_toolkits.mplot3d import Axes3D
import numpy as np
import matplotlib.pyplot as plt
import math as maths

data_loc_mesh = sys.argv[1]
filename = sys.argv[2]

left, right, p = np.loadtxt(data_loc_mesh, unpack=True)

plt.figure(1)

plt.plot([left,  right], [p,     p],     'b')
plt.plot([left,  left],  [p-0.1, p+0.1], 'g')
plt.plot([right, right], [p-0.1, p+0.1], 'g')
plt.grid(True)
plt.xlabel("x")
plt.ylabel("p")
plt.title("Plot of Mesh")

plt.savefig('./outputs/' + filename + '-mesh.png')