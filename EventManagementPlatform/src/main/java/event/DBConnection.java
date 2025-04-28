package event;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    private static Connection conn = null;
    private static final String URL = "jdbc:mysql://localhost:3306/event_management";
    private static final String USER = "root";
    private static final String PASSWORD = "root";

    // Private constructor to prevent instantiation
    private DBConnection() {}

    // Synchronized method to get connection
    public static synchronized Connection getConnection() {
        try {
            // Check if connection is null or closed
            if (conn == null || conn.isClosed()) {
                Class.forName("com.mysql.cj.jdbc.Driver"); // Ensure MySQL driver is loaded
                conn = DriverManager.getConnection(URL, USER, PASSWORD);
                System.out.println("✅ Database Connection Established Successfully!");
            }
        } catch (ClassNotFoundException e) {
            System.err.println("❌ Database Driver Not Found: " + e.getMessage());
            e.printStackTrace();
        } catch (SQLException e) {
            System.err.println("❌ Error Connecting to Database: " + e.getMessage());
            e.printStackTrace();
        }
        return conn;
    }

    // Method to manually close the connection
    public static synchronized void closeConnection() {
        if (conn != null) {
            try {
                conn.close();
                System.out.println("✅ Database Connection Closed Successfully!");
            } catch (SQLException e) {
                System.err.println("❌ Error Closing Database Connection: " + e.getMessage());
                e.printStackTrace();
            }
        }
    }

    // Method to check if connection is active
    public static synchronized boolean isConnectionActive() {
        try {
            return conn != null && !conn.isClosed();
        } catch (SQLException e) {
            System.err.println("⚠️ Error Checking Connection Status: " + e.getMessage());
            return false;
        }
    }
}
