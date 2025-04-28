DROP DATABASE IF EXISTS event_management;
CREATE DATABASE event_management;
USE event_management;

-- Users Table
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,  -- Changed id to user_id for consistency
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL, -- Should store hashed passwords
    role ENUM('admin', 'user') NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,  -- Added email column
    name VARCHAR(100) NOT NULL  -- Added name column
);



CREATE TABLE events (
    event_id INT AUTO_INCREMENT PRIMARY KEY,
    event_name VARCHAR(255) NOT NULL,
    event_date DATE NOT NULL,
    location VARCHAR(255) NOT NULL,
    description TEXT,
    event_type ENUM('Conference', 'Wedding', 'Workshop', 'Party', 'Other') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


CREATE TABLE rsvps (
    rsvp_id INT AUTO_INCREMENT PRIMARY KEY,
    event_id INT,
    user_id INT, -- Added user_id column to link RSVPs to users
    status ENUM('Going', 'Not Going', 'Maybe'),
    FOREIGN KEY (event_id) REFERENCES events(event_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE -- Added foreign key reference to users table
);

DROP TABLE IF EXISTS bookings;

-- Create the bookings table
CREATE TABLE bookings (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,                           -- References users table
    event_id INT NOT NULL,                          -- References events table
    number_of_people INT NOT NULL CHECK (number_of_people > 0),  -- Ensure at least 1 person
    booking_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Foreign key constraints
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (event_id) REFERENCES events(event_id) ON DELETE CASCADE
);