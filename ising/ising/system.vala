using Core;

namespace Ising
{
    public class System : Core.System
    {
        private int8[] array = new int8[1];
        private int size1 = 1;
        private int size2 = 1;

        public System.create(int size1, int size2)
            requires (size1 > 0)
            requires (size2 > 0)
        {
            this.array = new int8[size1 * size2];
            Memory.set(this.array, 1, sizeof(int8) * this.array.length);
            this.size1 = size1;
            this.size2 = size2;
        }

        public int get_size1()
            ensures (result > 0)
        {
            return this.size1;
        }

        public int get_size2()
            ensures (result > 0)
        {
            return this.size2;
        }

        private void normalize_indeces(ref int x, ref int y)
        {
            x = ((x % this.size1) + this.size1) % this.size1;
            assert (x >= 0);
            assert (x < this.size1);
            y = ((y % this.size2) + this.size2) % this.size2;
            assert (y >= 0);
            assert (y < this.size2);
        }

        public int8 get_element(int x, int y)
            ensures (result == 1 || result == -1)
        {
            this.normalize_indeces(ref x, ref y);
            return this.array[y * size1 + x];
        }

        public void set_element(int x, int y, int8 val)
            requires (val == 1 || val == -1)
        {
            this.normalize_indeces(ref x, ref y);
            this.array[y * size1 + x] = val;
        }

        internal unowned int8[] get_arr_unowned()
        {
            return this.array;
        }

        public int8[] get_arr()
        {
            return this.array;
        }

        public override Core.System copy()
        {
            System res = new System();
            res.size1 = this.size1;
            res.size2 = this.size2;
            res.array = this.array;
            return (Core.System) res;
        }

        public int get_magmom()
        {
            int result = 0;
            for (uint i = 0; i < this.array.length; i++)
                result += (int) this.array[i];
            return result;
        }
    }
}
