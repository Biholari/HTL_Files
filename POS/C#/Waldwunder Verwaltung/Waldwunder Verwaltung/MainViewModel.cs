using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Runtime.CompilerServices;
using System.Windows.Input;

namespace Waldwunder_Verwaltung;

public class MainViewModel : INotifyPropertyChanged
{
    private readonly WaldwunderDataService _wonderService;
    private readonly ImageService _imageService;

    private ObservableCollection<DataModel.Waldwunder> _wonders;
    private DataModel.Waldwunder _selectedWonder;
    private string _searchKeyword;
    private string _searchType;
    private float _searchLatitude;
    private float _searchLongitude;

    public ObservableCollection<DataModel.Waldwunder> Wonders
    {
        get => _wonders;
        set
        {
            _wonders = value;
            OnPropertyChanged();
        }
    }

    public DataModel.Waldwunder SelectedWonder
    {
        get => _selectedWonder;
        set
        {
            _selectedWonder = value;
            OnPropertyChanged();
            CommandManager.InvalidateRequerySuggested();
        }
    }

    public string SearchKeyword
    {
        get => _searchKeyword;
        set
        {
            _searchKeyword = value;
            OnPropertyChanged();
        }
    }

    public string SearchType
    {
        get => _searchType;
        set
        {
            _searchType = value;
            OnPropertyChanged();
        }
    }

    public float SearchLatitude
    {
        get => _searchLatitude;
        set
        {
            _searchLatitude = value;
            OnPropertyChanged();
        }
    }

    public float SearchLongitude
    {
        get => _searchLongitude;
        set
        {
            _searchLongitude = value;
            OnPropertyChanged();
        }
    }

    public void SelectWonderByIdOnMap(int id)
    {
        SelectedWonder = Wonders.FirstOrDefault(w => w.Id == id);
    }

    public ObservableCollection<string> WonderTypes { get; } = [];

    public ICommand NewWonderCommand { get; }
    public ICommand SearchByKeywordCommand { get; }
    public ICommand SearchByTypeCommand { get; }
    public ICommand SearchByLocationCommand { get; }
    public ICommand ShowWonderDetailsCommand { get; }

    private async Task LoadTypesAsync()
    {
        var types = await _wonderService.GetAllTypes();
        foreach (var type in types)
        {
            WonderTypes.Add(type);
        }
    }

    private void ShowNewWonderDialog()
    {
        var viewModel = new NewWonderViewModel(_wonderService);
        var dialog = new Views.NewWonderDialog
        {
            DataContext = viewModel
        };

        if (dialog.ShowDialog() == true)
        {
            // Refresh the current search
            if (!string.IsNullOrEmpty(SearchKeyword))
            {
                SearchByKeywordAsync();
            }
            else if (!string.IsNullOrEmpty(SearchType))
            {
                SearchByTypeAsync();
            }
            else if (SearchLatitude != 0 || SearchLongitude != 0)
            {
                SearchByLocationAsync();
            }
        }
    }

    private async Task SearchByKeywordAsync()
    {
        if (string.IsNullOrWhiteSpace(SearchKeyword))
            return;

        var results = await _wonderService.SearchByKeyword(SearchKeyword);
        UpdateWonders(results);
    }

    private async Task SearchByTypeAsync()
    {
        if (string.IsNullOrWhiteSpace(SearchType))
            return;

        var results = await _wonderService.SearchByType(SearchType);
        UpdateWonders(results);
    }

    private async Task SearchByLocationAsync()
    {
        var results = await _wonderService.SearchByLocation(SearchLatitude, SearchLongitude);
        UpdateWonders(results);
    }

    private void UpdateWonders(List<DataModel.Waldwunder> results)
    {
        Wonders.Clear();
        foreach (var wonder in results)
        {
            Wonders.Add(wonder);
        }
    }

    private void ShowWonderDetails()
    {
        if (SelectedWonder == null)
            return;

        var viewModel = new WonderDetailsViewModel(SelectedWonder, _imageService);
        var dialog = new Views.WonderDetailsDialog
        {
            DataContext = viewModel
        };

        dialog.ShowDialog();
    }

    #region INotifyPropertyChanged

    public event PropertyChangedEventHandler? PropertyChanged;
    protected virtual void OnPropertyChanged([CallerMemberName] string propertyName = null)
    {
        PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
    }

    #endregion
}
