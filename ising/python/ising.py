from gi.repository import GLib, Core, Ising

GLib.random_set_seed(10)

def ising(temperature, grid_size, ncycles, classic_ising=True):
    system = Ising.System.create(grid_size, grid_size)
    energy = (Ising.Energy if classic_ising else Ising.Energy6).create(1.0, 0.0)
    disturbance = Ising.Disturbance()
    integrator = Core.Integrator.create(temperature, system, energy, disturbance)

    steps = list(range(ncycles))
    energies = []
    magmoms = []

    for step in steps:
        integrator.perform_metropolis()
        system = integrator.get_system()
        energies.append(integrator.get_energy())
        magmoms.append(system.get_magmom())
