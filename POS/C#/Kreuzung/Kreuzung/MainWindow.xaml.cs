using System.Collections.ObjectModel;
using System.Text;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace Kreuzung
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public ObservableCollection<Car> NorthCarsCollection { get; set; } = new ObservableCollection<Car>();
        public ObservableCollection<Car> SouthCarsCollection { get; set; } = new ObservableCollection<Car>();
        public ObservableCollection<Car> EastCarsCollection { get; set; } = new ObservableCollection<Car>();
        public ObservableCollection<Car> WestCarsCollection { get; set; } = new ObservableCollection<Car>();
        public ObservableCollection<Car> MiddleCarsCollection { get; set; } = new ObservableCollection<Car>();
        public ObservableCollection<string> CrossroadTypes { get; set; } = new ObservableCollection<string>
        {
            "Crossroad", "MultilineCroassroad"
        };

        public MainWindow()
        {
            InitializeComponent();
            this.DataContext = this;
        }

        public void StartSimulation(object parameter)
        {
            //int carCount = (int)CarSlider.Value;
            //ICrossroad crossroad = parameter switch
            //{
            //    "Simple" => new SimpleCrossroad(),
            //    "MultiLine" => new MultiLineCroassroad(),
            //    _ => throw new ArgumentException("Invalid parameter")
            //};

            //for (int i = 0; i < carCount; i++)
            //{
            //    var direction = GetRandomDirection();
            //    Car car = new(i, direction);
            //    AddCarToList(car, direction);
            //    Thread carThread = new Thread(() => car.Drive(crossroad));
            //    carThread.Start();
            //}

            NorthCarsCollection.Add(new Car(1, "North"));
        }

        private void AddCarToList(Car car, string direction)
        {
            switch (direction)
            {
                case "North":
                    NorthCarsCollection.Add(car);
                    break;
                case "South":
                    SouthCarsCollection.Add(car);
                    break;
                case "East":
                    EastCarsCollection.Add(car);
                    break;
                case "West":
                    WestCarsCollection.Add(car);
                    break;
            }
        }

        private string GetRandomDirection()
        {
            return new Random().Next(0, 2) == 0 ? "North" : "South";
        }
    }
}