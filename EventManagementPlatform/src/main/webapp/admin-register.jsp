<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Registration - Event Management Platform</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            background: linear-gradient(rgba(0,0,0,0.1), rgba(0,0,0,0.2)), 
                        url('Images/Admin.jpg') no-repeat center center/cover;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }
        .navbar {
            background-color: #212f3c;
        }
        .navbar-brand {
            color: #fff !important;
            font-size: 1.8rem;
            font-weight: bold;
        }
        .navbar-nav .nav-link {
            color: #fff !important;
        }
        .navbar-nav .nav-link:hover {
            color: #ffd700 !important;
        }
		.form-container {
		    max-width: 600px;
		    margin: auto;
		    margin-top: 100px;
		    margin-bottom: 50px; /* Add space at the bottom */
		    padding: 40px;
		    background-color: rgba(255, 255, 255, 0.9);
		    border-radius: 15px;
		    box-shadow: 0 8px 15px rgba(0, 0, 0, 0.2);
		}

        .form-container h2 {
            text-align: center;
            margin-bottom: 20px;
            color: #212f3c;
        }
        .btn-primary {
            background-color: #ff6f61;
            border-color: #ff6f61;
            transition: all 0.3s ease-in-out;
        }
        .btn-primary:hover {
            background-color: #d45a4a;
            border-color: #d45a4a;
            transform: scale(1.05);
        }
        .logout-btn {
            background-color: #dc3545;
            border: none;
            color: white;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
        }
        .logout-btn:hover {
            background-color: #c82333;
        }
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

    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container">
            <a class="navbar-brand" href="index.jsp">Event Management</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="index.jsp">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="login.jsp">Login</a>
                    </li>

                </ul>
            </div>
        </div>
    </nav>

    <!-- Admin Registration Form -->
    <div class="form-container">
        <h2>Admin Registration</h2>
        <form action="RegisterServlet" method="post">
            <div class="mb-3">
                <label for="username" class="form-label">Username</label>
                <input type="text" name="username" class="form-control" id="username" required>
            </div>
            <div class="mb-3">
                <label for="password" class="form-label">Password</label>
                <input type="password" name="password" class="form-control" id="password" required>
            </div>
            <div class="mb-3">
                <label for="email" class="form-label">Email</label>
                <input type="email" name="email" class="form-control" id="email" required>
            </div>
            <div class="mb-3">
                <label for="name" class="form-label">Full Name</label>
                <input type="text" name="name" class="form-control" id="name" required>
            </div>
            <!-- Hidden field to indicate admin registration -->
            <input type="hidden" name="isAdmin" value="true">
            <button type="submit" class="btn btn-primary w-100">Register as Admin</button>
        </form>
        
        <div class="text-center mt-3">
            <p>Already have an account? <a href="login.jsp">Login here</a></p>
        </div>
    </div>

    <!-- Footer -->
    <footer>
        <p>&copy; 2025 Event Management Platform. All rights reserved.</p>
    </footer>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
</body>
</html>
