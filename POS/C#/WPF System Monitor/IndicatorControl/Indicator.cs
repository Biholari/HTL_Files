using System.Windows;
using System.Windows.Controls;
using System.Windows.Media;
using System.Windows.Media.Imaging;

namespace IndicatorControl
{
    public class Indicator : Control
    {
        private Image? meterIndicator;

        static Indicator()
        {
            DefaultStyleKeyProperty.OverrideMetadata(typeof(Indicator), new FrameworkPropertyMetadata(typeof(Indicator)));
        }


        public static readonly DependencyProperty CurrentValueProperty =
            DependencyProperty.Register(
                "CurrentValue",
                typeof(double),
                typeof(Indicator),
                new PropertyMetadata(0.0, null));

        public double CurrentValue
        {
            get => (double)GetValue(CurrentValueProperty);
            set => SetValue(CurrentValueProperty, value);
        }


        public static readonly DependencyProperty MinimumProperty =
            DependencyProperty.Register(
                "Minimum",
                typeof(double),
                typeof(Indicator),
                new PropertyMetadata(0.0, OnRangePropertyChanged));
        public double Minimum
        {
            get => (double)GetValue(MinimumProperty);
            set => SetValue(MinimumProperty, value);
        }

        public static readonly DependencyProperty MaximumProperty =
            DependencyProperty.Register(
                "Maximum",
                typeof(double),
                typeof(Indicator),
                new PropertyMetadata(0.0, OnRangePropertyChanged));
        public double Maximum
        {
            get => (double)GetValue(MaximumProperty);
            set => SetValue(MaximumProperty, value);
        }

        private static void OnRangePropertyChanged(DependencyObject d, DependencyPropertyChangedEventArgs e)
        {
            if (d is Indicator indicator)
                indicator.UpdatePointerRotation();
        }

        public override void OnApplyTemplate()
        {
            base.OnApplyTemplate();

            Image meterBackground = (Image)Template.FindName("PART_METERBACKGROUND", this);
            meterIndicator = (Image)Template.FindName("PART_METERINDICATOR", this);

            if (meterBackground != null && meterIndicator != null)
            {
                meterBackground.Source = new BitmapImage(new Uri("pack://application:,,,/IndicatorControl;component/Resources/MeterBackground.png"));
                meterBackground.Width = 100;
                meterBackground.Height = 100;

                meterIndicator.Source = new BitmapImage(new Uri("pack://application:,,,/IndicatorControl;component/Resources/MeterPointer.png"));
                meterIndicator.Width = 100;
                meterIndicator.Height = 100;
                meterIndicator.RenderTransformOrigin = new Point(0.5, 0.5);
                meterIndicator.RenderTransform = new RotateTransform();

                UpdatePointerRotation();
            }
        }

        protected override void OnPropertyChanged(DependencyPropertyChangedEventArgs e)
        {
            base.OnPropertyChanged(e);

            if (e.Property == CurrentValueProperty)
            {
                UpdatePointerRotation();
            }
        }

        private void UpdatePointerRotation()
        {
            if (meterIndicator?.RenderTransform is RotateTransform transform)
            {
                double range = Maximum - Minimum;
                double normalizedValue = (CurrentValue - Minimum) / range;
                double angle = normalizedValue * 287.0;
                transform.Angle = angle;
            }
        }
    }
}