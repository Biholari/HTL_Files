using System.Windows;

namespace Achterbahn
{
    public partial class MainWindow : Window
    {
        private int _passengerCount;
        private int _wagonCapacity;
        private int _rideCount;
        private int _currentPassengers;
        private object _lock = new object();
        private AutoResetEvent _wagonReady = new AutoResetEvent(false);
        private AutoResetEvent _passengersReady = new AutoResetEvent(false);
        private List<Thread> _passengerThreads;
        private Thread _wagonThread;

        /// <summary>
        /// Interaction logic for MainWindow.xaml
        /// </summary>
        public MainWindow()
        {
            InitializeComponent();
        }

        private void StartButton_Click(object sender, RoutedEventArgs e)
        {
            _passengerCount = (int)slider.Value;
            _wagonCapacity = int.Parse(WagonBox.Text);
            _rideCount = 0;
            _currentPassengers = 0;

            _passengerThreads = new List<Thread>();

            for (int i = 0; i < _passengerCount; i++)
            {
                Thread passengerThread = new Thread(PassengerAction);
                _passengerThreads.Add(passengerThread);
                passengerThread.Name = $"Passenger {i + 1}";
                passengerThread.Start(i + 1);
            }

            _wagonThread = new Thread(WagonAction);
            _wagonThread.Start();
        }

        private void PassengerAction(object passengerId)
        {
            while (_rideCount < 10)
            {
                _wagonReady.WaitOne();
                lock (_lock)
                {
                    Dispatcher.Invoke(() => StatusTextBlock.Text = $"Passagier {passengerId} steigt ein!");
                    Thread.Sleep(1000);
                    _currentPassengers++;
                    if (_currentPassengers == _wagonCapacity)
                    {
                        _passengersReady.Set();
                    }
                    else
                    {
                        _wagonReady.Set();
                    }
                }
            }
        }

        private void WagonAction()
        {
            while (_rideCount < 10)
            {
                Dispatcher.Invoke(() => StatusTextBlock.Text = "Wagen wartet auf Passagiere...");
                _currentPassengers = 0;
                _wagonReady.Set();

                _passengersReady.WaitOne();
                Dispatcher.Invoke(() => StatusTextBlock.Text = "Wagen fährt los!");
                Thread.Sleep(3000);

                _rideCount++;
                Dispatcher.Invoke(() => StatusTextBlock.Text = $"Fahrt {_rideCount} abgeschlossen!");
                Thread.Sleep(2000);
            }

            Dispatcher.Invoke(() => StatusTextBlock.Text = "Wagen ist abgeschaltet.");
        }
    }
}