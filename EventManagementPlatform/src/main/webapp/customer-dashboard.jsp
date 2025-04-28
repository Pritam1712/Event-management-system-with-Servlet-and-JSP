<%@ page import="java.util.List, event.Event, event.EventDAO, event.RSVP, event.RSVPDAO, event.DBConnection" %>
<%
    EventDAO eventDAO = new EventDAO(DBConnection.getConnection());
    String searchQuery = request.getParameter("search") != null ? request.getParameter("search") : "";
    String eventType = request.getParameter("event_type") != null ? request.getParameter("event_type") : "";
    String eventDate = request.getParameter("event_date") != null ? request.getParameter("event_date") : "";
    List<Event> events = eventDAO.getFilteredEvents(searchQuery, eventType, eventDate);

    if (session == null || session.getAttribute("user_id") == null) {
        response.sendRedirect("login.jsp?error=SessionExpired");
        return;
    }

    int userId = (int) session.getAttribute("user_id");
    RSVPDAO rsvpDAO = new RSVPDAO(DBConnection.getConnection());
    List<RSVP> rsvps = rsvpDAO.getRSVPsByUserId(userId);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Dashboard - Event Management</title>
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
        }

        /* Navbar Styling */
        .navbar {
            background-color: #002244;
            padding: 15px;
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

        /* Main Container */
        .container {
            max-width: 1200px;
            margin-top: 30px;
            flex-grow: 1;
            padding: 20px;
            border-radius: 15px;
        }

        /* Filter Section */
        .filter-form select, .filter-form input {
            margin-right: 10px;
        }

        /* Table Styling */
        .table-container {
            background-color: rgba(255, 255, 255, 0.1);
            padding: 20px;
            border-radius: 15px;
            backdrop-filter: blur(8px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            margin-top: 20px;
        }
        .table {
            background-color: transparent;
            color: white;
            border-collapse: collapse;
        }
        .table thead {
            background-color: #0056b3;
            color: white;
        }
        .table-striped tbody tr:nth-child(odd) {
            background-color: rgba(255, 255, 255, 0.1);
        }
        .table td, .table th {
            border: 1px solid rgba(255, 255, 255, 0.2);
        }
        .rsvp-button {
            background-color: #28a745;
            color: white;
            border: none;
        }
        .rsvp-button:hover {
            background-color: #218838;
        }

        /* Footer */
        footer {
            background-color: #002244;
            color: #fff;
            padding: 20px;
            text-align: center;
            margin-top: auto;
        }
    </style>
</head>
<body>

    <!-- Navbar (Header) -->
<nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container-fluid d-flex justify-content-between align-items-center">
            <a class="navbar-brand" href="customer-dashboard.jsp">Event Management</a>
            <div class="d-flex">
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">

                <!-- Book Event Button -->
                <li class="nav-item">
                    <a class="btn booking-button me-2" href="booking.jsp">Book Event</a>
                </li>

                <!-- Logout Button -->
                <li class="nav-item">
                    <form action="LogoutServlet" method="post">
                        <button type="submit" class="btn logout-button">Logout</button>
                    </form>
                </li>
            </ul>
        </div>
    </div>
</nav>


    <!-- Main Content -->
    <div class="container">
        <h2>Browse Events</h2>
        <form class="filter-form mb-4 d-flex align-items-center" action="customer-dashboard.jsp" method="get">
            <input type="text" name="search" class="form-control me-2" placeholder="Search Events" value="<%= searchQuery %>" style="width: 250px;">
            
            <select name="event_type" class="form-select me-2" style="width: 200px;">
                <option value="">All Types</option>
                <option value="Concert" <%= ("Concert".equals(eventType) ? "selected" : "") %>>Concert</option>
                <option value="Conference" <%= ("Conference".equals(eventType) ? "selected" : "") %>>Conference</option>
                <option value="Workshop" <%= ("Workshop".equals(eventType) ? "selected" : "") %>>Workshop</option>
                <option value="Wedding" <%= ("Wedding".equals(eventType) ? "selected" : "") %>>Wedding</option>
            </select>

            <input type="date" name="event_date" class="form-control me-2" value="<%= eventDate %>" style="width: 200px;">
            <button type="submit" class="btn btn-primary">Filter</button>
        </form>

        <!-- Transparent Table Container -->
        <div class="table-container">
            <table class="table table-striped table-bordered">
                <thead>
                    <tr>
                        <th>Name</th>
                        <th>Date</th>
                        <th>Location</th>
                        <th>Type</th>
                        <th>RSVP</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Event event : events) { %>
                    <tr>
                        <td><%= event.getEventName() %></td>
                        <td><%= event.getEventDate() %></td>
                        <td><%= event.getLocation() %></td>
                        <td><%= event.getEventType() %></td>
                        <td>
                            <form action="RSVPServlet" method="post">
                                <input type="hidden" name="event_id" value="<%= event.getEventId() %>">
                                <select name="status" class="form-select">
                                    <option value="Going" <%= (rsvps.stream().anyMatch(r -> r.getEventId() == event.getEventId() && r.getStatus().equals("Going")) ? "selected" : "") %>>Going</option>
                                    <option value="Maybe" <%= (rsvps.stream().anyMatch(r -> r.getEventId() == event.getEventId() && r.getStatus().equals("Maybe")) ? "selected" : "") %>>Maybe</option>
                                    <option value="Not Going" <%= (rsvps.stream().anyMatch(r -> r.getEventId() == event.getEventId() && r.getStatus().equals("Not Going")) ? "selected" : "") %>>Not Going</option>
                                </select>
                                <button type="submit" class="rsvp-button btn mt-2">RSVP</button>
                            </form>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>

    <footer>
        <p>&copy; 2025 Event Management Platform. All rights reserved.</p>
    </footer>

</body>
</html>
