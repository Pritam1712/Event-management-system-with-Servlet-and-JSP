package event;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/EditEventServlet")
public class EditEventServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection conn = DBConnection.getConnection();
        
        int eventId = Integer.parseInt(request.getParameter("event_id"));
        String name = request.getParameter("name");
        String dateStr = request.getParameter("date");
        String location = request.getParameter("location");
        String description = request.getParameter("description");
        String type = request.getParameter("type");

        // Convert date string to SQL Date
        java.sql.Date eventDate = null;
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date parsedDate = sdf.parse(dateStr);
            eventDate = new java.sql.Date(parsedDate.getTime());
        } catch (ParseException e) {
            e.printStackTrace();
            response.sendRedirect("admin-dashboard.jsp?error=Invalid Date Format");
            return;
        }

        // Update event in database
        String query = "UPDATE events SET event_name=?, event_date=?, location=?, description=?, event_type=? WHERE event_id=?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, name);
            stmt.setDate(2, eventDate);
            stmt.setString(3, location);
            stmt.setString(4, description);
            stmt.setString(5, type);
            stmt.setInt(6, eventId);

            int rowsUpdated = stmt.executeUpdate();
            if (rowsUpdated > 0) {
                response.sendRedirect("admin-dashboard.jsp?success=Event Updated");
            } else {
                response.sendRedirect("admin-dashboard.jsp?error=Event Not Found");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("admin-dashboard.jsp?error=Database Error");
        }
    }
}
