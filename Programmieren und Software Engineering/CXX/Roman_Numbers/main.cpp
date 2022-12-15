#include <iostream>
#include "roman_number.h"

using namespace std;

int main() {
    Roman_Number roman_number(4);

    try
    {
        cout << roman_number.get_number() << endl;
    }
    catch(const string& e)
    {
        std::cerr << e << endl;
    }
}
