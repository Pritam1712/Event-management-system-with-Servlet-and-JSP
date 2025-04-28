package event;

import java.sql.Timestamp;

public class Booking {
    private int bookingId;
    private int userId;
    private int eventId;
    private int numberOfPeople;
    private Timestamp bookingDate;

    // Constructors
    public Booking() {}
    
    public Booking(int userId, int eventId, int numberOfPeople) {
        this.userId = userId;
        this.eventId = eventId;
        this.numberOfPeople = numberOfPeople;
    }

    // Getters and Setters
    public int getBookingId() { return bookingId; }
    public void setBookingId(int bookingId) { this.bookingId = bookingId; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public int getEventId() { return eventId; }
    public void setEventId(int eventId) { this.eventId = eventId; }

    public int getNumberOfPeople() { return numberOfPeople; }
    public void setNumberOfPeople(int numberOfPeople) { this.numberOfPeople = numberOfPeople; }

    public Timestamp getBookingDate() { return bookingDate; }
    public void setBookingDate(Timestamp bookingDate) { this.bookingDate = bookingDate; }
}
