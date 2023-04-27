#include <iostream>
#include "Calculator.h"

int main(int, char **)
{
    Calculator calc;
    std::string input = "";

    std::cout << "Rechnung: ";
    std::getline(std::cin, input);

    double result = calc.calculate(input);
    std::cout << "Ergebnis: " << result << std::endl;
}
