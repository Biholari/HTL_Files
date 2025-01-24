using System.ComponentModel;
using System.Diagnostics;
using System.Windows;
using System.Windows.Input;
using System.Windows.Media;

namespace WPF_System_Monitor
{
    public partial class MainWindow : Window
    {
        private Thread? monitorThread;
        private bool isRunning = true;
        private readonly List<double> cpuHistory = [];
        private readonly List<double> memoryHistory = [];
        private const int MAX_HISTORY_POINTS = 50;

        public MainWindow()
        {
            InitializeComponent(); 
            InitializeMonitoring();
        }

        private void InitializeMonitoring()
        {
            monitorThread = new Thread(MonitoringLoop)
            {
                IsBackground = true
            };
            monitorThread.Start();
        }

        private void MonitoringLoop()
        {
            var cpuCounter = new PerformanceCounter("Processor", "% Processor Time", "_Total");
            var memCounter = new PerformanceCounter("Memory", "% Committed Bytes In Use");

            while (isRunning)
            {
                var cpuValue = cpuCounter.NextValue();
                var memValue = memCounter.NextValue();

                // Update UI
                Dispatcher.Invoke(() =>
                {
                    UpdateIndicators(cpuValue, memValue);
                    UpdateGraphs(cpuValue, memValue);
                });

                Thread.Sleep(1000);
            }
        }

        private void UpdateIndicators(float cpu, float memory)
        {
            CpuIndicator.CurrentValue = cpu;
            CpuIndicator.Maximum = 100;

            MemoryIndicator.CurrentValue = memory;
            MemoryIndicator.Maximum = 100;
        }

        private void UpdateGraphs(float cpu, float memory)
        {
            cpuHistory.Add(cpu);
            memoryHistory.Add(memory);

            if (cpuHistory.Count > MAX_HISTORY_POINTS)
            {
                cpuHistory.RemoveAt(0);
                memoryHistory.RemoveAt(0);
            }

            // Update graph points
            var cpuPoints = new PointCollection();
            var memPoints = new PointCollection();

            for (int i = 0; i < cpuHistory.Count; i++)
            {
                double x = (GraphPanel.ActualWidth / MAX_HISTORY_POINTS) * i;
                double cpuY = GraphPanel.ActualHeight - (cpuHistory[i] / 100.0 * GraphPanel.ActualHeight);
                double memY = GraphPanel.ActualHeight - (memoryHistory[i] / 100.0 * GraphPanel.ActualHeight);

                cpuPoints.Add(new Point(x, cpuY));
                memPoints.Add(new Point(x, memY));
            }

            CpuGraph.Points = cpuPoints;
            MemoryGraph.Points = memPoints;
        }

        private void MainGrid_MouseLeftButtonDown(object sender, MouseButtonEventArgs e)
        {
            DragMove();
        }

        private void ShowIndicator_Click(object sender, RoutedEventArgs e)
        {
            IndicatorPanel.Visibility = Visibility.Visible;
            GraphPanel.Visibility = Visibility.Collapsed;
        }

        private void ShowGraphs_Click(object sender, RoutedEventArgs e)
        {
            IndicatorPanel.Visibility = Visibility.Collapsed;
            GraphPanel.Visibility = Visibility.Visible;
        }

        private void ToggleWindow_Click(object sender, RoutedEventArgs e)
        {
            Visibility = Visibility == Visibility.Visible ? Visibility.Hidden : Visibility.Visible;
        }

        private void Exit_Click(object sender, RoutedEventArgs e)
        {
            Close();
        }

        protected override void OnClosing(CancelEventArgs e)
        {
            base.OnClosing(e);
            isRunning = false;
        }
    }
}