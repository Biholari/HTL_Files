#include <iostream>
#include <chrono>
#include <thread>

#include "tower.h"

using namespace std;

void move(Tower &start, Tower &ziel, Tower &zwischenspeicher, int anzahl_der_scheiben, int &counter, Tower &t1, Tower &t2, Tower &t3)
{
    // if there are disks to be moved
    if (anzahl_der_scheiben > 0)
    {
        // move n-1 disks from "start" to "zwischenspeicher"
        move(start, zwischenspeicher, ziel, anzahl_der_scheiben - 1, counter, t1, t2, t3);

        // move the last disk from "start" to "ziel"
        ziel.push(start.pop());
        cout << "\033[2J";

        // print the towers
        t1.print(1, 0);
        t2.print(13, 0);
        t3.print(25, 0);
        cout << "\n\nAnzahl der Bewegungen: " << counter << endl;
        counter++;

        // wait for 500 milliseconds
        this_thread::sleep_for(500ms);

        // move n-1 disks from "zwischenspeicher" to "ziel"
        move(zwischenspeicher, ziel, start, anzahl_der_scheiben - 1, counter, t1, t2, t3);
    }
}

int main(int, char **)
{
    Tower t1("Start", 8, true);
    Tower t2("Frei", 8, false);
    Tower t3("Ziel", 8, false);
    static int counter = 1;
    cout << "\033[2J";
    t1.print(1, 0);
    t2.print(13, 0);
    t3.print(25, 0);
    try
    {
        move(t1, t3, t2, 8, counter, t1, t2, t3);
    }
    catch (const std::runtime_error &e)
    {
        std::cerr << e.what() << '\n';
        return 1;
    }
    t1.print(1, 12);
    t2.print(13, 12);
    t3.print(25, 12);

    cout << "\n\nAnzahl der Bewegungen: " << counter << endl;
}