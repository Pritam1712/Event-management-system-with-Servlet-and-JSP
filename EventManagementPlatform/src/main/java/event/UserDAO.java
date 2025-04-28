package event;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class UserDAO {
    private Connection conn;

    // Constructor accepting a database connection
    public UserDAO(Connection conn) {
        this.conn = conn;
    }
    
   // Method to insert a default admin user with a hashed password
    public void insertDefaultAdmin() {
        String username = "admin";
        String password = "admin123"; // Default password (will be hashed)
        String email = "admin@gmail.com"; // Default admin email
        String name = "Admin User"; // Default admin name
        String hashedPassword = hashPassword(password);

        String query = "INSERT INTO users (username, password, email, name, role) VALUES (?, ?, ?, ?, 'admin') ON DUPLICATE KEY UPDATE password=password";

        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, username);
            stmt.setString(2, hashedPassword);
            stmt.setString(3, email);
            stmt.setString(4, name);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public User authenticateUser(String username, String password) throws SQLException {
        String query = "SELECT user_id, username, role, email, name FROM users WHERE username=? AND password=?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, username);
            stmt.setString(2, hashPassword(password)); // Hash the password before checking

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new User(
                        rs.getInt("user_id"),
                        rs.getString("username"),
                        rs.getString("role"),
                        rs.getString("email"),
                        rs.getString("name")
                );
            }
        }
        return null; // No user found
    }

    public boolean registerUser(String username, String password, String email, String name, String role) {
        String query = "INSERT INTO users (username, password, email, name, role) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, username);
            stmt.setString(2, hashPassword(password)); // Hash password before storing
            stmt.setString(3, email);
            stmt.setString(4, name);
            stmt.setString(5, role);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Secure password hashing using SHA-256
    private String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hashedBytes = md.digest(password.getBytes());
            StringBuilder sb = new StringBuilder();
            for (byte b : hashedBytes) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Error hashing password", e);
        }
    }
}
