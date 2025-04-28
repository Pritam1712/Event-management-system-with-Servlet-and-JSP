<%@ page import="java.util.List, event.Event, event.EventDAO, event.DBConnection" %>
<%
    HttpSession session2 = request.getSession(false);
    if (session == null || session.getAttribute("user_id") == null) {
        response.sendRedirect("login.jsp?error=SessionExpired");
        return;
    }

    EventDAO eventDAO = new EventDAO(DBConnection.getConnection());
    List<Event> events = eventDAO.getAllEvents();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book Event - Event Management</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        /* Global Styles */
        body {
            background: linear-gradient(rgba(0,0,0,0.6), rgba(0,0,0,0.6)), url('Images/back.jpg') no-repeat center center/cover;
            font-family: Arial, sans-serif;
            color: #fff;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            justify-content: center; /* Center vertically */
            align-items: center; /* Center horizontally */
        }

        /* Navbar Styling */
        .navbar {
            background-color: #002244;
            padding: 15px;
            width: 100%;
        }
        .navbar-brand {
            font-size: 1.8rem;
            font-weight: bold;
            color: #ffcc00 !important;
        }
        .navbar-nav .nav-link {
            color: #fff !important;
            font-weight: bold;
        }
        .navbar-nav .nav-link:hover {
            color: #ffcc00 !important;
        }
        .logout-button {
            background-color: #dc3545;
            color: white;
            border: none;
            padding: 10px 15px;
            border-radius: 5px;
        }
        .logout-button:hover {
            background-color: #c82333;
        }
        .booking-button {
            background-color: #ffcc00;
            color: black;
            padding: 10px 15px;
            border-radius: 5px;
            font-weight: bold;
        }
        .booking-button:hover {
            background-color: #ffc107;
        }

        /* Main Booking Form (Transparent Section) */
        .booking-form {
            max-width: 600px;
            padding: 20px;
            border-radius: 15px;
            background-color: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(8px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            margin: auto; /* Centers the form vertically and horizontally */
            margin-bottom: 50px; /* Space between form and footer */
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.2);
        }

        /* Form Styling */
/* Form Styling */
.form-control, .form-select {
    background-color: rgba(255, 255, 255, 0.1);
    color: white;
    border: 1px solid rgba(255, 255, 255, 0.2);
}

/* Ensure <option> visibility */
.form-select option {
    background-color: #002244; /* Dark background */
    color: white; /* White text for visibility */
}

/* Placeholder visibility */
.form-control::placeholder, .form-select option:disabled {
    color: rgba(255, 255, 255, 0.6);
}


        .form-label {
            font-weight: bold;
            color: #ffcc00;
        }

        /* Button Styling */
        .btn-primary {
            background-color: #ffcc00;
            color: black;
            border: none;
        }
        .btn-primary:hover {
            background-color: #ffc107;
        }

        /* Error Message */
        .alert-danger {
            background-color: rgba(220, 53, 69, 0.1);
            color: #dc3545;
            border: 1px solid rgba(220, 53, 69, 0.2);
            border-radius: 10px;
        }

        /* Footer */
        footer {
            background-color: #002244;
            color: #fff;
            padding: 20px;
            text-align: center;
            margin-top: auto;
            width: 100%;
        }
    </style>
</head>
<body>

    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container-fluid d-flex justify-content-between align-items-center">
            <a class="navbar-brand" href="customer-dashboard.jsp">Event Management</a>
            <div class="d-flex">
                <!-- Back to Dashboard Button -->
                <a class="btn booking-button me-2" href="customer-dashboard.jsp">Dashboard</a>

                <!-- Logout Button -->
                <form action="LogoutServlet" method="post">
                    <button type="submit" class="btn logout-button">Logout</button>
                </form>
            </div>
        </div>
    </nav>

    <!-- Main Booking Form -->
    <div class="booking-form">
        <h2 class="mb-4 text-center">Book an Event</h2>
        <form action="BookingServlet" method="post">
            
            <div class="mb-3">
                <label for="event_id" class="form-label">Select Event</label>
                <select name="event_id" id="event_id" class="form-select" required>
                    <option value="" disabled selected>Select an event</option>
                    <% for (Event event : events) { %>
                        <option value="<%= event.getEventId() %>"><%= event.getEventName() %></option>
                    <% } %>
                </select>
            </div>
            
            <div class="mb-3">
                <label for="number_of_people" class="form-label">Number of People</label>
                <input type="number" class="form-control" id="number_of_people" name="number_of_people" min="1" placeholder="Enter number of attendees" required>
            </div>
            
            <button type="submit" class="btn btn-primary w-100">Book Now</button>
        </form>

        <br>
        <% if (request.getParameter("error") != null) { %>
            <div class="alert alert-danger text-center">
                <%= request.getParameter("error") %>
            </div>
        <% } %>
    </div>

    <footer>
        <p>&copy; 2025 Event Management Platform. All rights reserved.</p>
    </footer>

</body>
</html>
