using Core;

namespace Ising
{
    public class Energy : Core.Energy
    {
        protected double J = 1.0;
        protected double H = 0.0;
        
        public Energy.create(double J, double H)
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
                    for (int ii = -1; ii <= 1; ii += 2)
                        for (int jj = -1; jj <= 1; jj += 2)
                            temp += isystem.get_element(i + ii, j + jj) * isystem.get_element(i, j);
                    E -= this.J / 2 * temp;
                }
            }

            return E;
        }
    }
}
