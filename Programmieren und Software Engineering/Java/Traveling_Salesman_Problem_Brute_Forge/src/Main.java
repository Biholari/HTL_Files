import java.io.InputStream;
import java.util.ArrayList;

public class Main {
    public static void main(String[] args) {
        try {
            InputStream file = Main.class.getResourceAsStream("StadtKoordinaten.txt");
            CSV_Reader reader = new CSV_Reader(file);

            reader.read();

            CityMap map = new CityMap();
            for (City city : reader.getData()) {
                map.addCity(city);
            }

            ArrayList<Integer> route = map.findShortestRoute();

            // map.printAllRoutes();
            map.printRoute(route);

        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        }
    }
}