using System.ComponentModel;
using System.DirectoryServices.ActiveDirectory;
using System.Numerics;
using System.Runtime.CompilerServices;
using System.Runtime.Intrinsics.X86;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Media;

namespace Statuen;

public struct State(int col, int[] positions)
{
    public int Col { get; set; } = col;
    public int[] Positions { get; set; } = positions;
}

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

    void SolveNQBitMask()
    {
        /*int n = statueNumbers;
        // Use a 64-bit mask. For n queens, allOnes has the first n bits set.
        ulong allOnes = (1UL << n) - 1;
        int[] positions = new int[n];
        bool solutionFound = false;

        // Recursive function that uses bit masks (as 64-bit unsigned integers) to track attacked positions.
        void Solve(ulong colMask, ulong leftDiagMask, ulong rightDiagMask, int colIndex)
        {
            // If all n queens have been placed, a solution is found.
            if (colMask == allOnes)
            {
                solutionFound = true;
                return;
            }

            // Determine all safe positions for the current column.
            ulong safePositions = allOnes & ~(colMask | leftDiagMask | rightDiagMask);
            while (safePositions != 0)
            {
                // Isolate the right-most 1 bit.
                ulong bit = safePositions & (ulong)-(long)safePositions;
                safePositions -= bit;
                int row = BitOperations.TrailingZeroCount(bit);  // row corresponding to the bit

                positions[colIndex] = row;
                Solve(colMask | bit, (leftDiagMask | bit) << 1, (rightDiagMask | bit) >> 1, colIndex + 1);
                if (solutionFound) return;
            }
        }

        Solve(0, 0, 0, 0);

        if (!solutionFound)
        {
            MessageBox.Show("Solution does not exist");
            return;
        }

        // Convert the one-dimensional solution into a 2D board.
        int[,] board = new int[n, n];
        for (int col = 0; col < n; col++)
        {
            int row = positions[col];
            board[row, col] = 1;
        }
        ColorQueens(board);*/
        int n = statueNumbers;
        ulong allOnes = (1UL << n) - 1;
        int[] positions = new int[n];
        bool solutionFound = false;

        // Arrays to simulate recursion
        ulong[] colMasks = new ulong[n + 1];
        ulong[] leftDiagMasks = new ulong[n + 1];
        ulong[] rightDiagMasks = new ulong[n + 1];
        ulong[] safePositions = new ulong[n + 1];

        int colIndex = 0;
        colMasks[0] = 0;
        leftDiagMasks[0] = 0;
        rightDiagMasks[0] = 0;
        safePositions[0] = allOnes;

        while (colIndex >= 0)
        {
            if (safePositions[colIndex] != 0)
            {
                // Isolate the rightmost bit.
                ulong bit = safePositions[colIndex] & (ulong)-(long)safePositions[colIndex];
                safePositions[colIndex] -= bit;
                positions[colIndex] = BitOperations.TrailingZeroCount(bit);

                colMasks[colIndex + 1] = colMasks[colIndex] | bit;
                leftDiagMasks[colIndex + 1] = (leftDiagMasks[colIndex] | bit) << 1;
                rightDiagMasks[colIndex + 1] = (rightDiagMasks[colIndex] | bit) >> 1;

                // If all queens are placed, finish
                if (colMasks[colIndex + 1] == allOnes)
                {
                    solutionFound = true;
                    break;
                }
                colIndex++;
                safePositions[colIndex] = allOnes & ~(colMasks[colIndex] | leftDiagMasks[colIndex] | rightDiagMasks[colIndex]);
            }
            else
            {
                // Backtrack
                colIndex--;
            }
        }

        if (!solutionFound)
        {
            MessageBox.Show("Solution does not exist");
            return;
        }

        // Convert the one-dimensional solution into a 2D board.
        int[,] board = new int[n, n];
        for (int col = 0; col < n; col++)
        {
            int row = positions[col];
            board[row, col] = 1;
        }
        ColorQueens(board);
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

        SolveNQBitMask();
    }
}