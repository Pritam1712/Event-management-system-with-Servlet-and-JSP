package event;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;

    @Override
    public void init() {
        try {
            userDAO = new UserDAO(DBConnection.getConnection()); 
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Failed to initialize UserDAO", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");  // New email field
        String name = request.getParameter("name");    // New name field
        
        // Check if admin registration (this can be passed as a hidden parameter or another secure method)
        String role = "user";  // Default to user role
        String isAdmin = request.getParameter("isAdmin"); // Admin registration flag (e.g., 'true')

        // If admin registration flag is set, set the role as "admin"
        if ("true".equals(isAdmin)) {
            role = "admin";
        }

        try {
            // Register user with email, name, and dynamic role
            boolean success = userDAO.registerUser(username, password, email, name, role);

            if (success) {
                response.sendRedirect("login.jsp?message=Registration successful. Please log in.");
            } else {
                request.setAttribute("error", "Registration failed. Username or email may already be taken.");
                request.getRequestDispatcher("register.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred during registration.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}
