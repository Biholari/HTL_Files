import javax.swing.*;
import java.beans.PropertyChangeEvent;
import java.beans.PropertyChangeListener;

public class LocalizedLabel extends JLabel implements PropertyChangeListener {
    private final String key;

    public LocalizedLabel(String key) {
        this.key = key;
        LocalizationManager.getInstance().addPropertyChangeListener(this);
        updateText();
    }

    private void updateText() {
        setText(LocalizationManager.getInstance().getString(key));
    }

    @Override
    public void propertyChange(PropertyChangeEvent evt) {
        if ("locale".equals(evt.getPropertyName())) {
            updateText();
        }
    }
}
