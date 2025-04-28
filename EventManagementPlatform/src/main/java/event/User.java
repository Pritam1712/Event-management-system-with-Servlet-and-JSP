package event;

public class User {
    private int userId;
    private String username;
    private String role;
    private String email;
    private String name;

    // Constructor to include email and name
    public User(int userId, String username, String role, String email, String name) {
        this.userId = userId;
        this.username = username;
        this.role = role;
        this.email = email;
        this.name = name;
    }

    public int getUserId() {
        return userId;
    }

    public String getUsername() {
        return username;
    }

    public String getRole() {
        return role;
    }

    public String getEmail() {
        return email;
    }

    public String getName() {
        return name;
    }
}
