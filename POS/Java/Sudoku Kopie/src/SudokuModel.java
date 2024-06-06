import java.util.ArrayList;
import java.util.List;

public class SudokuModel {
    private final int[][] grid = new int[9][9];
    private final List<Observer> observers = new ArrayList<>();

    public void attach(Observer observer) {
        observers.add(observer);
    }

    public void detach(Observer observer) {
        observers.remove(observer);
    }

    private void notifyObservers(int row, int col, int value) {
        for (Observer observer : observers) {
            observer.update(row, col, value);
        }
    }

    public boolean isValidPlacement(int row, int col, int number) {
        return isRowValid(row, number) && isColumnValid(col, number) && isBlockValid(row, col, number);
    }

    private boolean isRowValid(int row, int number) {
        for (int col = 0; col < 9; col++) {
            if (grid[row][col] == number) {
                return false;
            }
        }
        return true;
    }

    private boolean isColumnValid(int col, int number) {
        for (int row = 0; row < 9; row++) {
            if (grid[row][col] == number) {
                return false;
            }
        }
        return true;
    }

    private boolean isBlockValid(int row, int col, int number) {
        int startRow = (row / 3) * 3;
        int startCol = (col / 3) * 3;
        for (int i = 0; i < 3; i++) {
            for (int j = 0; j < 3; j++) {
                if (grid[startRow + i][startCol + j] == number) {
                    return false;
                }
            }
        }
        return true;
    }

    public void setCellValue(int row, int col, int value) {
        grid[row][col] = value;
        notifyObservers(row, col, value);
    }

    public int getCellValue(int row, int col) {
        return grid[row][col];
    }

    public void loadSudoku(Sudoku sudoku) {
        List<Field> fields = sudoku.getFields();
        for (Field field : fields) {
            int number = Integer.parseInt(field.getNumber());
            int x = field.getX();
            int y = field.getY();
            grid[y][x] = number;
            notifyObservers(y, x, number);
        }
    }

    public Sudoku getCurrentState() {
        Sudoku sudoku = new Sudoku();
        List<Field> fields = new ArrayList<>();
        for (int row = 0; row < 9; row++) {
            for (int col = 0; col < 9; col++) {
                if (grid[row][col] != 0) {
                    fields.add(new Field(String.valueOf(grid[row][col]), col, row));
                }
            }
        }
        sudoku.setFields(fields);
        return sudoku;
    }
}
