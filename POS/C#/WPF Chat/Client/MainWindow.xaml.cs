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

namespace Client
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public static readonly RoutedCommand LoginCommand = new();
        public static readonly RoutedCommand JoinCommand = new();
        public static readonly RoutedCommand CreateCommand = new();
        public static readonly RoutedCommand PrivateMsgCommand = new();

        public MainWindow()
        {
            InitializeComponent();
            CommandBindings.Add(new CommandBinding(LoginCommand, LoginCommand_Executed));
            CommandBindings.Add(new CommandBinding(JoinCommand, JoinCommand_Executed));
            CommandBindings.Add(new CommandBinding(CreateCommand, CreateCommand_Executed));
            CommandBindings.Add(new CommandBinding(PrivateMsgCommand, PrivateMsgCommand_Executed));
        }

        private void LoginCommand_Executed(object sender, ExecutedRoutedEventArgs e)
        {
            // Handle login command
        }

        private void JoinCommand_Executed(object sender, ExecutedRoutedEventArgs e)
        {
            // Handle join command
        }

        private void CreateCommand_Executed(object sender, ExecutedRoutedEventArgs e)
        {
            // Handle create command
        }

        private void PrivateMsgCommand_Executed(object sender, ExecutedRoutedEventArgs e)
        {
            // Handle private message command
        }
    }
}