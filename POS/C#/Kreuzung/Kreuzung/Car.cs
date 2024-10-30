using System.ComponentModel;

namespace Kreuzung
{
    public class Car : INotifyPropertyChanged
    {
        public int ID { get; set; }
        public string Direction { get; set; }
        private string status;

        public string Status
        {
            get { return status; }
            set
            {
                status = value;
                OnPropertyChanged(nameof(Status));
            }
        }

        public event PropertyChangedEventHandler PropertyChanged;

        public Car(int id, string direction)
        {
            ID = id;
            Direction = direction;
            Status = "Driving";
        }

        protected void OnPropertyChanged(string propertyName)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }

        public void Drive(ICrossroad crossroad)
        {
            Thread.Sleep(new Random().Next(1000, 10000));
            Status = "Waiting";
            crossroad.Cross(this);
            Status = "Crossed";
        }
    }
}
