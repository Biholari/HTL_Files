import javax.swing.*;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;

public class SudokuController {
    private final SudokuModel model;
    private final SudokuView view;

    public SudokuController(SudokuModel model, SudokuView view) {
        this.model = model;
        this.view = view;
        attachListeners();
    }

    private void attachListeners() {
        JTextField[][] cells = view.getCells();
        for (int row = 0; row < 9; row++) {
            for (int col = 0; col < 9; col++) {
                int finalRow = row;
                int finalCol = col;
                cells[row][col].addMouseListener(new MouseAdapter() {
                    @Override
                    public void mouseClicked(MouseEvent e) {
                        String input = JOptionPane.showInputDialog("Enter a number (1-9):");
                        if (input != null && input.matches("[1-9]")) {
                            int number = Integer.parseInt(input);
                            if (model.isValidPlacement(finalRow, finalCol, number)) {
                                model.setCellValue(finalRow, finalCol, number);
                            } else {
                                JOptionPane.showMessageDialog(null, "Invalid placement. Try again.");
                            }
                        }
                    }
                });
            }
        }
    }

    public void loadSudoku(Sudoku sudoku) {
        model.loadSudoku(sudoku);
    }

    public Sudoku getCurrentState() {
        return model.getCurrentState();
    }
}
