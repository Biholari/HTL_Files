using System;
using System.Collections.Generic;
using System.Threading;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Media;

namespace Drei_Raucher
{
    public partial class MainWindow : Window
    {
        private readonly Table _table = new Table();
        private Agent _agent;
        private Smoker _smokerA, _smokerB, _smokerC;
        private Thread _agentThread, _smokerAThread, _smokerBThread, _smokerCThread;
        private bool _isRunning = false;

        public MainWindow()
        {
            InitializeComponent();
        }

        private void StartSimulation(object sender, RoutedEventArgs e)
        {
            // Disable start button, enable stop button
            StartButton.IsEnabled = false;
            StopButton.IsEnabled = true;
            _isRunning = true;

            // Initialize agent and smokers
            _agent = new Agent(UpdateAgentText);
            _smokerA = new Smoker(Ingredient.Tobacco, "Smoker A", UpdateSmokerAText);
            _smokerB = new Smoker(Ingredient.Paper, "Smoker B", UpdateSmokerBText);
            _smokerC = new Smoker(Ingredient.Matches, "Smoker C", UpdateSmokerCText);

            // Start threads
            _agentThread = new Thread(_agent.PlaceIngredients);
            _smokerAThread = new Thread(_smokerA.TryToSmoke);
            _smokerBThread = new Thread(_smokerB.TryToSmoke);
            _smokerCThread = new Thread(_smokerC.TryToSmoke);

            _agentThread.Start(_table);
            _smokerAThread.Start(_table);
            _smokerBThread.Start(_table);
            _smokerCThread.Start(_table);
        }

        private void StopSimulation(object sender, RoutedEventArgs e)
        {
            _isRunning = false;

            // Disable stop button, enable start button
            StartButton.IsEnabled = true;
            StopButton.IsEnabled = false;

            // Stop threads gracefully
            _agentThread?.Abort();
            _smokerAThread?.Abort();
            _smokerBThread?.Abort();
            _smokerCThread?.Abort();
        }

        private void UpdateAgentText(string text)
        {
            Dispatcher.Invoke(() => AgentTextBox.Text = text);
        }

        private void UpdateSmokerAText(string text)
        {
            Dispatcher.Invoke(() => SmokerTobaccoTextBox.Text = text);
        }

        private void UpdateSmokerBText(string text)
        {
            Dispatcher.Invoke(() => SmokerPaperTextBox.Text = text);
        }

        private void UpdateSmokerCText(string text)
        {
            Dispatcher.Invoke(() => SmokerMatchesTextBox.Text = text);
        }
    }
}
