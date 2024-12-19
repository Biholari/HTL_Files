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

            DrawCurveThroughPoints(new Point[]
            {
                new(50, 50),
                new(20, 50),
                new(10, 10),
                new(100, 100)
            });
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

        private static void Lerp(Point p1, Point p2, double t, out Point result)
        {
            result = new Point(p1.X + (p2.X - p1.X) * t, p1.Y + (p2.Y - p1.Y) * t);
        }

        private static void Bezier(Point p0, Point p1, Point p2, Point p3, double t, out Point result)
        {
            Point p01, p12, p23, p012, p123;
            Lerp(p0, p1, t, out p01);
            Lerp(p1, p2, t, out p12);
            Lerp(p2, p3, t, out p23);
            Lerp(p01, p12, t, out p012);
            Lerp(p12, p23, t, out p123);
            Lerp(p012, p123, t, out result);
        }

        private static void DrawCurveThroughPoints(IEnumerable<Point> points)
        {
            Point[] p = points.ToArray();
            for (double t = 0; t < 1; t += 0.001)
            {
                Bezier(p[0], p[1], p[2], p[3], t, out Point result);
                SetPixel((int)result.X, (int)result.Y);
            }
        }

        #endregion
    }
}