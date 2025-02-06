from gi.repository import GLib, Core, Ising
import numpy as np
import matplotlib.pyplot as plt

Energy = Ising.Energy
System = Ising.System
Disturbance = Ising.Disturbance
Integrator = Core.Integrator

GLib.random_set_seed(10)

temperature = 100.0
system = System.create(10, 10)
energy = Energy.create(1.0, 1.0)
disturbance = Disturbance()

integrator = Integrator.create(temperature, system, energy, disturbance)

for i in range(1000):
    integrator.perform_metropolis()
    system = integrator.get_system()
    print(f"Step {i} (E = {energy.compute_energy(system)})")

    if i % 10 == 0:
        arr = np.asarray(system.get_arr()).reshape((system.get_size1(), system.get_size2()))
        plt.cla()
        plt.pcolormesh(arr)
        plt.savefig(f"plots/img{i}.png")

