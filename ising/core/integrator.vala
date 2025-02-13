namespace Core
{
    public class Integrator
    {
        private double temperature = 1.0;
        private double energy_val = 0.0;
        private System system = null;
        private Energy energy = null;
        private Disturbance disturbance = null;

        public Integrator.create(double temperature, System system, Energy energy, Disturbance disturbance)
        {
            this.temperature = temperature;
            this.system = system;
            this.energy = energy;
            this.disturbance = disturbance;
            this.energy_val = this.energy.compute_energy(this.system);
        }

        public System get_system()
        {
            return this.system.copy();
        }

        public double get_temperature()
        {
            return this.temperature;
        }

        public double get_energy()
        {
            return this.energy_val;
        }

        public void perform_metropolis()
        {
            System test = this.system.copy();
            this.disturbance.disturb(test);

            double E = this.energy.compute_energy(test);
            double dE = E - this.energy_val;
            double probability = GLib.Math.fmin(1.0, GLib.Math.exp(-dE / this.temperature));

            if (GLib.Random.double_range(0.0, 1.0) < probability)
            {
                this.system = test;
                this.energy_val = E;
            }
        }
    }
}
