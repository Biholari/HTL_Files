import java.beans.PropertyChangeListener;
import java.beans.PropertyChangeSupport;
import java.util.Locale;
import java.util.ResourceBundle;

public class LocalizationManager {
    private static LocalizationManager instance;
    private ResourceBundle resourceBundle;
    private Locale locale;
    private final PropertyChangeSupport support;

    private LocalizationManager() {
        support = new PropertyChangeSupport(this);
        setLocale(Locale.getDefault());
    }

    public static LocalizationManager getInstance() {
        if (instance == null) {
            instance = new LocalizationManager();
        }
        return instance;
    }

    public void setLocale(Locale locale) {
        Locale oldLocale = this.locale;
        this.locale = locale;
        this.resourceBundle = ResourceBundle.getBundle("MessagesBundle", locale);
        support.firePropertyChange("locale", oldLocale, locale);
    }

    public String getString(String key) {
        return resourceBundle.getString(key);
    }

    public Locale getLocale() {
        return locale;
    }

    public void addPropertyChangeListener(PropertyChangeListener pcl) {
        support.addPropertyChangeListener(pcl);
    }

    public void removePropertyChangeListener(PropertyChangeListener pcl) {
        support.removePropertyChangeListener(pcl);
    }
}
