using System.Media;
using System.Windows;
using System.Windows.Controls;

namespace WeckerLibrary
{
    public class AlarmClockControl : Control
    {
        static AlarmClockControl()
        {
            DefaultStyleKeyProperty.OverrideMetadata(typeof(AlarmClockControl), new FrameworkPropertyMetadata(typeof(AlarmClockControl)));
        }

        #region Dependency Properties
        public static readonly DependencyProperty
            AlarmTimeProperty = DependencyProperty.Register(
                "AlarmTime",
                typeof(TimeSpan),
                typeof(AlarmClockControl),
                new PropertyMetadata(new TimeSpan(0, 0, 0, 0), UpdateValue));

        public static readonly DependencyProperty
            AlarmSetProperty = DependencyProperty.Register(
                "AlarmSet",
                typeof(bool),
                typeof(AlarmClockControl),
                new FrameworkPropertyMetadata(false,
                    FrameworkPropertyMetadataOptions.BindsTwoWayByDefault));

        public static readonly DependencyProperty
            CurrentTimeProperty = DependencyProperty.Register(
                "CurrentTime",
                typeof(TimeSpan),
                typeof(AlarmClockControl),
                new FrameworkPropertyMetadata(new TimeSpan(0, 0, 0, 0), null));
        #endregion

        #region Routed Events
        public static readonly RoutedEvent AlarmEvent =
            EventManager.RegisterRoutedEvent(
                "Alarm",
                RoutingStrategy.Bubble,
                typeof(RoutedEventHandler),
                typeof(AlarmClockControl));
        #endregion

        #region Properties
        public TimeSpan AlarmTime
        {
            get { return (TimeSpan)base.GetValue(AlarmTimeProperty); }
            set { base.SetValue(AlarmTimeProperty, value); }
        }
        public bool AlarmSet
        {
            get { return (bool)base.GetValue(AlarmSetProperty); }
            set { base.SetValue(AlarmSetProperty, value); }
        }
        public TimeSpan CurrentTime
        {
            get { return (TimeSpan)base.GetValue(CurrentTimeProperty); }
            set { base.SetValue(CurrentTimeProperty, value); }
        }
        public event RoutedEventHandler Alarm
        {
            add { base.AddHandler(AlarmEvent, value); }
            remove { base.RemoveHandler(AlarmEvent, value); }
        }
        #endregion

        #region Event Callback
        private static void UpdateValue(DependencyObject d, DependencyPropertyChangedEventArgs e)
        {
            AlarmClockControl control = (AlarmClockControl)d;
            control.CurrentTime = (TimeSpan)e.NewValue;
        }
        #endregion

        #region Tick Event
        public void OnDisplayTimerTick(object o, EventArgs args)
        {
            if (this.AlarmSet)
            {
                if (CurrentTime.TotalSeconds <= 0)
                {
                    CurrentTime = AlarmTime;
                    SoundPlayer sp = new(@"c:\windows\media\tada.wav");
                    sp.Play();
                    RaiseEvent(new RoutedEventArgs(AlarmEvent));
                    AlarmSet = false;
                    return;
                }
                CurrentTime = CurrentTime.Add(TimeSpan.FromSeconds(-1));
            }
        }
        #endregion

        #region Template
        System.Windows.Threading.DispatcherTimer displayTimer;
        public override void OnApplyTemplate()
        {
            base.OnApplyTemplate();

            Button StartButton = (Button)this.Template.FindName("StartButton", this);
            Button ResetButton = (Button)this.Template.FindName("ResetButton", this);
            Button SetButton = (Button)this.Template.FindName("SetButton", this);

            StartButton.Click += StartButton_Click;
            ResetButton.Click += ResetButton_Click;
            SetButton.Click += SetButton_Click;

            displayTimer = new System.Windows.Threading.DispatcherTimer
            {
                Interval = new TimeSpan(0, 0, 1)
            };

            displayTimer.Tick += OnDisplayTimerTick;
            displayTimer.Start();
        }
        #endregion

        #region Button Functions
        private void SetButton_Click(object sender, RoutedEventArgs e)
        {
            // Show dialog to set the alarm time
        }

        private void ResetButton_Click(object sender, RoutedEventArgs e)
        {
            CurrentTime = AlarmTime;
        }

        private void StartButton_Click(object sender, RoutedEventArgs e)
        {
            AlarmSet = !AlarmSet;
        }
        #endregion
    }
}