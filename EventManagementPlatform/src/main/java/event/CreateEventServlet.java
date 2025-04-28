package event;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/CreateEventServlet")
public class CreateEventServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("name");
        String dateStr = request.getParameter("date");
        String location = request.getParameter("location");
        String description = request.getParameter("description");
        String type = request.getParameter("type");

        try (Connection conn = DBConnection.getConnection()) {
            String query = "INSERT INTO events (event_name, event_date, location, description, event_type) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, name);
            stmt.setString(2, dateStr);
            stmt.setString(3, location);
            stmt.setString(4, description);
            stmt.setString(5, type);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        response.sendRedirect("admin-dashboard.jsp");
    }
}
