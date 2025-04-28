package event;

import java.sql.Timestamp;
import java.util.Date;

public class Event {
    private int eventId;
    private String eventName;
    private Date eventDate;
    private String location;
    private String description;
    private String eventType;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    // Constructor
    public Event(int eventId, String eventName, Date eventDate, String location, 
                 String description, String eventType, Timestamp createdAt, Timestamp updatedAt) {
        this.eventId = eventId;
        this.eventName = eventName;
        this.eventDate = eventDate;
        this.location = location;
        this.description = description;
        this.eventType = eventType;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }
    
 // Add this constructor to your Event class
    public Event(int eventId, String eventName, String eventType, String location, Date eventDate) {
        this.eventId = eventId;
        this.eventName = eventName;
        this.eventType = eventType;
        this.location = location;
        this.eventDate = eventDate;
        // Set default values for other fields if needed
        this.description = "";
        this.createdAt = null;
        this.updatedAt = null;
    }


    // Getters
    public int getEventId() {
        return eventId;
    }

    public String getEventName() {
        return eventName;
    }

    public Date getEventDate() {
        return eventDate;
    }

    public String getLocation() {
        return location;
    }

    public String getDescription() {
        return description;
    }

    public String getEventType() {
        return eventType;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    // Setters
    public void setEventId(int eventId) {
        this.eventId = eventId;
    }

    public void setEventName(String eventName) {
        this.eventName = eventName;
    }

    public void setEventDate(Date eventDate) {
        this.eventDate = eventDate;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setEventType(String eventType) {
        this.eventType = eventType;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }
}
