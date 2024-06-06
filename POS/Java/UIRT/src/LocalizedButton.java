import javax.swing.JButton;
import java.beans.PropertyChangeEvent;
import java.beans.PropertyChangeListener;

public class LocalizedButton extends JButton implements PropertyChangeListener {
    private final String key;

    public LocalizedButton(String key) {
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
