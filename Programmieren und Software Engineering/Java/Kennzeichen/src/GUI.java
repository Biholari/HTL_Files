import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.HashMap;

public class GUI extends JFrame {
    private final JPanel mainPanel = new JPanel();
    private final JPanel bottomPanel = new JPanel();
    private final JPanel topPanel = new JPanel();
    private final JTextField inputField = new JTextField(10);
    private final JButton searchButton = new JButton("Search");
    private final HashMap<String, String> licensePlate;
    private JTextField resultField = new JTextField(10);

    public GUI(HashMap<String, String> licensePlate) {
        this.licensePlate = licensePlate;

        resultField.setEditable(false);
        searchButton.addActionListener(new SearchButtonListener());

        topPanel.setLayout(new GridLayout(1, 2));
        bottomPanel.setLayout(new BorderLayout());
        mainPanel.setLayout(new BorderLayout());

        topPanel.add(inputField);
        topPanel.add(searchButton);
        bottomPanel.add(resultField, BorderLayout.CENTER);
        mainPanel.add(topPanel, BorderLayout.NORTH);
        mainPanel.add(bottomPanel, BorderLayout.CENTER);

        setContentPane(mainPanel);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setSize(new Dimension(400, 100));
        setResizable(false);
        setVisible(true);
    }

    class SearchButtonListener implements ActionListener {
        @Override
        public void actionPerformed(ActionEvent e) {
            String input = inputField.getText();

            if (input.isEmpty()) {
                // Create a popup
                JOptionPane option = new JOptionPane("Please enter a license plate number!", JOptionPane.ERROR_MESSAGE);
                option.createDialog("Error").setVisible(true);
            } else {
                resultField.setText(licensePlate.getOrDefault(input.toUpperCase(), "License plate not found!"));
            }
        }
    }
}
