import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.HashMap;

public class CSV_Reader {
    private final InputStream file;
    private ArrayList<City> data;
    CSV_Reader(InputStream file) {
        this.file = file;
        this.data = new ArrayList<>();
    }

    void read() throws IOException {
        BufferedReader reader = new BufferedReader(new InputStreamReader(file));
        String line;

        while ((line = reader.readLine()) != null) {
            String[] splitLine = line.split(";");
            int x = Integer.parseInt(splitLine[1]);
            int y = Integer.parseInt(splitLine[2]);
            data.add(new City(splitLine[0], x, y));
        }
    }

    ArrayList<City> getData() {
        return data;
    }
}
