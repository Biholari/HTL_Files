import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import java.io.File;
import java.util.*;
import java.util.Timer;

public class MemoryGame extends JFrame {
    private final int totalPlayers;
    private final int totalPairs;
    HashMap<String, Integer> players = new HashMap<>();
    Card lastClickedButton;
    JPanel gameLabel = new JPanel();
    Timer deltaTime = null;

    public MemoryGame(int totalPlayers, int totalPairs) throws HeadlessException {
        this.totalPlayers = totalPlayers;
        this.totalPairs = totalPairs;

        for (int i = 0; i < totalPlayers; i++) {
            players.put(JOptionPane.showInputDialog("Player " + (i + 1) + " name: "), 0);
        }

        initUI();
        startNewGame();
    }

    private void startNewGame() {

    }

    private void initUI() {
        setTitle("Memory Game");
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setLayout(new BorderLayout());

        gameLabel.setLayout(new GridLayout(totalPairs / 2, totalPairs / 2 + 1));

        /* Add all cards to the center of the frame */
        File[] iconFiles = new File("data/").listFiles();
        ArrayList<File> iconsList = new ArrayList<>(Arrays.asList(iconFiles));
        Collections.shuffle(iconsList);

        ArrayList<File> usedIcons = new ArrayList<>();
        for (int i = 0; i < totalPairs; ++i) {
            usedIcons.add(iconsList.get(i));
            usedIcons.add(iconsList.get(i)); // Add each icon twice for pairs
        }

        Collections.shuffle(usedIcons);

        for (int i = 0; i < totalPairs * 2; ++i) {
            Card card = new Card(usedIcons.get(i).getName());
            card.addActionListener(new MemoryListener());
            gameLabel.add(card);
        }

        add(gameLabel, BorderLayout.CENTER);

        pack();
        setLocationRelativeTo(null);
        setVisible(true);
    }

    class MemoryListener implements ActionListener {
        @Override
        public void actionPerformed(ActionEvent e) {
            if (lastClickedButton == null) {
                lastClickedButton = (Card) e.getSource();
                lastClickedButton.flip();
                return;
            }

            Card card = (Card) e.getSource();
            card.flip();
            gameLabel.repaint();
            gameLabel.revalidate();

            if (card.getName().equals(lastClickedButton.getName())) {
                lastClickedButton.setEnabled(false);
                card.setEnabled(false);
            } else {
                lastClickedButton.flip();
                card.flip();
                gameLabel.repaint();
                gameLabel.revalidate();
            }
            lastClickedButton = null;
        }
    }
}
