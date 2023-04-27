#include "Calculator.h"
#include <iostream>
#include <string>
#include <stdexcept>
#include <sstream>

Calculator::Calculator() {}
Calculator::~Calculator() {}

double Calculator::calculate(std::string input)
{
    std::string token;
    while (!input.empty())
    { // solange der Eingabe-String noch nicht leer ist
        // das nächste Token finden
        size_t pos = input.find(' ');
        if (pos != std::string::npos)
        {
            token = input.substr(0, pos);
            input.erase(0, pos + 1); // das Token und das Leerzeichen entfernen
        }
        else
        {
            token = input;
            input.clear(); // den gesamten Rest des Eingabe-Strings entfernen
        }
        if (token == "+")
        { // Addition
            double b = pop();
            double a = pop();
            push(a + b);
        }
        else if (token == "-")
        { // Subtraktion
            double b = pop();
            double a = pop();
            push(a - b);
        }
        else if (token == "*")
        { // Multiplikation
            double b = pop();
            double a = pop();
            push(a * b);
        }
        else if (token == "/")
        { // Division
            double b = pop();
            double a = pop();
            push(a / b);
        }
        else
        { // Zahl
            double d = std::stod(token);
            push(d);
        }
    }
    return pop(); // gibt das Ergebnis zurück
}

void Calculator::push(double d)
{
    Node *current = first;
    Node *n = new Node(d);
    if (!current)
    {
        first = n;
        return;
    }

    while (current->next)
        current = current->next;

    current->next = n;
}

double Calculator::pop()
{
    Node *current = first;
    Node *previous = nullptr;
    if (!current)
        return 0.0;

    while (current->next)
    {
        previous = current;
        current = current->next;
    }

    double d = current->data;
    if (previous)
        previous->next = nullptr;
    else
        first = nullptr;
    delete current;

    return d;
}