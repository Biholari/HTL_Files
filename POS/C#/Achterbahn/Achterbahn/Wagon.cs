using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Media;

namespace Achterbahn
{
    public class Wagon
    {
        private int capacity;
        private int ridesRemaining;
        private int passengersOnBoard = 0;
        private MainWindow mainWindow;
        private ManualResetEvent rideCompletedEvent;
        private AutoResetEvent passengerBoardedEvent;
        private object lockObject = new object();

        public Wagon(int capacity, int rideCount, MainWindow window)
        {
            this.capacity = capacity;
            this.ridesRemaining = rideCount;
            this.mainWindow = window;
            rideCompletedEvent = new ManualResetEvent(false);
            passengerBoardedEvent = new AutoResetEvent(false);
        }

        public void BoardWagon(int passengerId)
        {
            lock (lockObject)
            {
                passengersOnBoard++;
                mainWindow.UpdatePassengerStatus(passengerId, "Einsteigen", Brushes.Orange);

                if (passengersOnBoard == capacity)
                {
                    mainWindow.UpdateWagonStatus("Voll, beginnt Fahrt...", Brushes.Green);
                    passengerBoardedEvent.Set(); // Signalisiert, dass alle Passagiere an Bord sind
                }
            }
        }

        public void StartRide()
        {
            while (ridesRemaining > 0)
            {
                passengerBoardedEvent.WaitOne(); // Warten, bis der Wagen voll ist
                mainWindow.UpdateWagonStatus("Fährt...", Brushes.Blue);
                Thread.Sleep(2000); // Fahrtzeit simulieren
                mainWindow.UpdateWagonStatus("Fahrt beendet", Brushes.Red);
                ridesRemaining--;

                lock (lockObject)
                {
                    passengersOnBoard = 0;
                }

                rideCompletedEvent.Set(); // Fahrt abgeschlossen
                passengerBoardedEvent.Reset(); // Zurücksetzen für nächste Fahrt
            }

            mainWindow.UpdateWagonStatus("Alle Fahrten abgeschlossen", Brushes.DarkRed);
        }

        public ManualResetEvent GetRideCompletedEvent()
        {
            return rideCompletedEvent;
        }
    }
}
