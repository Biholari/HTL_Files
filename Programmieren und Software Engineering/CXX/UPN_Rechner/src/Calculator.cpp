#include "Calculator.h"
#include <iostream>
#include <sstream>
#include <stdexcept>
#include <string>
#include <fstream>

Calculator::Calculator() { this->first = nullptr; }

Calculator::~Calculator()
{
    Node *first;
    first = this->first;
    if (this->first)
    {
        this->first->~Node();
        delete first;
    }
}

double Calculator::calculate(std::string input)
{
    std::ofstream file("log.txt");
    std::string token;
    auto printStack = [&]()
    {
        std::cout << "Stack: ";
        for (Node *current = first; current != nullptr; current = current->next)
        {
            std::cout << current->data << " ";
        }
        std::cout << std::endl;
    };
    while (!input.empty())
    { // solange der Eingabe-String noch nicht leer ist
        // das nächste Token finden
        printStack();
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
            double result = a + b;
            push(result);
            std::cout << a << " + " << b << " = " << result << std::endl;
            // Write calcuation in file
            file << a << " + " << b << " = " << result << std::endl;
            // printStack();
        }
        else if (token == "-")
        { // Subtraktion
            double b = pop();
            double a = pop();
            double result = a - b;
            push(result);
            std::cout << a << " - " << b << " = " << result << std::endl;
            file << a << " - " << b << " = " << result << std::endl;
            // printStack();
        }
        else if (token == "*")
        { // Multiplikation
            double b = pop();
            double a = pop();
            double result = a * b;
            push(result);
            std::cout << a << " * " << b << " = " << result << std::endl;
            file << a << " * " << b << " = " << result << std::endl;
            // printStack();
        }
        else if (token == "/")
        { // Division
            double b = pop();
            double a = pop();
            double result = a / b;
            push(result);
            std::cout << a << " / " << b << " = " << result << std::endl;
            file << a << " / " << b << " = " << result << std::endl;
            // printStack();
        }
        else if (token == "=")
        { // Rechnung abschließen
            if (first == nullptr ||
                first->next !=
                    nullptr)
            { // es müssen genau zwei Elemente auf dem Stack sein
                throw std::logic_error("Ungültige Notation: Es müssen genau zwei "
                                       "Elemente auf dem Stack sein");
            }
            double result = pop(); // das Endergebnis vom Stack nehmen
            return result;         // gibt das Ergebnis zurück
            file << result << std::endl;
            file.close();
        }
        else
        { // Zahl
            double d = std::stod(token);
            push(d);
        }
    }
    // wenn der Eingabe-String leer ist, aber kein "=" am Ende steht, ist die
    // Notation ungültig
    throw std::logic_error(
        "Ungültige Notation: Es wurde kein = am Ende gefunden");
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
    {
        current = current->next;
    }

    current->next = n;
}

double Calculator::pop()
{
    Node *current = first;
    Node *previous = nullptr;
    if (!current)
    {
        return 0.0;
    }

    while (current->next)
    {
        previous = current;
        current = current->next;
    }

    double d = current->data;
    if (previous)
    {
        previous->next = nullptr;
    }
    else
    {
        first = nullptr;
    }
    delete current;

    return d;
}