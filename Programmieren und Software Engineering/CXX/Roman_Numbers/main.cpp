#include <iostream>
#include <string>
#include "roman_number.h"

using namespace std;

int main()
{
   /* string input;
    while(true) {
        cout << "Enter a number (either roman or decimal): ";
        cin >> input;
        cout << endl;

        if (!cin.fail())
            break;

        cout << "Invalid input! Please try again: ";

        cin.clear();
        cin.ignore(numeric_limits<streamsize>::max(), '\n');
    }

    if (isdigit(input[0])) {
        int number = stoi(input);
        Roman_Number roman_number(number);

        cout << "You entered the number: " << number << ". Which is in roman system: " << roman_number.get_value() << endl;
    }
    else {
        Roman_Number roman_number(input);
        cout << "You entered the roman number: " << input << ". Which is in decimal: " << roman_number.get_number() << endl;
    }*/

    Roman_Number roman_number(4);

    std::cout << roman_number.get_number() << endl;

    return 0;
}
