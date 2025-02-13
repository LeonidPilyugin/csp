using Core;

namespace Ising
{
    public class Energy6 : Core.Energy
    {
        private double J = 1.0;
        private double H = 1.0;
        
        public Energy6.create(double J, double H)
        {
            this.J = J;
            this.H = H;
        }

        public double get_j()
        {
            return this.J;
        }

        public double get_h()
        {
            return this.H;
        }

        public override double compute_energy(Core.System system)
            requires (system is System)
        {
            System isystem = (System) system;
            double E = 0.0;
            
            for (int i = 0; i < isystem.get_size1(); i++)
            {
                for (int j = 0; j < isystem.get_size2(); j++)
                {
                    E -= this.H * isystem.get_element(i, j);
                    double temp = 0.0;
                    temp += isystem.get_element(i - 1, j - 1) * isystem.get_element(i, j);
                    temp += isystem.get_element(i - 1, j) * isystem.get_element(i, j);
                    temp += isystem.get_element(i, j - 1) * isystem.get_element(i, j);
                    temp += isystem.get_element(i, j + 1) * isystem.get_element(i, j);
                    temp += isystem.get_element(i + 1, j) * isystem.get_element(i, j);
                    temp += isystem.get_element(i + 1, j + 1) * isystem.get_element(i, j);
                    E -= this.J / 2 * temp;
                }
            }

            return E;
        }
    }
}
