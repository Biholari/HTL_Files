using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Drei_Raucher
{
    internal class Table
    {
        private Ingredient? _ingredient1;
        private Ingredient? _ingredient2;

        public bool HasIgredientsFor(Ingredient ingredient)
        {
            return _ingredient1.HasValue && _ingredient2.HasValue &&
                _ingredient1 != ingredient && _ingredient2 != ingredient;
        }

        public bool IsEmpty()
        {
            return !_ingredient1.HasValue && !_ingredient2.HasValue;
        }

        public void PlaceIngredients(Ingredient ingredient1, Ingredient ingredient2)
        {
            _ingredient1 = ingredient1;
            _ingredient2 = ingredient2;
        }

        public void Clear()
        {
            _ingredient1 = null;
            _ingredient2 = null;
        }
    }
}
