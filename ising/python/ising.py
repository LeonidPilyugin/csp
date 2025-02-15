#!/usr/bin/env python3

import sys
import numpy as np
import pandas as pd
import multiprocessing as mp
import itertools

import warnings
with warnings.catch_warnings(action="ignore"):
    from gi.repository import GLib, Core, Ising

def _ising(temperature, grid_size, ncycles, classic_ising=True):
    assert grid_size % 2 == 0
    system = Ising.System.create(
        grid_size,
        grid_size,
        np.append(
            np.ones((grid_size // 2, grid_size)),
            -np.ones((grid_size // 2, grid_size)),
            axis=0
        ).flatten().tolist()
    )
    
    energy = (Ising.Energy if classic_ising else Ising.Energy6).create(1.0, 0.0)
    disturbance = Ising.Disturbance()
    integrator = Core.Integrator.create(temperature, system, energy, disturbance)

    steps = list(range(ncycles))
    energies = []
    magmoms = []

    # skip first steps
    for _ in range(grid_size * grid_size * 20):
        integrator.perform_metropolis()

    for step in steps:
        integrator.perform_metropolis()
        system = integrator.get_system()
        energies.append(integrator.get_energy())
        magmoms.append(system.get_magmom())

    return np.asarray(steps), np.asarray(energies), np.asarray(magmoms)

def ising(temperature, grid_size, ncycles):
    _, energies, magmoms = _ising(temperature, grid_size, ncycles)

    E_mean = energies.mean()
    M_mean = magmoms.mean()
    C = ((energies**2).mean() - E_mean ** 2) / temperature ** 2
    Chi = ((magmoms**2).mean() - M_mean ** 2) / temperature

    return float(E_mean), float(M_mean), float(energies.std()), float(magmoms.std()), float(C), float(Chi)

    
if __name__ == "__main__":
    PREFIX = sys.argv[1]

    def process_ising(args):
        random_seed, temperature, grid_size, ncycles = args
        GLib.random_set_seed(random_seed)
        steps, energies, magmoms = ising(temperature, grid_size, ncycles)

        em_df = pd.DataFrame(data={"step": steps, "e": energies, "m": magmoms})
        em_df.to_csv(f"{PREFIX}/{random_seed}-{temperature}.csv")

        E_mean = energies.mean()
        M_mean = magmoms.mean()
        C = ((energies**2).mean() - E_mean ** 2) / temperature
        Chi = ((magmoms**2).mean() - M_mean ** 2) / temperature

        return random_seed, temperature, E_mean, energies.std(), M_mean, magmoms.std(), C, Chi


    random_seeds = range(4)
    temperatures = np.arange(0.0, 5.01, 0.1)
    grid_size = 100
    ncycles = int(1e6)

    results = None
    with mp.Pool() as p:
        results = p.map(process_ising, itertools.product(random_seeds, temperatures, [grid_size], [ncycles]))
    
    pd.DataFrame(
        list(np.asarray(results)),
        columns=[
            "random_seed", "temperature", "E", "E_err", "M", "M_err", "C", "Chi"
        ]
    ).to_csv(f"{PREFIX}/data.csv")
    

