import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class Main {
    private static int count = 1;

    public static void main(String[] args) {
        // Create a new JFrame
        JFrame frame = new JFrame();
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setSize(400, 400);
        frame.setLayout(new BorderLayout());
        frame.getContentPane().setBackground(Color.WHITE);

        // Create a new JButton
        JButton button = new JButton("Click me");
        button.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                // Add a new JLabel each time the button is clicked
                frame.add(new JLabel(Integer.toString(count++)), BorderLayout.SOUTH);
                frame.validate();
                frame.repaint();
            }
        });

        // Add the button to the center of the JFrame
        frame.add(button, BorderLayout.CENTER);

        // Make the JFrame visible
        frame.setVisible(true);
    }
}
