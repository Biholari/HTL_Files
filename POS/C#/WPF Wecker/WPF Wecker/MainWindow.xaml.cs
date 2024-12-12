using System.Windows;

namespace WPF_Wecker
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
        }

        private void AlarmClockControl_Alarm(object sender, RoutedEventArgs e)
        {
            System.Windows.MessageBox.Show("Alarm finished!");
        }

        private void AlarmClockControl_AlarmSetEvProp(object sender, RoutedEventArgs e)
        {
            System.Windows.MessageBox.Show("Alarm set!");
        }
    }
}