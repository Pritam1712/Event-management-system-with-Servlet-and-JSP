<%@ page import="java.util.List, event.Event, event.EventDAO, event.DBConnection" %>
<%
    EventDAO eventDAO = new EventDAO(DBConnection.getConnection());
    List<Event> events = eventDAO.getAllEvents();
    String successMessage = request.getParameter("success");
    String errorMessage = request.getParameter("error");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Event Management Platform</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        /* Background Image */
		body {
		    background-image: url('<%= request.getContextPath() %>/Images/adminback.jpg');
		    background-repeat: no-repeat;
		    background-position: center center;
		    background-size: cover;
		    background-attachment: fixed;
		    font-family: Arial, sans-serif;
		    color: #333;
		    min-height: 100vh;
		    margin: 0;
		    overflow-x: hidden;
		}


        /* Sidebar */
        #sidebar {
            background-color: #f8f9fa;
            height: 100vh;
            position: fixed;
            top: 0;
            left: -250px;
            width: 250px;
            padding: 20px;
            box-shadow: 4px 0 15px rgba(0,0,0,0.1);
            transition: all 0.3s ease-in-out;
            z-index: 1000;
        }
        #sidebar.active {
            left: 0;
        }
        #sidebar h4 {
            color: #007bff;
            margin-bottom: 20px;
        }
        #sidebar a {
            color: #333;
            padding: 12px;
            display: block;
            text-decoration: none;
            margin-bottom: 10px;
            font-weight: bold;
            background-color: rgba(0, 123, 255, 0.1);
            border-radius: 8px;
            transition: background-color 0.3s;
        }
        #sidebar a:hover {
            background-color: #007bff;
            color: #fff;
        }
		#sidebar a.text-danger:hover {
		    background-color: rgba(220, 53, 69, 0.1); /* Lighter red background */
		    color: #dc3545; /* Keep text red for visibility */
		    font-weight: bold;
		    border: 1px solid #dc3545;
		}


        /* Hamburger Icon */
        .hamburger {
            font-size: 2rem;
            cursor: pointer;
            padding: 10px;
            margin-top: 10px;
            color: #007bff;
        }

        /* Main Content */
.main-content {
    margin-left: 0;
    padding: 20px;
    transition: margin-left 0.3s ease-in-out;
    background-color: rgba(255, 255, 255, 0.5); /* Semi-transparent background */
    backdrop-filter: blur(px);
    border-radius: 15px;
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
}
        .main-content.active {
            margin-left: 270px;
        }

        /* Card */
.card {
    background-color: rgba(255, 255, 255, 0.3); /* More transparent than before */
    backdrop-filter: blur(10px); /* Blurred glass effect */
    padding: 20px;
    border-radius: 15px;
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
    border: 1px solid rgba(0, 0, 0, 0.1);
}

        /* Table */
        .table {
            background-color: rgba(255, 255, 255, 0.8);
        }
        .table th, .table td {
            vertical-align: middle;
            border: 1px solid rgba(0, 0, 0, 0.1);
        }
        .table thead {
            background-color: rgba(0, 123, 255, 0.2);
        }
        .table tbody tr:nth-child(odd) {
            background-color: rgba(0, 0, 0, 0.03);
        }
        .table tbody tr:hover {
            background-color: rgba(0, 123, 255, 0.1);
        }
        /* Bold H1 */
h1 {
    font-weight: 800; /* Extra bold */
    text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.2); /* Optional: subtle shadow for depth */
}
        

        /* Buttons */
        .btn-primary, .btn-warning, .btn-danger, .btn-info {
            border-radius: 8px;
            font-weight: bold;
        }
        .btn-warning:hover {
            background-color: #ffc107;
            color: black;
        }
        .btn-danger:hover {
            background-color: #dc3545;
            color: white;
        }
        .btn-info:hover {
            background-color: #0dcaf0;
            color: black;
        }

        /* Alerts */
        .alert {
            font-weight: bold;
            border-radius: 10px;
            backdrop-filter: blur(5px);
        }
    </style>
</head>
<body>

    <!-- Sidebar -->
    <div id="sidebar">
        <h4>Admin Panel</h4>
        <a href="create-event.jsp">Create Event</a>
        <a href="LogoutServlet" class="text-danger">Logout</a>
    </div>

    <!-- Hamburger Menu -->
    <div class="hamburger" onclick="toggleSidebar()">
        &#9776;
    </div>

    <!-- Main Content -->
    <div class="main-content" id="main-content">
        <h1 class="mb-4">Admin Dashboard</h1>

        <!-- Success & Error Messages -->
        <% if (successMessage != null) { %>
            <div class="alert alert-success"><%= successMessage %></div>
        <% } %>
        <% if (errorMessage != null) { %>
            <div class="alert alert-danger"><%= errorMessage %></div>
        <% } %>

        <div class="card p-4">
            <h2>All Events</h2>
            <table class="table table-bordered table-hover mt-3">
                <thead>
                    <tr>
                        <th>Name</th>
                        <th>Date</th>
                        <th>Location</th>
                        <th>Type</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% if (events != null && !events.isEmpty()) { 
                        for (Event event : events) { %>
                        <tr>
                            <td><%= event.getEventName() %></td>
                            <td><%= event.getEventDate() %></td>
                            <td><%= event.getLocation() %></td>
                            <td><%= event.getEventType() %></td>
								<td>
								    <a href="edit-event.jsp?event_id=<%= event.getEventId() %>" class="btn btn-warning btn-sm">Edit</a>
								    <a href="delete-event.jsp?event_id=<%= event.getEventId() %>" class="btn btn-danger btn-sm">Delete</a>
								    <a href="view-rsvp.jsp?event_id=<%= event.getEventId() %>" class="btn btn-info btn-sm">View RSVPs</a>
								    <a href="view-bookings.jsp?event_id=<%= event.getEventId() %>" class="btn btn-primary btn-sm">View Bookings</a>
								</td>

                        </tr>
                    <% } 
                    } else { %>
                        <tr>
                            <td colspan="5" class="text-center">No events found.</td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <!-- Sidebar Toggle Script -->
    <script>
        function toggleSidebar() {
            document.getElementById("sidebar").classList.toggle("active");
            document.getElementById("main-content").classList.toggle("active");
        }
    </script>
    <script>
    function toggleSidebar() {
        document.getElementById("sidebar").classList.toggle("active");
        document.getElementById("main-content").classList.toggle("active");
    }

    // Auto-hide success or error message after 3 seconds
    document.addEventListener("DOMContentLoaded", function() {
        const successAlert = document.querySelector(".alert-success");
        const errorAlert = document.querySelector(".alert-danger");

        if (successAlert) {
            setTimeout(() => {
                successAlert.style.transition = "opacity 0.5s ease-out";
                successAlert.style.opacity = "0";
                setTimeout(() => successAlert.remove(), 500);
            }, 3000);
        }

        if (errorAlert) {
            setTimeout(() => {
                errorAlert.style.transition = "opacity 0.5s ease-out";
                errorAlert.style.opacity = "0";
                setTimeout(() => errorAlert.remove(), 500);
            }, 3000);
        }
    });
</script>
    

</body>
</html>
