using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace Multithreaded_Counter
{
    internal class Program
    {
        static void Main(string[] args)
        {
            for (int id = 0; id < 3; id++)
            {
                if (counter % id == 0)
                {
                    Console.WriteLine("ID: {0,3} Counter: {1,8} Modulo: {2}", id, counter, counter % id);
                }

                Thread thread = new Thread();
            }
        }
    }
}
