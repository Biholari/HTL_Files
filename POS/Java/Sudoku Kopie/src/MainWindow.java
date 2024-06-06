import jakarta.xml.bind.JAXBContext;
import jakarta.xml.bind.Unmarshaller;

import javax.swing.*;
import java.awt.*;
import java.io.File;

public class MainWindow extends JFrame {
    private final SudokuController controller;

    public MainWindow() {
        SudokuModel model = new SudokuModel();
        SudokuView view = new SudokuView();

        setTitle("Sudoku");
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setLayout(new BorderLayout());

        controller = new SudokuController(model, view);

        model.attach(view);
        add(view, BorderLayout.CENTER);

        JMenuBar menuBar = new JMenuBar();
        JMenu gameMenu = new JMenu("Game");

        JMenuItem newGameItem = new JMenuItem("New");
        newGameItem.addActionListener(e -> startNewGame());
        gameMenu.add(newGameItem);

        JMenuItem importGameItem = new JMenuItem("Import");
        importGameItem.addActionListener(e -> importGame());
        gameMenu.add(importGameItem);

        menuBar.add(gameMenu);
        setJMenuBar(menuBar);

        setSize(600, 600);
        setLocationRelativeTo(null);
    }

    private void startNewGame() {
        // Add logic to start a new game
    }

    private void importGame() {
        JFileChooser fileChooser = new JFileChooser();
        int returnValue = fileChooser.showOpenDialog(this);
        if (returnValue == JFileChooser.APPROVE_OPTION) {
            File selectedFile = fileChooser.getSelectedFile();
            loadSudokuFromFile(selectedFile);
        }
    }

    private void loadSudokuFromFile(File file) {
        try {
            JAXBContext context = JAXBContext.newInstance(Sudoku.class);
            Unmarshaller unmarshaller = context.createUnmarshaller();
            Sudoku sudoku = (Sudoku) unmarshaller.unmarshal(file);
            controller.loadSudoku(sudoku);
        } catch (Exception e) {
            e.printStackTrace();
            JOptionPane.showMessageDialog(this, "Failed to load Sudoku from file.", "Error", JOptionPane.ERROR_MESSAGE);
        }
    }
}
