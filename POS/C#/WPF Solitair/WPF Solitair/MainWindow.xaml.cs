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

namespace WPF_Solitair;

/// <summary>
/// Interaction logic for MainWindow.xaml
/// </summary>
public partial class MainWindow : Window
{
    private SolitaireGame _game;
    private const int CellSize = 50;
    private UIElement _draggedElement;
    private Point _dragStartPoint;
    private int _fromRow, _fromCol;

    public MainWindow()
    {
        InitializeComponent();
        _game = new SolitaireGame();
        _game.GameStateChanged += Game_GameStateChanged;
        BoardTypeComboBox.SelectionChanged += BoardTypeComboBox_SelectionChanged;
        InitializeBoard();
        UpdateStatusText();
    }

    private void InitializeBoard()
    {
        BoardGrid.Children.Clear();
        BoardGrid.RowDefinitions.Clear();
        BoardGrid.ColumnDefinitions.Clear();

        const int boardSize = 9;

        // Create grid rows and columns
        for (int i = 0; i < boardSize; i++)
        {
            BoardGrid.RowDefinitions.Add(new RowDefinition { Height = new GridLength(CellSize) });
            BoardGrid.ColumnDefinitions.Add(new ColumnDefinition { Width = new GridLength(CellSize) });
        }

        // Create cells
        for (int row = 0; row < boardSize; row++)
        {
            for (int col = 0; col < boardSize; col++)
            {
                CellState state = _game.GetCellState(row, col);
                if (state != CellState.OutOfBounds)
                {
                    // Create cell background
                    Rectangle cellBackground = new Rectangle
                    {
                        Fill = new SolidColorBrush(Colors.SandyBrown),
                        Stroke = new SolidColorBrush(Colors.Black),
                        StrokeThickness = 1
                    };
                    Grid.SetRow(cellBackground, row);
                    Grid.SetColumn(cellBackground, col);
                    BoardGrid.Children.Add(cellBackground);

                    // Create peg if needed
                    if (state == CellState.Peg)
                    {
                        Ellipse peg = CreatePeg();
                        Grid.SetRow(peg, row);
                        Grid.SetColumn(peg, col);
                        BoardGrid.Children.Add(peg);
                    }
                }
            }
        }
    }

    private Ellipse CreatePeg()
    {
        Ellipse peg = new Ellipse
        {
            Width = CellSize * 0.8,
            Height = CellSize * 0.8,
            Fill = new SolidColorBrush(Colors.DarkGoldenrod),
            Stroke = new SolidColorBrush(Colors.Black),
            StrokeThickness = 1,
            Margin = new Thickness(CellSize * 0.1),
            Tag = "Peg"
        };

        peg.MouseDown += Peg_MouseDown;
        peg.MouseMove += Peg_MouseMove;
        peg.MouseUp += Peg_MouseUp;

        return peg;
    }

    private void Peg_MouseDown(object sender, MouseButtonEventArgs e)
    {
        if (e.LeftButton == MouseButtonState.Pressed)
        {
            _draggedElement = sender as UIElement;
            _dragStartPoint = e.GetPosition(null);
            _fromRow = Grid.GetRow(_draggedElement);
            _fromCol = Grid.GetColumn(_draggedElement);
            _draggedElement.CaptureMouse();
            e.Handled = true;
        }
    }

    private void Peg_MouseMove(object sender, MouseEventArgs e)
    {
        if (_draggedElement != null)
        {
            Point currentPosition = e.GetPosition(null);
            Vector offset = currentPosition - _dragStartPoint;

            // Apply translation transform
            TranslateTransform transform = new TranslateTransform
            {
                X = offset.X,
                Y = offset.Y
            };
            _draggedElement.RenderTransform = transform;
        }
    }

    private void Peg_MouseUp(object sender, MouseButtonEventArgs e)
    {
        if (_draggedElement != null)
        {
            _draggedElement.ReleaseMouseCapture();
            Point dropPosition = e.GetPosition(BoardGrid);

            // Calculate target grid cell
            int toRow = (int)(dropPosition.Y / CellSize);
            int toCol = (int)(dropPosition.X / CellSize);

            // Check if the move is valid
            if (_game.CanMovePeg(_fromRow, _fromCol, toRow, toCol))
            {
                // Move the peg in the game model
                _game.MovePeg(_fromRow, _fromCol, toRow, toCol);
                // Board will be refreshed by the GameStateChanged event
            }
            else
            {
                // Reset peg position
                _draggedElement.RenderTransform = null;
            }

            _draggedElement = null;
        }
    }

    private void BoardTypeComboBox_SelectionChanged(object sender, SelectionChangedEventArgs e)
    {
        if (BoardTypeComboBox.SelectedIndex >= 0)
        {
            BoardType selectedType = (BoardType)BoardTypeComboBox.SelectedIndex;
            _game.SetupBoard(selectedType);
            InitializeBoard();
            UpdateStatusText();
        }
    }

    private void NewGameButton_Click(object sender, RoutedEventArgs e)
    {
        BoardType currentType = (BoardType)BoardTypeComboBox.SelectedIndex;
        _game.SetupBoard(currentType);
        InitializeBoard();
        UpdateStatusText();
    }

    private void Game_GameStateChanged(object sender, EventArgs e)
    {
        // Refresh the board
        Application.Current.Dispatcher.Invoke(() =>
        {
            InitializeBoard();
            UpdateStatusText();
            CheckGameState();
        });
    }

    private void UpdateStatusText()
    {
        int pegCount = _game.GetPegCount();
        PegCountText.Text = $"Pegs: {pegCount}";
    }

    private void CheckGameState()
    {
        if (_game.IsGameWon())
        {
            StatusText.Text = "Congratulations! You won the game!";
            MessageBox.Show("Congratulations! You've won the game with only one peg remaining!", "Victory", MessageBoxButton.OK, MessageBoxImage.Information);
        }
        else if (_game.IsGameLost())
        {
            StatusText.Text = "Game over! No more valid moves.";
            MessageBox.Show("Game over! No more valid moves available.", "Game Over", MessageBoxButton.OK, MessageBoxImage.Information);
        }
        else
        {
            StatusText.Text = "Ready to play! Move pegs by dragging them.";
        }
    }
}