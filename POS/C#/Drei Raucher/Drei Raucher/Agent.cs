using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Drei_Raucher
{
    internal class Agent
    {
        private Random _random = new Random();
        private Action<string> _updateUI;

        public Agent(Action<string> updateUI)
        {
            _updateUI = updateUI;
        }

        public void PlaceIngredients(object tableObj)
        {
            Table table = (Table)tableObj;

            while (true)
            {
                lock (table)
                {
                    while (!table.IsEmpty())
                    {
                        Monitor.Wait(table);
                    }

                    Ingredient[] ingredients = GetTwoRandomIngredients();
                    table.PlaceIngredients(ingredients[0], ingredients[1]);
                    _updateUI($"Agent placed {ingredients[0]} and {ingredients[1]} on the table.");

                    Monitor.PulseAll(table);
                    Thread.Sleep(10);

                }
            }
        }

        private Ingredient[] GetTwoRandomIngredients()
        {
            Ingredient[] allIngredients = (Ingredient[])Enum.GetValues(typeof(Ingredient));
            int first = _random.Next(allIngredients.Length);
            int second;
            do
            {
                second = _random.Next(allIngredients.Length);
            } while (second == first);

            return new Ingredient[] { allIngredients[first], allIngredients[second] };
        }
    }
}
