import javax.swing.*;
import java.awt.*;
import java.awt.event.*;

public class BlockPanel extends JPanel {
    private JTextField[][] cells = new JTextField[3][3];

    public BlockPanel(SudokuGrid grid, int blockRow, int blockCol) {
        setLayout(new GridLayout(3, 3));
        for (int row = 0; row < 3; row++) {
            for (int col = 0; col < 3; col++) {
                cells[row][col] = new JTextField();
                cells[row][col].setHorizontalAlignment(JTextField.CENTER);
                cells[row][col].setFont(new Font("Arial", Font.BOLD, 20));
                cells[row][col].setBorder(BorderFactory.createLineBorder(Color.BLACK));
                cells[row][col].setEditable(false);
                cells[row][col].setFocusable(false);
                cells[row][col].addMouseListener(new MouseAdapter() {
                    @Override
                    public void mouseClicked(MouseEvent e) {
                        JTextField source = (JTextField) e.getSource();
                        String input = JOptionPane.showInputDialog("Enter a number (1-9):");
                        if (input != null && input.matches("[1-9]")) {
                            int number = Integer.parseInt(input);
                            int cellRow = getCellRow(source);
                            int cellCol = getCellCol(source);
                            int absRow = blockRow * 3 + cellRow;
                            int absCol = blockCol * 3 + cellCol;
                            if (grid.isValidPlacement(absRow, absCol, number)) {
                                source.setText(input);
                            } else {
                                JOptionPane.showMessageDialog(null, "Invalid placement. Try again.");
                            }
                        }
                    }
                });
                add(cells[row][col]);
            }
        }
    }

    public JTextField[][] getCells() {
        return cells;
    }

    private int getCellRow(JTextField cell) {
        for (int row = 0; row < 3; row++) {
            for (int col = 0; col < 3; col++) {
                if (cells[row][col] == cell) {
                    return row;
                }
            }
        }
        return -1; // should never happen
    }

    private int getCellCol(JTextField cell) {
        for (int row = 0; row < 3; row++) {
            for (int col = 0; col < 3; col++) {
                if (cells[row][col] == cell) {
                    return col;
                }
            }
        }
        return -1; // should never happen
    }
}
