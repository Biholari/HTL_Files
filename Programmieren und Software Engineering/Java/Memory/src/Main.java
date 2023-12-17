import javax.swing.*;
import java.awt.*;

public class Main {
    public static void main(String[] args) throws HeadlessException {
        SwingUtilities.invokeLater(() -> {
            int totalPlayers;
            int totalPairs;

            do {
                totalPlayers = Integer.parseInt(JOptionPane.showInputDialog("How many players: "));
            } while (totalPlayers < 1 || totalPlayers > 4);

            do {
                totalPairs = Integer.parseInt(JOptionPane.showInputDialog("How many pairs: "));
            } while (totalPairs < 1 || totalPairs > 10);

            new MemoryGame(totalPlayers, totalPairs);
        });
    }
}