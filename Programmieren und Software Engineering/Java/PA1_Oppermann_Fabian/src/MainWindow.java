import javax.swing.*;
import java.awt.*;
import java.util.ArrayList;
import java.util.Collections;

public class MainWindow extends JFrame {
    private JPanel main;
    private JTextField aufgabe4Breite;
    private JTextField aufgabe4Hoehe;
    private JButton aufgabe4Button;
    private JComboBox aufgabe4Einheit;
    private JLabel umfangLabel;
    private JPanel aufgabe3Panel;
    private JButton lastClickedButton;

    MainWindow() {
        setTitle("MainWindow");
        aufgabe3Panel.setLayout(new GridLayout(2, 4));

        ArrayList<Icon> icons = new ArrayList<>();

        for (int i = 1; i <= 8; i++) {
            icons.add(new ImageIcon("images/Chip_" + i + ".png"));
        }

        Collections.shuffle(icons);

        for (Icon icon : icons) {
            JButton button = new JButton(icon);
            button.addActionListener(e -> {
                if (lastClickedButton == null) {
                    lastClickedButton = (JButton) e.getSource();
                } else {
                    Icon lastIcon = lastClickedButton.getIcon();
                    lastClickedButton.setIcon(button.getIcon());
                    button.setIcon(lastIcon);
                    lastClickedButton = null;
                }
            });
            aufgabe3Panel.add(button);
        }

        aufgabe4Button.addActionListener(e -> {
            double breite = Double.parseDouble(aufgabe4Breite.getText());
            double hoehe = Double.parseDouble(aufgabe4Hoehe.getText());
            String einheit = aufgabe4Einheit.getSelectedItem().toString();

            double umfang = 2 * breite + 2 * hoehe;

            umfangLabel.setText(umfang + " " + einheit);
        });
    }

    public static void main(String[] args) {
        MainWindow frame = new MainWindow();
        frame.setContentPane(new MainWindow().main);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setVisible(true);
        frame.pack();
    }
}