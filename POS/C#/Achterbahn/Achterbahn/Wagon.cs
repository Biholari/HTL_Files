using System.Printing;
using System.Windows.Media;

namespace Achterbahn
{
    public class Wagon
    {
        public int Capacity { get; set; }
        private int ridesRemaining;
        private int passengersOnBoard = 0;
        private MainWindow mainWindow;
        public ManualResetEvent RideCompletedEvent { get; }

        private AutoResetEvent passengerBoardedEvent;
        private object lockObject = new object();

        public Wagon(int capacity, int rideCount, MainWindow window)
        {
            this.Capacity = capacity;
            this.ridesRemaining = rideCount;
            this.mainWindow = window;
            this.RideCompletedEvent = new ManualResetEvent(false);
            this.passengerBoardedEvent = new AutoResetEvent(false);
        }

        public void BoardWagon(int passengerId)
        {
            lock (lockObject)
            {
                if (passengersOnBoard == Capacity)
                {
                    mainWindow.UpdateWagonStatus("Voll, beginnt Fahrt...", Brushes.Green);
                    passengerBoardedEvent.Set(); // Signalisiert, dass alle Passagiere an Bord
                }
                else
                {
                    passengersOnBoard++;
                    mainWindow.UpdatePassengerStatus(passengerId, "Einsteigen", Brushes.Orange);
                }
            }
        }

        public void StartRide()<
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

                RideCompletedEvent.Set(); // Fahrt abgeschlossen
                passengerBoardedEvent.Reset(); // Zurücksetzen für nächste Fahrt
            }

            mainWindow.UpdateWagonStatus("Alle Fahrten abgeschlossen", Brushes.DarkRed);
        }
    }
}
