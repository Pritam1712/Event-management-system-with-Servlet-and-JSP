package event;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookingDAO {
    private Connection conn;

    public BookingDAO(Connection conn) {
        this.conn = conn;
    }

    // Create Booking
    public boolean createBooking(Booking booking) {
        String sql = "INSERT INTO bookings (user_id, event_id, number_of_people) VALUES (?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, booking.getUserId());
            stmt.setInt(2, booking.getEventId());
            stmt.setInt(3, booking.getNumberOfPeople());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Get Bookings by Event ID
    public List<Booking> getBookingsByEventId(int eventId) {
        List<Booking> bookings = new ArrayList<>();
        String sql = "SELECT * FROM bookings WHERE event_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, eventId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Booking booking = new Booking();
                booking.setBookingId(rs.getInt("booking_id"));
                booking.setUserId(rs.getInt("user_id"));
                booking.setEventId(rs.getInt("event_id"));
                booking.setNumberOfPeople(rs.getInt("number_of_people"));
                booking.setBookingDate(rs.getTimestamp("booking_date"));
                bookings.add(booking);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bookings;
    }

    // Delete Booking by Booking ID
    public boolean deleteBooking(int bookingId) {
        String sql = "DELETE FROM bookings WHERE booking_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, bookingId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
