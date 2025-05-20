using DataModel;
using System.Collections.ObjectModel;
using System.Windows;

namespace Waldwunder_Verwaltung;

/// <summary>
/// Interaction logic for MainWindow.xaml
/// </summary>
public partial class MainWindow : Window
{
    public ObservableCollection<Waldwunder> WaldwunderList { get; set; } = [];

    public MainWindow()
    {
        InitializeComponent();
        DataContext = this;
        LoadData();
    }

    private async void LoadData()
    {
        List<Waldwunder> wonders = await WaldwunderDataService.GetAllWaldwundersAsync();
        WaldwunderList.Clear();
        foreach (Waldwunder wonder in wonders)
        {
            WaldwunderList.Add(wonder);
        }
    }

    private void NewWaldwunder_Click(object sender, RoutedEventArgs e)
    {
        AddWaldwunderDialog dialog = new();

        dialog.ShowDialog();

        if (dialog.DialogResult == true)
        {
            Waldwunder newWaldwunder = dialog.NewWaldwunder;
            try
            {
                WaldwunderDataService.AddNewWaldwunder(newWaldwunder);
            }
            catch (Exception error)
            {
                MessageBox.Show($"Error: {error.Message}", "Error", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }
    }

    private void SearchItem_Click(object sender, RoutedEventArgs e)
    {

    }

    private void ExitMenu_Click(object sender, RoutedEventArgs e)
    {

    }
}