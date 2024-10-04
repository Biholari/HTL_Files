using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Documents;

namespace Drei_Raucher
{
    class Smoker
    {
        private Ingredient _ingredient;
        private string _name;
        private Action<string> _updateUI;

        public Smoker(Ingredient ingredient, string name, Action<string> updateUI)
        {
            _ingredient = ingredient;
            _name = name;
            _updateUI = updateUI;
        }

        public void TryToSmoke(object tableObj)
        {
            Table table = (Table)tableObj;

            while (true)
            {
                lock (table)
                {
                    while (!table.HasIgredientsFor(_ingredient))
                    {
                        Monitor.Wait(table);
                    }

                    table.Clear();
                    _updateUI($"{_name} is smoking...");
                    Thread.Sleep(10);

                    _updateUI($"{_name} is done smoking.");
                    Monitor.PulseAll(table);
                }
            }
        }
    }
}
