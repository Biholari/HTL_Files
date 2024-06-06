import javax.swing.*;
import java.awt.*;
import java.util.List;

public class SudokuGrid extends JPanel {
    private final BlockPanel[][] blocks = new BlockPanel[3][3];
    private final JTextField[][] cells = new JTextField[9][9];

    public SudokuGrid() {
        setLayout(new GridLayout(3, 3));
        for (int row = 0; row < 3; row++) {
            for (int col = 0; col < 3; col++) {
                blocks[row][col] = new BlockPanel(this, row, col);
                blocks[row][col].setBorder(BorderFactory.createLineBorder(Color.BLACK, 2));
                add(blocks[row][col]);
            }
        }

        // Initialize cells array
        for (int blockRow = 0; blockRow < 3; blockRow++) {
            for (int blockCol = 0; blockCol < 3; blockCol++) {
                for (int cellRow = 0; cellRow < 3; cellRow++) {
                    for (int cellCol = 0; cellCol < 3; cellCol++) {
                        cells[blockRow * 3 + cellRow][blockCol * 3 + cellCol] = blocks[blockRow][blockCol].getCells()[cellRow][cellCol];
                    }
                }
            }
        }
    }

    public BlockPanel[][] getBlocks() {
        return blocks;
    }

    public JTextField[][] getCells() {
        return cells;
    }

    public boolean isValidPlacement(int absRow, int absCol, int number) {
        return isRowValid(absRow, number) &&
                isColumnValid(absCol, number) &&
                isBlockValid(absRow, absCol, number);
    }

    private boolean isRowValid(int absRow, int number) {
        for (int col = 0; col < 9; col++) {
            String text = cells[absRow][col].getText();
            if (!text.isEmpty() && Integer.parseInt(text) == number) {
                return false;
            }
        }
        return true;
    }

    private boolean isColumnValid(int absCol, int number) {
        for (int row = 0; row < 9; row++) {
            String text = cells[row][absCol].getText();
            if (!text.isEmpty() && Integer.parseInt(text) == number) {
                return false;
            }
        }
        return true;
    }

    private boolean isBlockValid(int absRow, int absCol, int number) {
        int blockRow = absRow / 3;
        int blockCol = absCol / 3;
        for (int row = 0; row < 3; row++) {
            for (int col = 0; col < 3; col++) {
                String text = cells[blockRow * 3 + row][blockCol * 3 + col].getText();
                if (!text.isEmpty() && Integer.parseInt(text) == number) {
                    return false;
                }
            }
        }
        return true;
    }

    public void loadSudoku(Sudoku sudoku) {
        List<Field> fields = sudoku.getFields();
        for (Field field : fields) {
            String number = field.getNumber();
            int x = field.getX();
            int y = field.getY();
            cells[y][x].setText(number);
        }
    }

    public Sudoku getCurrentState() {
        Sudoku sudoku = new Sudoku();
        for (int row = 0; row < 9; row++) {
            for (int col = 0; col < 9; col++) {
                String text = cells[row][col].getText();
                if (!text.isEmpty()) {
                    Field field = new Field();
                    field.setX(col);
                    field.setY(row);
                    field.setNumber(text);
                    sudoku.getFields().add(field);
                }
            }
        }

        sudoku.setFields(sudoku.getFields());
        return sudoku;
    }
}
