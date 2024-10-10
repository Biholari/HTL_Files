using System.Collections.ObjectModel;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Media;

namespace Achterbahn
{
    public partial class MainWindow : Window
    {
        private List<Thread> passengerThreads;
        private Thread wagonThread;
        private Wagon wagon;
        private int NumberOfPassengers;
        private int WagonCapacity;
        private int RideCount;

        // ObservableCollection für die Anzeige der Passagierstatus
        public ObservableCollection<string> PassengerStatuses { get; private set; }

        public MainWindow()
        {
            InitializeComponent();
            // Initialisiere die ObservableCollection
            PassengerStatuses = new ObservableCollection<string>();
            // Setze DataContext für Bindings
            this.DataContext = this;
        }

        // Start der Simulation
        private void StartButton_Click(object sender, RoutedEventArgs e)
        {
            // Hole die Werte von den Slidern
            NumberOfPassengers = (int)PassengerSlider.Value;
            WagonCapacity = (int)CapacitySlider.Value;
            RideCount = (int)RideSlider.Value;

            // Initialisiere den Wagen mit den vom Benutzer gesetzten Parametern
            wagon = new Wagon(WagonCapacity, RideCount, this);

            // Initialisiere die Anzeige der Passagierstatus
            InitializePassengerDisplay();

            // Starte den Wagen-Thread
            wagonThread = new Thread(wagon.StartRide);
            wagonThread.Start();

            // Erzeuge und starte die Passagier-Threads
            passengerThreads = new List<Thread>();
            for (int i = 0; i < NumberOfPassengers; i++)
            {
                var passenger = new Passenger(i + 1, wagon, this);
                var thread = new Thread(passenger.Ride);
                passengerThreads.Add(thread);
                thread.Start();
            }
        }

        // Aktualisiere den Status eines Passagiers in der GUI
        public void UpdatePassengerStatus(int passengerId, string status, SolidColorBrush color)
        {
            Dispatcher.Invoke(() =>
            {
                // Aktualisiere den Text für den Passagier in der ObservableCollection
                PassengerStatuses[passengerId - 1] = $"Passagier {passengerId}: {status}";
            });
        }

        // Aktualisiere den Status des Wagens in der GUI
        public void UpdateWagonStatus(string status, SolidColorBrush color)
        {
            WagonStatus.Dispatcher.Invoke(() =>
            {
                WagonStatus.Text = $"Wagen Status: {status}";
                WagonStatus.Foreground = color;
            });
        }

        // Initialisiere die Passagier-Anzeige in der GUI
        public void InitializePassengerDisplay()
        {
            Dispatcher.Invoke(() =>
            {
                PassengerStatuses.Clear();
                for (int i = 1; i <= NumberOfPassengers; i++)
                {
                    PassengerStatuses.Add($"Passagier {i}: Warten");
                }
            });
        }
    }
}