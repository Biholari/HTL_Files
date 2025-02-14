using System.ComponentModel;
using System.Runtime.CompilerServices;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Media;

namespace Statuen;

/// <summary>
/// Interaction logic for MainWindow.xaml
/// </summary>
public partial class MainWindow : Window, INotifyPropertyChanged
{
    private int statueNumbers = 10;

    public int StatueNumbers
    {
        get { return statueNumbers; }
        set { statueNumbers = value; NotifyPropertyChanged(); }
    }

    public MainWindow()
    {
        InitializeComponent();

        DataContext = this;

        for (int i = 0; i < statueNumbers; i++)
        {
            ContentArea.ColumnDefinitions.Add(new ColumnDefinition());
            ContentArea.RowDefinitions.Add(new RowDefinition());
        }

        // Fill the whole grid with textblocks
        for (int i = 0; i < statueNumbers; i++)
        {
            for (int j = 0; j < statueNumbers; j++)
            {
                Border border = new()
                {
                    BorderBrush = Brushes.Black,
                    BorderThickness = new Thickness(1)
                };

                TextBlock textBlock = new()
                {
                    Text = "Statue",
                    FontSize = 20,
                    Width = 50,
                    Height = 50,
                    HorizontalAlignment = HorizontalAlignment.Center,
                    VerticalAlignment = VerticalAlignment.Center
                };

                border.Child = textBlock;
                Grid.SetRow(border, i);
                Grid.SetColumn(border, j);
                ContentArea.Children.Add(border);
            }
        }
    }

    bool IsSafe(int[,] board, int row, int col)
    {
        int i, j;
        // Check this row on left side
        for (i = 0; i < col; i++)
            if (board[row, i] == 1)
                return false;
        // Check upper diagonal on left side
        for (i = row, j = col; i >= 0 && j >= 0; i--, j--)
            if (board[i, j] == 1)
                return false;
        // Check lower diagonal on left side
        for (i = row, j = col; j >= 0 && i < statueNumbers; i++, j--)
            if (board[i, j] == 1)
                return false;
        return true;
    }

    bool SolveNQUtils(ref int[,] board, int col)
    {
        if (col >= statueNumbers)
            return true;
        for (int i = 0; i < statueNumbers; i++)
        {
            if (IsSafe(board, i, col))
            {
                board[i, col] = 1;
                if (SolveNQUtils(ref board, col + 1))
                    return true;
                board[i, col] = 0;
            }
        }
        return false;
    }
    void SolveNQ()
    {
        // The "queen" should color the grid cell in green
        int[,] board = new int[statueNumbers, statueNumbers];
        if (SolveNQUtils(ref board, 0) == false)
        {
            MessageBox.Show("Solution does not exist");
            return;
        }
        ColorQueens(board);
    }

    void ColorQueens(int[,] board)
    {
        for (int i = 0; i < statueNumbers; i++)
        {
            for (int j = 0; j < statueNumbers; j++)
            {
                if (board[i, j] == 1)
                {
                    Border border = new()
                    {
                        BorderBrush = Brushes.Black,
                        BorderThickness = new Thickness(1),
                        Background = Brushes.Green
                    };
                    TextBlock textBlock = new()
                    {
                        Text = "Statue",
                        FontSize = 20,
                        HorizontalAlignment = HorizontalAlignment.Center,
                        VerticalAlignment = VerticalAlignment.Center
                    };
                    border.Child = textBlock;
                    Grid.SetRow(border, i);
                    Grid.SetColumn(border, j);
                    ContentArea.Children.Add(border);
                }
            }
        }
    }

    public event PropertyChangedEventHandler? PropertyChanged;
    private void NotifyPropertyChanged([CallerMemberName] String propertyName = "")
    {
        PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
    }

    private void Button_Click(object sender, RoutedEventArgs e)
    {
        // Reset the grid
        ContentArea.Children.Clear();
        ContentArea.ColumnDefinitions.Clear();
        ContentArea.RowDefinitions.Clear();
        for (int i = 0; i < statueNumbers; i++)
        {
            ContentArea.ColumnDefinitions.Add(new ColumnDefinition());
            ContentArea.RowDefinitions.Add(new RowDefinition());
        }
        // Fill the whole grid with textblocks
        for (int i = 0; i < statueNumbers; i++)
        {
            for (int j = 0; j < statueNumbers; j++)
            {
                Border border = new()
                {
                    BorderBrush = Brushes.Black,
                    BorderThickness = new Thickness(1)
                };
                TextBlock textBlock = new()
                {
                    Text = "Statue",
                    FontSize = 20,
                    Width = 50,
                    Height = 50,
                    HorizontalAlignment = HorizontalAlignment.Center,
                    VerticalAlignment = VerticalAlignment.Center
                };
                border.Child = textBlock;
                Grid.SetRow(border, i);
                Grid.SetColumn(border, j);
                ContentArea.Children.Add(border);
            }
        }

        SolveNQ();
    }
}