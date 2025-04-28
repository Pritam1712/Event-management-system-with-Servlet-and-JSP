package event;

public class RSVP {
    private int rsvpId;
    private int eventId;
    private int userId;
    private String customerName;
    private String email;
    private String status;

    // Default constructor
    public RSVP() {
        this.rsvpId = 0;
        this.eventId = 0;
        this.userId = 0;
        this.customerName = null;
        this.email = null;
        this.status = null;
    }

    // Constructor with all fields
    public RSVP(int rsvpId, int eventId, int userId, String status) {
        this.rsvpId = rsvpId;
        this.eventId = eventId;
        this.userId = userId;
        this.status = status;
    }

    // Constructor with all fields (including customer name and email)
    public RSVP(int rsvpId, int eventId, int userId, String customerName, String email, String status) {
        this.rsvpId = rsvpId;
        this.eventId = eventId;
        this.userId = userId;
        this.customerName = customerName;
        this.email = email;
        this.status = status;
    }

    // Getters and Setters
    public int getRsvpId() {
        return rsvpId;
    }

    public void setRsvpId(int rsvpId) {
        this.rsvpId = rsvpId;
    }

    public int getEventId() {
        return eventId;
    }

    public void setEventId(int eventId) {
        this.eventId = eventId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
