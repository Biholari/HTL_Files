import java.sql.*;

public class Main {
    public static void main(String[] args) {
        Connection con = null;
        Statement stmt = null;

        ResultSet rs = null;

        try {
            Class.forName("org.apache.derby.jdbc.EmbeddedDriver");
            con = DriverManager.getConnection("jdbc:derby:src/data");
            stmt = con.createStatement();
            rs = stmt.executeQuery("select * from books");
            while (rs.next()) {
                System.out.println(rs.getString("name"));
            }
            // stmt.executeUpdate("INSERT INTO BOOKS VALUES (2, 'Java für Beginner', 2000, 9.0)");
        } catch (Exception e) {
            System.out.println(e.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (con != null) con.close();
            } catch (Exception e) {
                System.out.println(e.getMessage());
            }
        }
    }
}