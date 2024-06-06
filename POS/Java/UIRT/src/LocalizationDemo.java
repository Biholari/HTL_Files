import javax.swing.*;
import java.awt.*;
import java.util.Locale;

public class LocalizationDemo extends JFrame {
    public LocalizationDemo() {
        setTitle("Localization Demo");
        setLayout(new BorderLayout());
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

        // Create buttons with localization keys
        LocalizedButton okButton = new LocalizedButton("button.ok");
        LocalizedButton cancelButton = new LocalizedButton("button.cancel");
        LocalizedLabel welcomeLabel = new LocalizedLabel("label.welcome");

        // Panel to hold buttons
        JPanel buttonPanel = new JPanel();
        buttonPanel.add(okButton);
        buttonPanel.add(cancelButton);

        JComboBox<String> languageComboBox = getStringJComboBox();

        add(languageComboBox, BorderLayout.NORTH);
        add(welcomeLabel, BorderLayout.CENTER);
        add(buttonPanel, BorderLayout.SOUTH);

        pack();
        setVisible(true);
    }

    private static JComboBox<String> getStringJComboBox() {
        JComboBox<String> languageComboBox = new JComboBox<>(new String[] { "English", "Spanish" });
        languageComboBox.addActionListener(e -> {
            String selectedLanguage = (String) languageComboBox.getSelectedItem();
            Locale locale;
            if ("Spanish".equals(selectedLanguage)) {
                locale = new Locale("es", "ES");
            } else {
                locale = Locale.ENGLISH;
            }
            LocalizationManager.getInstance().setLocale(locale);
        });
        return languageComboBox;
    }

    public static void main(String[] args) {
        SwingUtilities.invokeLater(LocalizationDemo::new);
    }
}
