using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace Solitaire
{
    /// <summary>
    /// Interaktionslogik für MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
        }

        Ellipse moving = null;
        private Point clickPosition;

        private void Ellipse_MouseLeftButtonDown(object sender, MouseButtonEventArgs e)
        {
            moving = (Ellipse)sender;
            clickPosition = e.GetPosition(this);
            moving.IsHitTestVisible = false;
            DragDrop.DoDragDrop(moving, moving, DragDropEffects.All);
        }

        private void Border_Drop(object sender, DragEventArgs e)
        {
            if (moving != null)
            {
                int col = Grid.GetColumn((UIElement)sender);
                int row = Grid.GetRow((UIElement)sender);
                //check if move is allowed
                Grid.SetColumn(moving, col);
                Grid.SetRow(moving, row);

                moving.RenderTransform = null;
                moving.IsHitTestVisible = true;
                moving = null;
            }
        }

        private void Grid_PreviewDragOver(object sender, DragEventArgs e)
        {
            if (moving != null)
            {
                Point currentPosition = e.GetPosition(this);

                var transform = moving.RenderTransform as TranslateTransform;
                if (transform == null)
                {
                    transform = new TranslateTransform();
                    moving.RenderTransform = transform;
                }

                transform.X = currentPosition.X - clickPosition.X;
                transform.Y = currentPosition.Y - clickPosition.Y;
            }
        }

        private void Grid_PreviewMouseMove(object sender, MouseEventArgs e)
        {
            if (moving != null)
            {
                moving.RenderTransform = null;
                moving.IsHitTestVisible = true;
                moving = null;
            }
        }
    }
}
