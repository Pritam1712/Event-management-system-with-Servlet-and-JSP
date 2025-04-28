package event;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EventDAO {
    private Connection conn;

    // Constructor to inject DB connection
    public EventDAO(Connection conn) {
        this.conn = conn;
    }

    // Default constructor (optional, if needed)
    public EventDAO() {
        this.conn = DBConnection.getConnection();
    }

    // Fetch all events
    public List<Event> getAllEvents() throws SQLException {
        List<Event> events = new ArrayList<>();
        String query = "SELECT * FROM events";
        
        try (var stmt = conn.createStatement();
             var rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                events.add(new Event(
                        rs.getInt("event_id"),
                        rs.getString("event_name"),
                        rs.getDate("event_date"),
                        rs.getString("location"),
                        rs.getString("description"),
                        rs.getString("event_type"),
                        rs.getTimestamp("created_at"),
                        rs.getTimestamp("updated_at")
                ));
            }
        }
        return events;
    }

    // Get event by ID
    public Event getEventById(int eventId) {
        String query = "SELECT * FROM events WHERE event_id = ?";
        if (!DBConnection.isConnectionActive()) {
            this.conn = DBConnection.getConnection();
        }

        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, eventId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new Event(
                            rs.getInt("event_id"),
                            rs.getString("event_name"),
                            rs.getDate("event_date"),
                            rs.getString("location"),
                            rs.getString("description"),
                            rs.getString("event_type"),
                            rs.getTimestamp("created_at"),
                            rs.getTimestamp("updated_at")
                    );
                }
            }
        } catch (SQLException e) {
            System.err.println("❌ Error fetching event by ID: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    // Insert a new event
    public boolean insertEvent(String eventName, Date eventDate, String location, String description, String eventType) {
        String query = "INSERT INTO events (event_name, event_date, location, description, event_type, created_at, updated_at) VALUES (?, ?, ?, ?, ?, NOW(), NOW())";
        if (!DBConnection.isConnectionActive()) {
            this.conn = DBConnection.getConnection();
        }

        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, eventName);
            stmt.setDate(2, new java.sql.Date(eventDate.getTime()));
            stmt.setString(3, location);
            stmt.setString(4, description);
            stmt.setString(5, eventType);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("❌ Error inserting event: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    // Update an existing event
    public boolean updateEvent(int eventId, String eventName, Date eventDate, String location, String description, String eventType) {
        String query = "UPDATE events SET event_name=?, event_date=?, location=?, description=?, event_type=?, updated_at=NOW() WHERE event_id=?";
        if (!DBConnection.isConnectionActive()) {
            this.conn = DBConnection.getConnection();
        }

        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, eventName);
            stmt.setDate(2, new java.sql.Date(eventDate.getTime()));
            stmt.setString(3, location);
            stmt.setString(4, description);
            stmt.setString(5, eventType);
            stmt.setInt(6, eventId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("❌ Error updating event: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    // Delete an event by event_id
    public boolean deleteEvent(int eventId) {
        String query = "DELETE FROM events WHERE event_id = ?";
        if (!DBConnection.isConnectionActive()) {
            this.conn = DBConnection.getConnection();
        }

        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, eventId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("❌ Error deleting event: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    // Get filtered events by search query, type, or date
    public List<Event> getFilteredEvents(String searchQuery, String eventType, String eventDate) {
        List<Event> eventList = new ArrayList<>();
        StringBuilder query = new StringBuilder("SELECT * FROM events WHERE 1=1");

        if (!DBConnection.isConnectionActive()) {
            this.conn = DBConnection.getConnection();
        }

        List<Object> parameters = new ArrayList<>();

        if (searchQuery != null && !searchQuery.isEmpty()) {
            query.append(" AND event_name LIKE ?");
            parameters.add("%" + searchQuery + "%");
        }
        if (eventType != null && !eventType.isEmpty()) {
            query.append(" AND event_type = ?");
            parameters.add(eventType);
        }
        if (eventDate != null && !eventDate.isEmpty()) {
            query.append(" AND event_date = ?");
            parameters.add(eventDate);
        }

        try (PreparedStatement stmt = conn.prepareStatement(query.toString())) {
            for (int i = 0; i < parameters.size(); i++) {
                stmt.setObject(i + 1, parameters.get(i));
            }
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    eventList.add(new Event(
                            rs.getInt("event_id"),
                            rs.getString("event_name"),
                            rs.getString("event_type"),
                            rs.getString("location"),
                            rs.getDate("event_date")
                    ));
                }
            }
        } catch (SQLException e) {
            System.err.println("❌ Error fetching filtered events: " + e.getMessage());
            e.printStackTrace();
        }
        return eventList;
    }
}
