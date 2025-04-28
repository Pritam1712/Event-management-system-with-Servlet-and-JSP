<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Event - Event Management Platform</title>
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
            box-shadow: 4px 0 15px rgba(0, 0, 0, 0.1);
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

        /* Form Elements */
        .form-control, .form-select {
            background-color: rgba(255, 255, 255, 0.6);
            backdrop-filter: blur(10px);
            border-radius: 10px;
            border: 1px solid rgba(0, 0, 0, 0.1);
        }
        .form-control:focus, .form-select:focus {
            box-shadow: 0 0 10px rgba(0, 123, 255, 0.2);
        }

        /* Buttons */
        .btn-primary {
            border-radius: 8px;
            font-weight: bold;
            background-color: #007bff;
            border: none;
        }
        .btn-primary:hover {
            background-color: #0056b3;
        }

        /* Bold H2 */
        h2 {
            font-weight: 800;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.2);
        }
    </style>
</head>
<body>

    <!-- Sidebar -->
    <div id="sidebar">
        <h4>Admin Panel</h4>
        <a href="admin-dashboard.jsp">Dashboard</a>
        <a href="LogoutServlet" class="text-danger">Logout</a>
    </div>

    <!-- Hamburger Menu -->
    <div class="hamburger" onclick="toggleSidebar()">
        &#9776;
    </div>

    <!-- Main Content -->
    <div class="main-content" id="main-content">
        <h2 class="mb-4">Create a New Event</h2>

        <div class="card p-4">
            <form action="CreateEventServlet" method="post">
                <div class="mb-3">
                    <label for="name" class="form-label">Event Name:</label>
                    <input type="text" id="name" name="name" class="form-control" placeholder="Enter event name" required>
                </div>

                <div class="mb-3">
                    <label for="date" class="form-label">Event Date:</label>
                    <input type="date" id="date" name="date" class="form-control" required>
                </div>

                <div class="mb-3">
                    <label for="location" class="form-label">Location:</label>
                    <input type="text" id="location" name="location" class="form-control" placeholder="Enter location" required>
                </div>

                <div class="mb-3">
                    <label for="description" class="form-label">Description:</label>
                    <textarea id="description" name="description" class="form-control" rows="3" placeholder="Enter event description"></textarea>
                </div>

                <div class="mb-3">
                    <label for="type" class="form-label">Event Type:</label>
                    <select id="type" name="type" class="form-select" required>
                        <option value="Conference">Conference</option>
                        <option value="Wedding">Wedding</option>
                        <option value="Workshop">Workshop</option>
                        <option value="Party">Party</option>
                        <option value="Other">Other</option>
                    </select>
                </div>

                <button type="submit" class="btn btn-primary w-100">Create Event</button>
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
</body>
</html>
