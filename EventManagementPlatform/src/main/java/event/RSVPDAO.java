package event;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RSVPDAO {
    private Connection conn;

    public RSVPDAO(Connection conn) {
        this.conn = conn;
    }

    // Retrieve RSVPs by event ID
    public List<RSVP> getRSVPsByEventId(int eventId) {
        List<RSVP> rsvpList = new ArrayList<>();
        String query = "SELECT r.rsvp_id, u.username AS customer_name, u.email, r.status " +
                       "FROM rsvps r " +
                       "JOIN users u ON r.user_id = u.user_id " +
                       "WHERE r.event_id = ?";

        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, eventId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                RSVP rsvp = new RSVP();
                rsvp.setRsvpId(rs.getInt("rsvp_id"));
                rsvp.setCustomerName(rs.getString("customer_name"));
                rsvp.setEmail(rs.getString("email"));
                rsvp.setStatus(rs.getString("status"));
                rsvpList.add(rsvp);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rsvpList;
    }


    // Add or update RSVP entry
    public boolean addRSVP(int eventId, int userId, String status) {
        String query = "INSERT INTO rsvps (event_id, user_id, status) VALUES (?, ?, ?) " +
                       "ON DUPLICATE KEY UPDATE status = VALUES(status)";  // This handles both insert and update

        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, eventId);
            stmt.setInt(2, userId);
            stmt.setString(3, status);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error adding/updating RSVP: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }


    
 // Retrieve RSVPs by user ID
    public List<RSVP> getRSVPsByUserId(int userId) {
        List<RSVP> rsvps = new ArrayList<>();
        String query = "SELECT * FROM rsvps WHERE user_id = ?";

        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                rsvps.add(new RSVP(
                    rs.getInt("rsvp_id"),
                    rs.getInt("event_id"),
                    rs.getInt("user_id"),
                    rs.getString("status")
                ));
            }
        } catch (SQLException e) {
            System.err.println("Error fetching RSVPs by user: " + e.getMessage());
            e.printStackTrace();
        }
        return rsvps;
    }

}
