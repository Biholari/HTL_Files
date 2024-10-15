using System.Windows.Media;

namespace Achterbahn
{
    class Passenger
    {
        private int _id;
        private MainWindow _mainWindow;
        private Wagon _wagon;

        public Passenger(int id, Wagon wagon, MainWindow mainWindow)
        {
            this._id = id;
            this._mainWindow = mainWindow;
            this._wagon = wagon;
        }

        public void Ride()
        {
            while (true)
            {
                _mainWindow.UpdatePassengerStatus(_id, "Wartet", Brushes.Gray);
                _wagon.BoardWagon(_id);

                _wagon.RideCompletedEvent.WaitOne();
                _mainWindow.UpdatePassengerStatus(_id, "Aussteigen", Brushes.Blue);

                Thread.Sleep(1000);
                _mainWindow.UpdatePassengerStatus(_id, "Warten", Brushes.Orange);
            }
        }
    }
}
