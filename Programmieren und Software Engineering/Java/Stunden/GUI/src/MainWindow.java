import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class MainWindow extends JFrame {
    private int count = 0;

    class ButtonAction implements ActionListener {
        @Override
        public void actionPerformed(ActionEvent e) {
            count++;
            JButton b = (JButton) e.getSource();
            b.setText("Clicked: " + count);
        }
    }

    ActionListener Clicked = new ActionListener() {
        @Override
        public void actionPerformed(ActionEvent e) {
            count++;
            JButton b = (JButton) e.getSource();
            b.setText("Clicked: " + count);
        }
    };

    public MainWindow() {
        JPanel MainContainer = new JPanel();
        JPanel GroupOne = new JPanel();
        JPanel GroupTwo = new JPanel();
        JLabel Label = new JLabel("StartButton");
        ImageIcon icon = new ImageIcon(getClass().getResource("add-square.png"), "Bild eines Quadrats");
        JButton KlickButton1 = new JButton(new ImageIcon(icon.getImage().getScaledInstance(50, 50, Image.SCALE_SMOOTH)));
        JButton KlickButton2 = new JButton("Click");
        JButton KlickButton3 = new JButton("Click");
        JButton KlickButton4 = new JButton("Click");
        JButton KlickButton5 = new JButton("Click");
        JButton KlickButton6 = new JButton("Click");

        KlickButton1.getAccessibleContext().setAccessibleName(("Bild eines Quadrates"));

        KlickButton6.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                JOptionPane.showMessageDialog(MainContainer, "Clicked");
            }
        });


        GroupOne.add(Label);
        GroupOne.add(KlickButton1);

        GroupTwo.add(KlickButton2);
        GroupTwo.add(KlickButton3);
        GroupTwo.add(KlickButton4);
        GroupTwo.add(KlickButton5);
        GroupTwo.add(KlickButton6);

        setContentPane(MainContainer);
        setTitle("Swing Demo");
        setSize(400, 300);
        setDefaultCloseOperation(EXIT_ON_CLOSE);

        GroupTwo.setLayout(new GridLayout(2, 2));
        MainContainer.setLayout(new BorderLayout());

        MainContainer.add(GroupOne, BorderLayout.NORTH);
        MainContainer.add(GroupTwo, BorderLayout.CENTER);

        // pack();
    }

    public static void main(String[] args) {
        MainWindow mw = new MainWindow();
        mw.setVisible(true);
    }
}
