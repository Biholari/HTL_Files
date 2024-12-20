using System.Windows;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Xml.Serialization;

namespace PixelDraw_2024
{
    public partial class MainWindow : Window
    {
        private static readonly int imageSize = 300;
        private static WriteableBitmap? _wb;
        private static int _bytesPerPixel;
        private static int _stride;
        private static byte[]? _colorArray;

        public MainWindow()
        {
            InitializeComponent();
            _wb = new WriteableBitmap(imageSize, imageSize, 96, 96, PixelFormats.Bgra32, null);
            _bytesPerPixel = (_wb.Format.BitsPerPixel + 7) / 8;
            _stride = _wb.PixelWidth * _bytesPerPixel;
            _colorArray = ConvertColor(Colors.Black);
            drawing.Source = _wb;
        }

        #region Hilfsfunktionen

        private static byte[] ConvertColor(Color color)
        {
            byte[] c = [color.B, color.G, color.R, color.A];
            return c;
        }

        private static Color ConvertColor(byte[] color)
        {
            Color c = new()
            {
                R = color[2],
                G = color[1],
                B = color[0],
                A = color[3]
            };
            return c;
        }

        private static void SetPixel(Color c, int x, int y)
        {
            if (x < _wb.PixelWidth && x > 0 && y < _wb.PixelHeight && y > 0)
            {
                _wb.WritePixels(new Int32Rect(x, y, 1, 1), ConvertColor(c), _stride, 0);
            }
        }

        private static void SetPixel(int x, int y)
        {
            if (x < _wb.PixelWidth && x > 0 && y < _wb.PixelHeight && y > 0)
            {
                _wb.WritePixels(new Int32Rect(x, y, 1, 1), _colorArray, _stride, 0);
            }
        }

        #endregion

        private void Button1_Click(object sender, RoutedEventArgs e)
        {
            for (int i = 10; i <= 290; i++)
            {
                SetPixel(i, 10);
                SetPixel(i, 290);
                SetPixel(10, i);
                SetPixel(290, i);
            }
            //for (int i = 10; i <= 290; i += 20)
            //{
            //    DrawLine(150, 150, 10, i);
            //    DrawLine(150, 150, 290, i);
            //    DrawLine(150, 150, i, 10);
            //    DrawLine(150, 150, i, 290);
            //}
            //for (int i = 10; i <= 145; i += 20)
            //{
            //    DrawCircle(150, 150, i);
            //}

            DrawCatmullRomSpline([new(100, 100), new(150, 200), new(200, 290), new(250, 100)]);
            //DrawCurveThroughPoints([new(100, 100), new(150, 200), new(200, 290), new(250, 100), new(300, 150)]);
        }

        private static void DrawLine(int x1, int y1, int x2, int y2)
        {
            int dx = x2 - x1;
            int dy = y2 - y1;
            int steps = Math.Max(Math.Abs(dx), Math.Abs(dy));

            for (int i = 0; i < steps; i++)
            {
                int x = x1 + (i * dx / steps);
                int y = y1 + (i * dy / steps);
                SetPixel(x, y);
            }
        }

        private static void DrawCircle(int x1, int y1, int radius)
        {
            double circumference = 2 * Math.PI * radius;
            double angle = 2 * Math.PI / circumference;

            for (int i = 0; i < circumference; i++)
            {
                int x = (int)(x1 + radius * Math.Cos(angle * i));
                int y = (int)(y1 + radius * Math.Sin(angle * i));
                SetPixel(x, y);
            }
        }

        #region Bezier
        private static void DrawCatmullRomSpline(IEnumerable<Point> points, int numPoints = 1000)
        {
            Point[] p = points.ToArray();
            if (p.Length < 4)
                throw new ArgumentException("At least four points are required for Catmull-Rom spline");

            foreach (Point point in p) 
            {
                DrawCircle((int)point.X, (int)point.Y, 5);
            }

            for (int i = 0; i < p.Length - 3; i++)
            {
                for (int j = 0; j <= numPoints; j++)
                {
                    double t = (double)j / numPoints;

                    double tt = t * t;
                    double ttt = tt * t;

                    double q1 = -ttt + 2 * tt - t;
                    double q2 = 3 * ttt - 5 * tt + 2;
                    double q3 = -3 * ttt + 4 * tt + t;
                    double q4 = ttt - tt;

                    double tx = 0.5 * (p[i].X * q1 + p[i + 1].X * q2 + p[i + 2].X * q3 + p[i + 3].X * q4);
                    double ty = 0.5 * (p[i].Y * q1 + p[i + 1].Y * q2 + p[i + 2].Y * q3 + p[i + 3].Y * q4);

                    SetPixel((int)tx, (int)ty);
                }
            }
        }
        #endregion
    }
}