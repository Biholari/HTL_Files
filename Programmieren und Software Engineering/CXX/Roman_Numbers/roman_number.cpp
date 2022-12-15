#include <iostream>
#include "roman_number.h"

using namespace std;

Roman_Digit Roman_Number::single_digits[] = {"M", 1000, 1000, "D", 500, 100, "C", 100, 100, "L", 50, 10, "X", 10, 10, "V", 5, 1, "I", 1, 1};
Roman_Digit Roman_Number::double_digits[] = {"CM", 900, 90, "CD", 400, 90, "XC", 90, 9, "XL", 40, 9, "IX", 9, 0, "IV", 4, 0, "", 0, 0};

int Roman_Number::roman_to_dec(string roman)
{
}

string Roman_Number::dec_to_roman(int dec_value)
{
    if (dec_value <= 0)
    {
        throw std::string("Decimal value must be greater than 0");
    }

    std::string result;
    int remaining_decimal = dec_value;

    while (remaining_decimal > 0)
    {
        bool found = false;

        // Search for the largest Roman digit (from both arrays) whose value is less than or equal to the remaining decimal value.
        for (auto const &rd : double_digits)
        {
            if (rd.value <= remaining_decimal)
            {
                result += rd.digit;
                remaining_decimal -= rd.value;
                found = true;
                break;
            }
        }

        if (!found)
        {
            for (auto const &rd : single_digits)
            {
                if (rd.value <= remaining_decimal)
                {
                    result += rd.digit;
                    remaining_decimal -= rd.value;
                    break;
                }
            }
        }
    }
    return result;
}

Roman_Number::Roman_Number(int value)
{
    this->number = dec_to_roman(value);
}

Roman_Number::Roman_Number(string number)
{
    this->value = roman_to_dec(number);
}

string Roman_Number::get_number()
{
    return this->number;
}

int Roman_Number::get_value()
{
    return this->value;
}
