import jakarta.xml.bind.JAXBContext;
import jakarta.xml.bind.JAXBException;
import jakarta.xml.bind.Marshaller;
import jakarta.xml.bind.Unmarshaller;

import javax.swing.*;
import java.awt.*;
import java.io.File;

public class MainWindow extends JFrame {
    private final SudokuGrid grid;

    public MainWindow() {
        setTitle("Sudoku");
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setLayout(new BorderLayout());

        grid = new SudokuGrid();
        add(grid, BorderLayout.CENTER);

        JMenuBar menuBar = new JMenuBar();
        JMenu gameMenu = new JMenu("Game");

        JMenuItem newGameItem = new JMenuItem("New");
        newGameItem.addActionListener(e -> startNewGame());
        gameMenu.add(newGameItem);

        JMenuItem importGameItem = new JMenuItem("Import");
        JMenuItem exportGameItem = new JMenuItem("Export");
        importGameItem.addActionListener(e -> importGame());
        exportGameItem.addActionListener(e -> {
            try {
                exportGame();
            } catch (JAXBException ex) {
                throw new RuntimeException(ex);
            }
        });
        gameMenu.add(exportGameItem);
        gameMenu.add(importGameItem);

        menuBar.add(gameMenu);
        setJMenuBar(menuBar);

        setSize(600, 600);
        setLocationRelativeTo(null);
    }

    private void exportGame() throws JAXBException {
        JFileChooser fileChooser = new JFileChooser();
        int returnValue = fileChooser.showSaveDialog(this);
        if (returnValue == JFileChooser.APPROVE_OPTION) {
            File selectedFile = fileChooser.getSelectedFile();

            Sudoku sudoku = grid.getCurrentState();
            JAXBContext context = JAXBContext.newInstance(Sudoku.class);
            Marshaller marshaller = context.createMarshaller();
            marshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);
            marshaller.marshal(sudoku, selectedFile);
        }
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
            grid.loadSudoku(sudoku);
        } catch (Exception e) {
            e.printStackTrace();
            JOptionPane.showMessageDialog(this, "Failed to load Sudoku from file.", "Error", JOptionPane.ERROR_MESSAGE);
        }
    }
}
