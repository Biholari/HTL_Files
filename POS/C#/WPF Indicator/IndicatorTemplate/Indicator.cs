using System.ComponentModel;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Media;
using System.Windows.Media.Imaging;

namespace IndicatorTemplate
{
    public class Indicator : Control
    {
        static Indicator()
        {
            DefaultStyleKeyProperty.OverrideMetadata(typeof(Indicator), new FrameworkPropertyMetadata(typeof(Indicator)));
        }

        public event PropertyChangedEventHandler PropertyChanged;

        public static readonly DependencyProperty MinValueProperty =
            DependencyProperty.Register(
                "MinValue",
                typeof(int),
                typeof(Indicator),
                new FrameworkPropertyMetadata(0, FrameworkPropertyMetadataOptions.BindsTwoWayByDefault, UpdateIndicator));

        public static readonly DependencyProperty MaxValueProperty =
            DependencyProperty.Register(
                "MaxValue",
                typeof(int),
                typeof(Indicator),
                new FrameworkPropertyMetadata(287, FrameworkPropertyMetadataOptions.BindsTwoWayByDefault, UpdateIndicator));

        public static readonly DependencyProperty CurrentValueProperty =
            DependencyProperty.Register(
                "CurrentValue",
                typeof(int),
                typeof(Indicator),
                new FrameworkPropertyMetadata(0, FrameworkPropertyMetadataOptions.BindsTwoWayByDefault, UpdateIndicator));


        public int ImageSize
        {
            get { return (int)GetValue(ImageSizeProperty); }
            set { SetValue(ImageSizeProperty, value); }
        }

        public static readonly DependencyProperty ImageSizeProperty =
            DependencyProperty.Register(
                "ImageSize",
                typeof(int),
                typeof(Indicator),
                new FrameworkPropertyMetadata(100, FrameworkPropertyMetadataOptions.BindsTwoWayByDefault, UpdateImageSize));

        private static void UpdateImageSize(DependencyObject d, DependencyPropertyChangedEventArgs e)
        {
            Indicator indicator = (Indicator)d;
            Grid imageGrid = (Grid)indicator.GetTemplateChild("PART_IMAGEPANEL");

            ScaleTransform scale = new()
            {
                ScaleX = indicator.ImageSize,
                ScaleY = indicator.ImageSize
            };

            imageGrid.RenderTransform = scale;
            imageGrid.RenderTransformOrigin = new Point(0.5, 0.5);
        }

        private static void UpdateIndicator(DependencyObject d, DependencyPropertyChangedEventArgs e)
        {
            if (d is Indicator indicator)
            {
                int minValue = indicator.MinValue;
                int maxValue = indicator.MaxValue;
                int currentValue = indicator.CurrentValue;

                Grid imageGrid = (Grid)indicator.GetTemplateChild("PART_IMAGEPANEL");
                Image image = (Image)imageGrid.Children[1];

                double angle = Math.Clamp(currentValue, minValue, maxValue);

                RotateTransform rotateTransform = new(angle)
                {
                    CenterX = 0.5,
                    CenterY = 0.5
                };

                image.RenderTransform = rotateTransform;
                image.RenderTransformOrigin = new Point(0.5, 0.5);
            }
        }

        public int MinValue
        {
            get => (int)GetValue(MinValueProperty);
            set
            {
                SetValue(MinValueProperty, value);
            }
        }

        public int MaxValue
        {
            get => (int)GetValue(MaxValueProperty);
            set
            {
                SetValue(MaxValueProperty, value);
            }
        }

        public int CurrentValue
        {
            get => (int)GetValue(CurrentValueProperty);
            set
            {
                SetValue(CurrentValueProperty, value);
            }
        }

        public override void OnApplyTemplate()
        {
            base.OnApplyTemplate();

            Grid imageGrid = (Grid)GetTemplateChild("PART_IMAGEPANEL");

            Image indicator = new()
            {
                Source = new BitmapImage(new Uri("pack://application:,,,/IndicatorTemplate;component/resources/indicator.png")),
                Stretch = Stretch.Fill,
                Width = 100
            };

            Image rounded = new()
            {
                Source = new BitmapImage(new Uri("pack://application:,,,/IndicatorTemplate;component/resources/rounded.png")),
                Stretch = Stretch.Fill,
                Width = 100
            };

            imageGrid.Children.Add(rounded);
            imageGrid.Children.Add(indicator);
        }
    }
}