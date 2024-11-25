using System;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Diagnostics;
using System.Linq;
using System.Linq.Expressions;
using System.Threading;
using System.Windows;
using System.Windows.Threading;

namespace Sorting
{
    /// <summary>
    /// Interaktionslogik für MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window, INotifyPropertyChanged
    {
        public ObservableCollection<int> sortList = new ObservableCollection<int>();
        private readonly Random rand = new Random();
        private int _checks = 0;
        private int _swaps = 0;
        private int _selected = -1;

        public ObservableCollection<int> List
        {
            set
            {
                sortList = value;
                NotifyPropertyChanged(x => x.List);
            }
            get
            {
                return sortList;
            }
        }
        public int Checks
        {
            set
            {
                _checks = value;
                NotifyPropertyChanged(x => x.Checks);
            }
            get
            {
                return _checks;
            }
        }
        public int Swaps
        {
            set
            {
                _swaps = value;
                NotifyPropertyChanged(x => x.Swaps);
            }
            get
            {
                return _swaps;
            }
        }

        public int Selected
        {
            set
            {
                _selected = value;
                NotifyPropertyChanged(x => x.Selected);
            }
            get
            {
                return _selected;
            }
        }

        public MainWindow()
        {
            InitializeComponent();
            for (int i = 0; i < 50; i++)
            {
                sortList.Add(rand.Next(200));
            }
            Checks = 0;
            Swaps = 0;
            this.DataContext = this;
        }

        private void Start_Click(object sender, RoutedEventArgs e)
        {
            int size = sortList.Count;
            Checks = 0;
            Swaps = 0;
            ThreadPool.QueueUserWorkItem(o =>
            {
                bool swapped = false;
                do
                {
                    swapped = false;
                    for (int i = 0; i < size - 1; ++i, Selected = i)
                    {
                        try
                        {
                            Dispatcher.Invoke(DispatcherPriority.Normal, new DispatcherOperationCallback(delegate
                              {
                                  Checks++;
                                  if (sortList[i] > sortList[i + 1])
                                  {
                                      Swaps++;
                                      (sortList[i + 1], sortList[i]) = (sortList[i], sortList[i + 1]);
                                      swapped = true;
                                  }
                                  return null;
                              }), null);
                        }
                        catch (Exception ex)
                        {
                            Debug.WriteLine(ex.ToString());
                        }
                        Thread.Sleep(50);
                    }
                    size = size - 1;
                } while (swapped == true);

            });
        }

        private void CocktailSort_Click(object sender, RoutedEventArgs e)
        {
            int size = sortList.Count;
            Checks = 0;
            Swaps = 0;
            ThreadPool.QueueUserWorkItem(o =>
            {
                bool swapped = false;
                do
                {
                    swapped = false;
                    for (int i = 0; i < size - 1; ++i)
                    {
                        int currentIndex = i;
                        try
                        {
                            Dispatcher.Invoke(DispatcherPriority.Normal, new DispatcherOperationCallback(delegate
                              {
                                  Selected = currentIndex;
                                  Checks++;
                                  if (sortList[currentIndex] > sortList[currentIndex + 1])
                                  {
                                      Swaps++;
                                      (sortList[currentIndex + 1], sortList[currentIndex]) = (sortList[currentIndex], sortList[currentIndex + 1]);
                                      swapped = true;
                                  }
                                  return null;
                              }), null);
                        }
                        catch (Exception ex)
                        {
                            Debug.WriteLine(ex.ToString());
                        }
                        Thread.Sleep(50);
                    }
                    if (!swapped)
                    {
                        break;
                    }
                    swapped = false;
                    for (int i = size - 1; i > 0; --i)
                    {
                        int currentIndex = i;
                        try
                        {
                            Dispatcher.Invoke(DispatcherPriority.Normal, new DispatcherOperationCallback(delegate
                              {
                                  Selected = currentIndex;
                                  Checks++;
                                  if (sortList[currentIndex] < sortList[currentIndex - 1])
                                  {
                                      Swaps++;
                                      (sortList[currentIndex - 1], sortList[currentIndex]) = (sortList[currentIndex], sortList[currentIndex - 1]);
                                      swapped = true;
                                  }
                                  return null;
                              }), null);
                        }
                        catch (Exception ex)
                        {
                            Debug.WriteLine(ex.ToString());
                        }
                        Thread.Sleep(50);
                    }
                    size = size - 1;
                } while (swapped == true);
            });
        }

        private void SelectionSort_Click(object sender, RoutedEventArgs e)
        {
            int size = sortList.Count;
            Checks = 0;
            Swaps = 0;
            ThreadPool.QueueUserWorkItem(o =>
            {
                for (int i = 0; i < size - 1; ++i, Selected = i)
                {
                    int min = i;
                    for (int j = i + 1; j < size; ++j)
                    {
                        try
                        {
                            Dispatcher.Invoke(DispatcherPriority.Normal, new DispatcherOperationCallback(delegate
                              {
                                  Checks++;
                                  if (sortList[j] < sortList[min])
                                  {
                                      min = j;
                                  }
                                  return null;
                              }), null);
                        }
                        catch (Exception ex)
                        {
                            Debug.WriteLine(ex.ToString());
                        }
                        Thread.Sleep(50);
                    }
                    if (min != i)
                    {
                        try
                        {
                            Dispatcher.Invoke(DispatcherPriority.Normal, new DispatcherOperationCallback(delegate
                              {
                                  Swaps++;
                                  (sortList[i], sortList[min]) = (sortList[min], sortList[i]);
                                  return null;
                              }), null);
                        }
                        catch (Exception ex)
                        {
                            Debug.WriteLine(ex.ToString());
                        }
                    }
                }
            });
        }

        private void InsertionSort_Click(object sender, RoutedEventArgs e)
        {
            int size = sortList.Count;
            Checks = 0;
            Swaps = 0;
            ThreadPool.QueueUserWorkItem(o =>
            {
                for (int i = 1; i < size; ++i, Selected = i)
                {
                    int key = sortList[i];
                    int j = i - 1;
                    while (j >= 0 && sortList[j] > key)
                    {
                        try
                        {
                            Dispatcher.Invoke(DispatcherPriority.Normal, new DispatcherOperationCallback(delegate
                              {
                                  Checks++;
                                  Swaps++;
                                  sortList[j + 1] = sortList[j];
                                  j = j - 1;
                                  return null;
                              }), null);
                        }
                        catch (Exception ex)
                        {
                            Debug.WriteLine(ex.ToString());
                        }
                        Thread.Sleep(50);
                    }
                    try
                    {
                        Dispatcher.Invoke(DispatcherPriority.Normal, new DispatcherOperationCallback(delegate
                          {
                              sortList[j + 1] = key;
                              return null;
                          }), null);
                    }
                    catch (Exception ex)
                    {
                        Debug.WriteLine(ex.ToString());
                    }
                }
            });
        }

        private void CombSort_Click(object sender, RoutedEventArgs e)
        {
            int size = sortList.Count;
            Checks = 0;
            Swaps = 0;
            ThreadPool.QueueUserWorkItem(o =>
            {
                int gap = size;
                bool swapped = true;
                while (gap != 1 || swapped == true)
                {
                    gap = (gap * 10) / 13;
                    if (gap < 1)
                    {
                        gap = 1;
                    }
                    swapped = false;
                    for (int i = 0; i < size - gap; ++i, Selected = i)
                    {
                        try
                        {
                            Dispatcher.Invoke(DispatcherPriority.Normal, new DispatcherOperationCallback(delegate
                              {
                                  Checks++;
                                  if (sortList[i] > sortList[i + gap])
                                  {
                                      Swaps++;
                                      (sortList[i], sortList[i + gap]) = (sortList[i + gap], sortList[i]);
                                      swapped = true;
                                  }
                                  return null;
                              }), null);
                        }
                        catch (Exception ex)
                        {
                            Debug.WriteLine(ex.ToString());
                        }
                        Thread.Sleep(50);
                    }
                }
            });
        }

        private void ShellSort_Click(object sender, RoutedEventArgs e)
        {
            /*int size = sortList.Count;
            Checks = 0;
            Swaps = 0;
            ThreadPool.QueueUserWorkItem(o =>
            {
                for (int gap = size / 2; gap > 0; gap /= 2)
                {
                    for (int i = gap; i < size; ++i, Selected = i)
                    {
                        int temp = sortList[i];
                        int j;
                        for (j = i; j >= gap; j -= gap)
                        {
                            try
                            {
                                Dispatcher.Invoke(DispatcherPriority.Normal, new DispatcherOperationCallback(delegate
                                  {
                                      Checks++;
                                      if (sortList[j - gap] > temp)
                                      {
                                          Swaps++;
                                          sortList[j] = sortList[j - gap];
                                      }
                                      else
                                      {
                                          break;
                                      }
                                      return null;
                                  }), null);
                            }
                            catch (Exception ex)
                            {
                                Debug.WriteLine(ex.ToString());
                            }
                            Thread.Sleep(50);
                        }
                        try
                        {
                            Dispatcher.Invoke(DispatcherPriority.Normal, new DispatcherOperationCallback(delegate
                              {
                                  sortList[j] = temp;
                                  return null;
                              }), null);
                        }
                        catch (Exception ex)
                        {
                            Debug.WriteLine(ex.ToString());
                        }
                    }
                }
            });*/
        }

        private void HeapSort_Click(object sender, RoutedEventArgs e)
        {
            int size = sortList.Count;
            Checks = 0;
            Swaps = 0;
            ThreadPool.QueueUserWorkItem(o =>
            {
                for (int i = size / 2 - 1; i >= 0; i--)
                {
                    Heapify(size, i);
                }
                for (int i = size - 1; i > 0; i--)
                {
                    try
                    {
                        Dispatcher.Invoke(DispatcherPriority.Normal, new DispatcherOperationCallback(delegate
                          {
                              Swaps++;
                              (sortList[0], sortList[i]) = (sortList[i], sortList[0]);
                              Heapify(i, 0);
                              return null;
                          }), null);
                    }
                    catch (Exception ex)
                    {
                        Debug.WriteLine(ex.ToString());
                    }
                    Thread.Sleep(50);
                }
            });
        }

        private void Heapify(int size, int i)
        {
            int largest = i;
            int l = 2 * i + 1;
            int r = 2 * i + 2;
            if (l < size && sortList[l] > sortList[largest])
            {
                largest = l;
            }
            if (r < size && sortList[r] > sortList[largest])
            {
                largest = r;
            }
            if (largest != i)
            {
                try
                {
                    Dispatcher.Invoke(DispatcherPriority.Normal, new DispatcherOperationCallback(delegate
                      {
                          Swaps++;
                          (sortList[i], sortList[largest]) = (sortList[largest], sortList[i]);
                          Heapify(size, largest);
                          return null;
                      }), null);
                }
                catch (Exception ex)
                {
                    Debug.WriteLine(ex.ToString());
                }
                Thread.Sleep(50);
            }
        }

        private void MergeSort_Click(object sender, RoutedEventArgs e)
        {
            int size = sortList.Count;
            Checks = 0;
            Swaps = 0;
            ThreadPool.QueueUserWorkItem(o =>
            {
                MergeSort(0, size - 1);
            });
        }

        private void MergeSort(int l, int r)
        {
            if (l < r)
            {
                int m = l + (r - l) / 2;
                MergeSort(l, m);
                MergeSort(m + 1, r);
                Merge(l, m, r);
            }
        }

        private void Merge(int l, int m, int r)
        {
            int n1 = m - l + 1;
            int n2 = r - m;
            int[] L = new int[n1];
            int[] R = new int[n2];
            for (int i2 = 0; i2 < n1; ++i2)
            {
                L[i2] = sortList[l + i2];
            }
            for (int j2 = 0; j2 < n2; ++j2)
            {
                R[j2] = sortList[m + 1 + j2];
            }
            int i = 0;
            int j = 0;
            int k = l;
            while (i < n1 && j < n2)
            {
                try
                {
                    Dispatcher.Invoke(DispatcherPriority.Normal, new DispatcherOperationCallback(delegate
                      {
                          Checks++;
                          if (L[i] <= R[j])
                          {
                              Swaps++;
                              sortList[k] = L[i];
                              i++;
                          }
                          else
                          {
                              Swaps++;
                              sortList[k] = R[j];
                              j++;
                          }
                          k++;
                          return null;
                      }), null);
                }
                catch (Exception ex)
                {
                    Debug.WriteLine(ex.ToString());
                }
                Thread.Sleep(50);
            }
            while (i < n1)
            {
                try
                {
                    Dispatcher.Invoke(DispatcherPriority.Normal, new DispatcherOperationCallback(delegate
                      {
                          Swaps++;
                          sortList[k] = L[i];
                          i++;
                          k++;
                          return null;
                      }), null);
                }
                catch (Exception ex)
                {
                    Debug.WriteLine(ex.ToString());
                }
                Thread.Sleep(50);
            }
            while (j < n2)
            {
                try
                {
                    Dispatcher.Invoke(DispatcherPriority.Normal, new DispatcherOperationCallback(delegate
                      {
                          Swaps++;
                          sortList[k] = R[j];
                          j++;
                          k++;
                          return null;
                      }), null);
                }
                catch (Exception ex)
                {
                    Debug.WriteLine(ex.ToString());
                }
                Thread.Sleep(50);
            }
        }

        private void QuickSort_Click(object sender, RoutedEventArgs e)
        {
            int size = sortList.Count;
            Checks = 0;
            Swaps = 0;
            ThreadPool.QueueUserWorkItem(o =>
            {
                QuickSort(0, size - 1);
            });
        }

        private void QuickSort(int low, int high)
        {
            if (low < high)
            {
                int pi = Partition(low, high);
                QuickSort(low, pi - 1);
                QuickSort(pi + 1, high);
            }
        }

        private int Partition(int low, int high)
        {
            int pivot = sortList[high];
            int i = low - 1;
            for (int j = low; j < high; ++j)
            {
                try
                {
                    Dispatcher.Invoke(DispatcherPriority.Normal, new DispatcherOperationCallback(delegate
                      {
                          Checks++;
                          if (sortList[j] < pivot)
                          {
                              i++;
                              Swaps++;
                              (sortList[i], sortList[j]) = (sortList[j], sortList[i]);
                          }
                          return null;
                      }), null);
                }
                catch (Exception ex)
                {
                    Debug.WriteLine(ex.ToString());
                }
                Thread.Sleep(50);
            }
            try
            {
                Dispatcher.Invoke(DispatcherPriority.Normal, new DispatcherOperationCallback(delegate
                  {
                      Swaps++;
                      (sortList[i + 1], sortList[high]) = (sortList[high], sortList[i + 1]);
                      return null;
                  }), null);
            }
            catch (Exception ex)
            {
                Debug.WriteLine(ex.ToString());
            }
            return i + 1;
        }

        private void ShuffleBtn_Click(object sender, RoutedEventArgs e)
        {
            var rnd = new Random();
            var shuffledList = sortList
                                    .Select(x => (x, rnd.Next()))
                                    .OrderBy(x => x.Item2)
                                    .Select(x => x.x)
                                    .ToList();
            sortList.Clear();
            foreach (var item in shuffledList)
            {
                sortList.Add(item);
            }
        }

        private void Reverse_Click(object sender, RoutedEventArgs e)
        {
            int size = sortList.Count;
            Checks = 0;
            Swaps = 0;
            ThreadPool.QueueUserWorkItem(o =>
            {
                bool swapped = false;
                do
                {
                    swapped = false;
                    for (int i = 0; i < size - 1; ++i, Selected = i)
                    {
                        try
                        {
                            Dispatcher.Invoke(DispatcherPriority.Normal, new DispatcherOperationCallback(delegate
                              {
                                  Checks++;
                                  if (sortList[i] < sortList[i + 1])
                                  {
                                      Swaps++;
                                      (sortList[i + 1], sortList[i]) = (sortList[i], sortList[i + 1]);
                                      swapped = true;
                                  }
                                  return null;
                              }), null);
                        }
                        catch (Exception ex)
                        {
                            Debug.WriteLine(ex.ToString());
                        }
                        Thread.Sleep(50);
                    }
                    size = size - 1;
                } while (swapped == true);

            });
        }

        #region INotifyPropertyChanged Member

        public event PropertyChangedEventHandler PropertyChanged;
        private void NotifyPropertyChanged<TValue>(Expression<Func<MainWindow, TValue>> propertySelector)
        {
            if (PropertyChanged != null)
            {
                MemberExpression memberExpression = propertySelector.Body as System.Linq.Expressions.MemberExpression;
                if (memberExpression != null)
                {
                    PropertyChanged(this, new PropertyChangedEventArgs(memberExpression.Member.Name));
                }
            }
        }
        #endregion
    }
}
