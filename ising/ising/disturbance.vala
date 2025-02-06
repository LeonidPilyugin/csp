using Core;

namespace Ising
{
    public class Disturbance : Core.Disturbance
    {
        public override void disturb(Core.System system)
            requires (system is System)
        {
            System isystem = (System) system;

            int x = GLib.Random.int_range(0, isystem.get_size1());
            int y = GLib.Random.int_range(0, isystem.get_size2());

            var val = isystem.get_element(x, y);
            isystem.set_element(x, y, -val);
        }
    }
}
