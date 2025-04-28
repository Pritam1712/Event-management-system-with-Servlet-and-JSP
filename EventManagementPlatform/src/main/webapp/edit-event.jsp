<%@ page import="java.text.SimpleDateFormat, java.sql.Connection, event.Event, event.EventDAO, event.DBConnection" %>
<%
    int eventId = Integer.parseInt(request.getParameter("event_id"));
    Connection conn = DBConnection.getConnection();
    EventDAO eventDAO = new EventDAO(conn);
    Event event = eventDAO.getEventById(eventId);

    if (event == null) {
        out.println("<h2>Event not found!</h2>");
        return;
    }

    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    String formattedDate = sdf.format(event.getEventDate());
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Event - Event Management Platform</title>
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
            background-color: rgba(255, 255, 255, 0.5);
            backdrop-filter: blur(10px);
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }
        .main-content.active {
            margin-left: 270px;
        }

        /* Card */
        .card {
            background-color: rgba(255, 255, 255, 0.3);
            backdrop-filter: blur(10px);
            padding: 20px;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            border: 1px solid rgba(0, 0, 0, 0.1);
        }

        /* Bold H1 */
        h1 {
            font-weight: 800;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.2);
        }

        /* Buttons */
        .btn-primary, .btn-secondary {
            border-radius: 8px;
            font-weight: bold;
        }
        .btn-secondary:hover {
            background-color: #6c757d;
            color: white;
        }

        /* Form Labels */
        .form-label {
            font-weight: bold;
        }

        /* Input Fields */
        .form-control, .form-select {
            background-color: rgba(255, 255, 255, 0.8);
            backdrop-filter: blur(5px);
            border: 1px solid rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }
    </style>
</head>
<body>

    <!-- Sidebar -->
    <div id="sidebar">
        <h4>Admin Panel</h4>
        <a href="create-event.jsp">Create Event</a>
        <a href="admin-dashboard.jsp">Dashboard</a>
        <a href="LogoutServlet" class="text-danger">Logout</a>
    </div>

    <!-- Hamburger Menu -->
    <div class="hamburger" onclick="toggleSidebar()">
        &#9776;
    </div>

    <!-- Main Content -->
    <div class="main-content" id="main-content">
        <h1 class="mb-4">Edit Event</h1>

        <div class="card p-4">
            <form action="UpdateEventServlet" method="post">
                <input type="hidden" name="event_id" value="<%= event.getEventId() %>">
                
                <div class="mb-3">
                    <label class="form-label">Name:</label>
                    <input type="text" name="name" class="form-control" value="<%= event.getEventName() %>" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Date:</label>
                    <input type="date" name="date" class="form-control" value="<%= formattedDate %>" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Location:</label>
                    <input type="text" name="location" class="form-control" value="<%= event.getLocation() %>" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Description:</label>
                    <textarea name="description" class="form-control" rows="4"><%= event.getDescription() %></textarea>
                </div>

                <div class="mb-3">
                    <label class="form-label">Type:</label>
                    <select name="type" class="form-select">
                        <option value="Conference" <%= event.getEventType().equals("Conference") ? "selected" : "" %>>Conference</option>
                        <option value="Wedding" <%= event.getEventType().equals("Wedding") ? "selected" : "" %>>Wedding</option>
                        <option value="Workshop" <%= event.getEventType().equals("Workshop") ? "selected" : "" %>>Workshop</option>
                        <option value="Party" <%= event.getEventType().equals("Party") ? "selected" : "" %>>Party</option>
                        <option value="Other" <%= event.getEventType().equals("Other") ? "selected" : "" %>>Other</option>
                    </select>
                </div>

                <button type="submit" class="btn btn-primary">Update Event</button>
                <a href="admin-dashboard.jsp" class="btn btn-secondary">Cancel</a>
            </form>
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
