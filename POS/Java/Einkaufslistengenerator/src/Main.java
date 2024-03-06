import javax.swing.*;
import java.io.File;

public class Main {
    public static void main(String[] args) {
        CsvMapper csvm = new CsvMapper(new File("resources/Produkte.csv"));
        csvm.loadCsv();

        SwingUtilities.invokeLater(() -> {
            MainWindow mw = new MainWindow();
            mw.setVisible(true);

            mw.setData(csvm.getMappedFile());
        });
    }
}