using DataModel;
using System.Windows;

namespace Waldwunder_Verwaltung;

public partial class AddWaldwunderDialog : Window
{
    public Waldwunder NewWaldwunder { get; private set; }

    public AddWaldwunderDialog()
    {
        NewWaldwunder = new Waldwunder();

        InitializeComponent();
        DataContext = this;
    }

    private void OkButton_Click(object sender, RoutedEventArgs e)
    {
        DialogResult = true;
    }

    private void CancelButton_Click(object sender, RoutedEventArgs e)
    {
        DialogResult = false;
        Close();
    }
}
