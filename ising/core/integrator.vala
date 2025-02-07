namespace Core
{
    public class Integrator
    {
        private double temperature = 1.0;
        private System system = null;
        private Energy energy = null;
        private Disturbance disturbance = null;

        public Integrator.create(double temperature, System system, Energy energy, Disturbance disturbance)
        {
            this.temperature = temperature;
            this.system = system;
            this.energy = energy;
            this.disturbance = disturbance;
        }

        public System get_system()
        {
            return this.system.copy();
        }

        public double get_temperature()
        {
            return this.temperature;
        }

        public void perform_metropolis()
        {
            System test = this.system.copy();
            this.disturbance.disturb(test);

            double dE = this.energy.compute_energy(test) - this.energy.compute_energy(this.system);
            double probability = GLib.Math.fmin(1.0, GLib.Math.exp(-dE / this.temperature));

            if (GLib.Random.double_range(0.0, 1.0) < probability)
                this.system = test;
        }
    }
}
