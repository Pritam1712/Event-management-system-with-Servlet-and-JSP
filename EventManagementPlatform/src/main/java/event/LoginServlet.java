package event;

import java.io.IOException;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO; // Declare userDAO instance

    @Override
    public void init() { 
        try {
            // Properly initialize UserDAO
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

        if (username == null || password == null || username.isEmpty() || password.isEmpty()) {
            response.sendRedirect("login.jsp?error=Please enter both username and password");
            return;
        }

        try {
            // Authenticate the user based on username and password
            User user = userDAO.authenticateUser(username, password);
            if (user != null) {
                // Start a session if authentication is successful
                HttpSession session = request.getSession();
                session.setAttribute("user_id", user.getUserId()); // Use user_id for consistency
                session.setAttribute("role", user.getRole());
                session.setAttribute("username", user.getUsername());
                session.setAttribute("email", user.getEmail()); // Storing email in session (optional)
                session.setAttribute("name", user.getName()); // Storing name in session (optional)

                // Redirect to appropriate dashboard based on role
                if ("admin".equals(user.getRole())) {
                    response.sendRedirect("admin-dashboard.jsp");
                } else {
                    response.sendRedirect("customer-dashboard.jsp");
                }
            } else {
                // Redirect back to login page if authentication fails
                response.sendRedirect("login.jsp?error=Invalid credentials");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Redirect back to login page with error message
            response.sendRedirect("login.jsp?error=Login failed. Please try again later.");
        }
    }
}
